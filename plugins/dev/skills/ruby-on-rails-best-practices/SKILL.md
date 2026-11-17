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

### Transactions

- Never open an explicit `transaction` block. Let the transaction ActiveRecord opens around `save`/`destroy` carry multi-record writes: put dependent writes in callbacks or `autosave` associations of the record being saved.

### External calls

Decide where an external call goes by which failure can be detected and corrected.

- A call whose outcome the saved state asserts (deleting or creating a resource at an external service the record points to) runs inside the transaction, before the write it guards, so that its failure raises and rolls the write back instead of committing a state that is not true. Make it idempotent so that a retry corrects the opposite failure, where the call succeeded and the commit did not, and give it a short timeout, because it holds the transaction open.
- A call that only reports a committed fact (mail, Web Push, notifications) runs in `after_commit` or a job. Sent from inside the transaction, it cannot be taken back when the transaction rolls back.

### Validations

- Use Rails' built-in validators (`presence`, `inclusion`, `comparison`, `format`, `length`, `numericality`, ...) whenever they can express the rule, and write a custom `validate` method only when they cannot. Back every integrity rule with a database constraint (NOT NULL, unique index, foreign key), because validations alone race.
- Enforce uniqueness with a unique index alone, never a `uniqueness` validation: a repeated write is made idempotent by rescuing `ActiveRecord::RecordNotUnique`, which the validation preempts with a validation error.

### Immutable data model

- Design tables as immutable by default, following https://scrapbox.io/kawasima/イミュータブルデータモデル. Record what happened as insert-only rows and derive current state from them instead of updating status or flag columns in place. Physical deletion required to remove personal data takes precedence.
- It is a principle, not a goal: do not let it produce a design or operation more complex than the problem needs.

### Locking

- Keep transactions short: a migration's DDL waits for the metadata lock (MDL) held by any open transaction on the table, and every later query on that table queues behind it. Do not reach for `lock!`/`with_lock` first; prefer a unique index, an insert-only design, or optimistic locking (`lock_version`), and take a row lock only when none of these can serve.

### Callbacks and validations

- Do not write through methods that skip them, such as `update_column`, `update_columns`, `update_all`, `delete`, `delete_all`, `insert_all`, `upsert_all`, `touch_all`, `update_counters` and `increment_counter`. Write through `create!`, `update!`, `save!` and `destroy!`, so that every write runs the validations and callbacks the model keeps its invariants with, and a callback added later reaches every existing write path. If a skipping method seems unavoidable, state why in the PR description. Tests are exempt when they use one to set up a state the application cannot reach, such as a backdated `created_at` or a reference to a record that no longer exists.

## N+1 Queries

- Avoid N+1 queries with `preload`, not `includes` or `eager_load`. Of the three, `preload` states its intent most plainly, which is to load these associations for the records already selected, and its behavior is the easiest to predict: it always runs one separate query per association. `includes` switches to a JOIN when the relation references the association's table, so its queries depend on the rest of the chain. `eager_load` always joins, so the association's rows can change which rows the main query returns.
- Write the `preload` inline in the controller action, on the relation whose records the action serializes. Do not wrap it in a scope, a model method, or a helper method.
