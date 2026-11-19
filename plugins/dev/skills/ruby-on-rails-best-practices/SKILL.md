---
name: ruby-on-rails-best-practices
description: Ruby on Rails conventions. Load before writing or reviewing Rails code, or running rails, rspec, rubocop, rake, or other gem executables.
---

# Ruby on Rails Best Practices

- Run project commands through binstubs (`bin/rails`, `bin/rspec`, `bin/rubocop`) or `bundle exec`, never bare gem executables — bare ones can resolve to a stale shim or a version that does not match `Gemfile.lock`.
- When adding new features, adhere to the Rails "Convention over Configuration" philosophy.

## Models

### Domain logic

- Do not create service classes (Service Objects). Business logic should primarily reside in models. For logic tied to a database table, use an ActiveRecord model. For logic not directly tied to a table, create a plain Ruby model (a class that does not inherit from `ApplicationRecord`).
- Gather domain logic in models through the Active Model APIs, such as validations and callbacks, rather than in code that calls them.
- Do not add calls to existing service classes either. When the logic you need lives only in one, move it into a model first, as a separate structural commit.

### Transactions

- Never open an explicit `transaction` block. Let the transaction ActiveRecord opens around `save`/`destroy` carry multi-record writes: put dependent writes in callbacks of the record being saved.
- Keep transactions short: a migration's DDL waits for the metadata lock (MDL) held by any open transaction on the table, and every later query on that table queues behind it.

### External resources

- Create or delete a resource at an external service that a record points to inside the transaction, before the write that records it, so that a failed call raises and rolls the write back instead of committing a state that is not true.
- Make the call idempotent: when it succeeds and the commit fails, a retry repeats it, and the repeat must succeed.
- Give the call a short timeout, since it holds the transaction open.

### Notifications

- A call that only reports a committed fact (mail, Web Push, notifications) runs outside the transaction. Sent from inside the transaction, it cannot be taken back when the transaction rolls back.
- A job enqueued with `deliver_later` or `perform_later` from a callback inside the transaction already runs outside it: Active Job holds the enqueue until the transaction commits, so a rolled-back transaction enqueues nothing. This needs `enqueue_after_transaction_commit` enabled on `ActiveJob::Base`, so that it also covers mail delivery jobs, which do not inherit from `ApplicationJob`.
- Jobs pushed through Sidekiq's own API (`Sidekiq::Job.perform_async`) bypass Active Job and are enqueued at once, even inside a transaction: push them from `after_commit`, or enable `Sidekiq.transactional_push!`.

### Validations

- Use Rails' built-in validators (`presence`, `inclusion`, `comparison`, `format`, `length`, `numericality`, ...) whenever they can express the rule, and write a custom `validate` method only when they cannot. Back every integrity rule with a database constraint (NOT NULL, unique index, foreign key), because validations alone race.
- Enforce uniqueness with a unique index alone, never a `uniqueness` validation: a repeated write is made idempotent by rescuing `ActiveRecord::RecordNotUnique`, which the validation preempts with a validation error.

### Immutable data model

- Design tables as immutable by default, following https://scrapbox.io/kawasima/イミュータブルデータモデル. Record what happened as insert-only rows and derive current state from them instead of updating status or flag columns in place. Physical deletion required to remove personal data takes precedence.
- It is a principle, not a goal: do not let it produce a design or operation more complex than the problem needs.

### Locking

- Do not reach for `lock!`/`with_lock` first; prefer a unique index, an insert-only design, or optimistic locking (`lock_version`), and take a row lock only when none of these can serve.
- Like `preload`, a row lock is the caller's concern: take it with `with_lock` in the controller action, job, or task that needs it, never inside a model method. This is the one exception to opening a transaction explicitly; `lock!` outside a transaction releases the lock immediately.

### Callbacks and validations

- Do not write through methods that skip them, such as `update_column`, `update_columns`, `update_all`, `delete`, `delete_all`, `insert_all`, `upsert_all`, `touch_all`, `update_counters` and `increment_counter`. Write through `create!`, `update!`, `save!` and `destroy!`, so that every write runs the validations and callbacks the model keeps its invariants with, and a callback added later reaches every existing write path. If a skipping method seems unavoidable, state why in the PR description. Tests are exempt when they use one to set up a state the application cannot reach, such as a backdated `created_at` or a reference to a record that no longer exists.

## N+1 Queries

- Avoid N+1 queries with `preload`, not `includes` or `eager_load`. Of the three, `preload` states its intent most plainly, which is to load these associations for the records already selected, and its behavior is the easiest to predict: it always runs one separate query per association. `includes` switches to a JOIN when the relation references the association's table, so its queries depend on the rest of the chain. `eager_load` always joins, so the association's rows can change which rows the main query returns.
- Write the `preload` inline in the controller action, on the relation whose records the action serializes. Do not wrap it in a scope, a model method, or a helper method.

## Logging

- Log structured events: a message plus key-value fields, never values interpolated into a string.
- The message is for people reading the log, not for search: put each value to filter or aggregate on in a field of its own.
- Log an exception at error level with the fields the logging backend expects (for Datadog, `error.kind`, `error.message`, `error.stack` and a `service` attribute), so the backend's standard error tracking groups and alerts on it without custom parsing.

## Rake Tasks

- Keep domain logic in models, as above; the task body itself may then be a plain procedural sequence of model calls, which keeps a one-off maintenance task easy to follow.
- Leave declared task arguments out of `desc`: `rake -T` already lists them.
- Log progress and failures as structured events, as above.
- Set `runtime: task.name` as a default field of every log the task writes, through the logger's context or tags, and leave the task name out of each message.
- Stop on an invalid argument or an unmet precondition with `abort` and a message saying what is wrong, not with `raise`: it is the operator's input to fix, not a bug, and a backtrace only buries the message.
- Never swallow an exception: do not rescue it only to log and exit successfully. Let it propagate so the task exits non-zero.
- Process records fail-fast: do not rescue an exception per record to carry on with the rest. One failing record usually means something is wrong, and continuing turns it into a flood of the same error.
- Do not raise to mark a run as failed once it has finished without an exception. When it finishes but some records need attention, such as a record the code skips because its state is unexpected, log each as a structured event at error level so it is detected, and let the task exit successfully.
- Rescue an exception to log it as a structured error event, with context such as the record being processed, since Rake reports an uncaught one only as plain text on stderr; end that rescue with a bare `raise`. A rescue that handles the error, such as `ActiveRecord::RecordNotUnique` for idempotency, is not covered.
- Leave retries and alerting to what triggered the task (a cron job or a scheduler) and configure them there, since a trigger such as plain cron neither retries nor alerts by default; do not retry inside the task.
- Make a task safe to rerun from the start, since a retry repeats all of it, including side effects that ran before the failure.
