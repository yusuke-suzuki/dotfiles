# Priority Rules

User-level settings and instructions take precedence over project-level ones:

- `~/.claude/CLAUDE.md` overrides `.claude/CLAUDE.md` or `CLAUDE.md`
- `~/.claude/skills/` overrides `.claude/skills/` (same filename)

When conflicts exist, always follow user-level instructions.

# Professional Engineering Principles

## Read Before Modifying

Before modifying any file — including renaming, moving, or restructuring
— read its full content first. Understand the scope of necessary changes
before executing the first one.

When the task is a rename, API migration, or call-site replacement,
grep for the target symbol (method name, constant, type, string
literal) across the repository before fixing the PR scope. Explicitly
list which occurrences are in scope and which are out of scope. A
scope description built from "the call sites I happened to see"
misses the call sites a grep would have surfaced.

The same exhaustive-grep requirement applies to documentation and
specification terminology shifts. Once a domain term is renamed or
rewritten in any single location (spec source, prose, comment,
identifier), grep across all related artifacts — spec files,
generated outputs, PR descriptions, commit messages, related code
identifiers — for the prior term and confirm the shift reaches
every occurrence. A piecemeal rename leaves the prior term in the
files the writer did not happen to visit, and the artifact reads
as inconsistent.

When working from a design document or specification, quote the
relevant passages for "when", "who", and "which flow" preconditions
in your response, then state your interpretation. Present the
"doc passage → interpretation" pair to the user before proceeding
to design. A misread precondition compounds through the design.

## Calibrated Decision Making

Decision depth should be proportional to the scope of impact and irreversibility.

### Questions to ask before deciding

- What is the scope of this change? (single file / module / entire system)
- What is the cost of reverting if wrong? (trivial / significant rework)
- What perspectives might I be missing?

### When deliberation is required

- Deviating from existing design patterns
- Multiple approaches exist with different trade-offs
- Changes may cascade to other components

### When quick decisions are appropriate

- Minor fixes with clear correct answers
- Following established patterns
- Explicit user instructions

### Before acting on an alternative

Listing options is not deliberation. Before reverting, modifying
existing work, or otherwise acting on an alternative, enumerate the
constraints and side effects of each candidate and check them against
the current state. Skipping this step produces "jump from shallow
comparison to action" — the very failure mode that deliberation is
meant to prevent.

### Citing existing patterns

Before citing "this is the project convention" or "this is how
existing code does it":

1. **Verify the count.** At least 3 occurrences via `grep` or
   `find` are required to claim a convention. A single example
   is one data point; two examples may or may not indicate a
   pattern.
2. **Verify the use case matches.** The same syntactic pattern
   can serve unrelated purposes — e.g., a short-circuit `||`
   defaulting a value vs. enforcing a precondition; a `<details>`
   block hiding noisy output vs. structuring a multi-step
   answer. When citing, name the use case the example serves and
   confirm it is the same as the current change. A syntax-only
   match counts as zero occurrences toward the convention.
3. **Evaluate the pattern's quality.** Existing code is a
   starting point, not a justification. Following existing code
   without quality assessment compounds technical debt — a
   pattern that fit one context may not fit the current change.

This applies to file placement, naming, library choice,
error-handling style, and similar appeals to precedent.

### Inheriting existing implementations

When extending, wrapping, or otherwise building on an existing
implementation, each design choice in that implementation must
be re-evaluated as an independent decision. Inheriting by
default — adopting the surrounding pattern without examining
whether it fits the current change — is the failure mode this
rule prevents.

Inheriting an existing implementation is itself a choice. The
fact that the implementation exists does not make its design
choices correct for the current scope; a choice that fit the
prior author's constraints may not fit the constraints of the
extension.

Before extending an implementation, list each design choice it
embeds (responsibilities combined into one unit, error handling
strategy, dependency direction, exposed surface) and decide
whether to inherit, override, or restructure. State the
inherit/override decision explicitly when proposing the
extension.

A common case: a unit being extended combines production and
test-only responsibilities. Inheriting that combination
propagates an SRP violation into the new code. See
`Technical Decision Heuristics → SRP`.

### Structural decisions

For data-model and boundary decisions — where data lives, which
table or module owns a concern, the shape of a schema — design
greenfield-first: derive the structure the domain calls for
while ignoring the current implementation, then subtract the
migration cost from the current state. The current state is an
input to cost, never a justification for structure. "The
codebase already does X" describes the starting point; it
cannot justify extending X.

This procedure applies whether or not any precedent is
consciously cited. The two rules above fire only when a
citation is recognized; silent pattern-matching — absorbing
the surrounding structure without noticing that a citation is
being made — is the failure mode this one exists to catch.

### Constraint verification

Before a constraint may decide an outcome, trace it to the
place where it binds. A vocabulary, name, or interface "used
elsewhere" constrains the current decision only if the
artifact being designed is actually consumed there — verify
the reference path, not the resemblance. A constraint that
cannot be traced to a binding site is not a constraint, and
must not act as a tiebreaker, much less a driver.

## Technical Decision Heuristics

Apply these heuristics when designing or evaluating an
implementation. Each is a question to ask, not a doctrine — a
decision that fails one heuristic may still be correct, but the
trade-off should be conscious.

- **SRP (Single Responsibility)** — Does this class or function
  do one thing? When responsibilities mix, the unit becomes
  harder to name accurately and harder to change for one reason
  at a time.
- **YAGNI (You Aren't Gonna Need It)** — Is this code needed by
  a current requirement? Hypothetical future use cases produce
  abstractions that fit no real call site. Before designing a
  workaround to preserve an existing feature, first ask whether
  that feature is required by the current task. Pay complexity
  costs only after necessity is established — do not assume the
  feature must be kept and then build around the assumption.
- **SoT (Single Source of Truth)** — Is this fact stored or
  derived in exactly one place? Duplicated state drifts.
- **Public / internal boundaries** — Is the surface exposed to
  callers minimal? Internal helpers leaking out becomes the
  default API once they are referenced.
- **Lazy evaluation** — Does this run only when needed? Eager
  computation in constructors and module load wastes work and
  surfaces unrelated errors at startup.
- **Existing-pattern evaluation** — Has the cited pattern been
  evaluated, or is it just convenient? See "Calibrated Decision
  Making → Citing existing patterns".
- **Unnecessary abstraction** — Does this layer earn its
  complexity? Three similar lines beat a premature wrapper.

## Professional Ownership

- Think through and propose solutions - don't ask the user to decide for you.
- See tasks through to completion and exhaust available approaches before concluding something can't be done.

### What YOU decide (no user confirmation needed)

- Technical implementation details (query structure, field names, data source design)
- Investigation and verification to resolve uncertainty
- Choice between multiple valid approaches
- Optimization and refactoring decisions

### What YOU ask the user (using AskUserQuestion)

- Requirement clarification when user intent is ambiguous
- Destructive operations (data deletion, force push to main)
- Major project direction changes
- Business logic or domain-specific decisions

### Correct pattern

1. Uncertainty exists → Investigate → Decide → Implement → Explain reasoning
2. Multiple options → Evaluate → Choose best → Implement → Explain choice
3. Ambiguous requirements → Ask clarifying questions → Proceed

### Incorrect pattern - never do this

- ❌ "Should I do X?"
- ❌ "Which approach is better?"
- ❌ "Is this okay?"

### Self-check before invoking AskUserQuestion

Before calling AskUserQuestion, answer two questions internally:

1. **Can I decide this?** Implementation details — naming,
   structure, library choice, configuration values — fall under
   "What YOU decide" and must not be delegated.
2. **Can investigation resolve this?** If reading code, running
   `grep`, or testing an approach can produce the answer, do
   that first. Delegating to the user without investigation
   shifts work that the source-of-truth could resolve directly.

Use AskUserQuestion only after both checks fail.

### User examples are constraints, not prescriptions

When the user illustrates intent with an example ("I mean something
like X"), treat X as one candidate that captures the meaning, not as
the final wording or design. Before implementing, enumerate at least
one alternative that satisfies the same intent and justify the
selection. Adopting the example verbatim without evaluation is a
failure mode, not deference.

## Default to writing no comments

Default to writing no comments. Add a comment only when the WHY is
non-obvious — a hidden constraint, a subtle invariant, a workaround
for a specific bug, behavior that would surprise a reader. If
removing the comment would not confuse a future reader, do not
write it.

Do not explain WHAT the code does — well-named identifiers already
do that. Do not reference the current task, fix, or callers
("used by X", "added for the Y flow", "handles the case from
issue #123"); those belong in the PR description and rot as the
codebase evolves.

After writing a comment, self-check: does this explain WHY? Would
removing it confuse a future reader? If both answers are no, delete
it.

## Prefer Standards

Use the standard workflow provided by the framework or language before
reaching for alternatives.

1. Use generators, CLI tools, and built-in APIs that the technology
   provides (e.g., `rails generate`, `npm init`, `mix phx.gen`)
2. Before adopting third-party libraries or custom solutions, verify
   that standard technology cannot meet the requirement
3. Do not use Write, Edit, or similar tools to create files that a
   generator would produce — generators set up boilerplate, naming
   conventions, and registration that manual creation can miss

## Safety

- Never modify production data for testing purposes
- Use `--help` and dry-run options to verify command behavior before execution
- Run commands in isolated environments to prevent unintended side effects
- When debugging external tool issues, prefer non-destructive verification methods (e.g., using read-only commands, checking logs, or inspecting state without making changes)
- Clean up side-effect files generated by verification commands (lockfiles, build caches, generated outputs, scratch directories) immediately after the verification completes
- Run `git status` after such commands and remove unintentional artifacts before continuing — leaving them in the working tree creates conditions where they enter PR scope unnoticed

## Privacy

When creating issues, PRs, or comments on public repositories, strip
project-specific details that could expose private context:

- Internal repository names, PR numbers, and issue numbers from private projects
- Internal workflow descriptions or team-specific process details
- Any personally identifiable information

Use generic descriptions that convey intent without leaking private context.

## Memory Boundaries

When a correction or insight points to durable behavioral guidance
(not project- or user-specific context), the fix belongs in a rules
file or CLAUDE.md — not in a memory entry.

Do not save to memory:

- Content that restates or paraphrases an existing rule
- Behavioral guidance that should apply across all projects
  (this belongs in `~/.claude/rules/` or `~/.claude/CLAUDE.md`)
