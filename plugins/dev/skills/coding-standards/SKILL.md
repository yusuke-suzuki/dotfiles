---
name: coding-standards
description: Standards for writing, editing, or reviewing code, and for every git/GitHub operation in development — branch, commit, push, pull request, issue, review/CI feedback, sync, squash. Load before any code change, however small, and before any git/GitHub operation, even for a bare "commit" or "push", and even when the repository has its own git rules.
---

# Coding Standards

## Code

- Set the ideal design as the goal before treating existing code as a constraint. Existing code is evidence of what works today, not a standard to build on: when its structure makes a requirement awkward, change the structure instead of patching around it or stacking complexity on top. Meeting the literal request on a flawed foundation is not done.
- Never base a technical decision on the project's existing practice. "The codebase already does it this way" is no reason to choose an approach, and neither is any precedent found in the code; justify every decision on its own merits, such as the requirement, correctness, or the framework's documented approach. A practice that fails that test is something to change, not to follow.
- Distance to the ideal is no reason to drop it. Plan the path (preparatory refactors first, as separate commits); when it exceeds the request's scope, present the ideal and the path to the user instead of silently settling for the patch.
- Never mix a structural change (a refactoring) and a behavioral change (a feature or a fix) in one commit, whether or not the refactoring prepares for the change.
- Leave code you work in cleaner than you found it, but never mix a cleanup the request does not need into the requested change: put it in its own commit, or in its own pull request when the branch rules below call for one.
- Match surrounding code in naming and idiom once it is raised to standard.
- Do not use class inheritance; compose behavior through delegation instead. Subclassing a base class the framework requires (e.g. `ApplicationRecord`) is the only exception.
- Prefer the framework's generators, CLI tools, and built-in APIs over hand-written boilerplate or third-party alternatives.
- Fix lint failures instead of suppressing them. A suppression requires first ruling out an alternative implementation, and an inline comment stating the reason.

## Data model

- Design tables as immutable by default, following https://scrapbox.io/kawasima/イミュータブルデータモデル. Record what happened as insert-only rows and derive current state from them instead of updating status or flag columns in place. Physical deletion required to remove personal data takes precedence.
- It is a principle, not a goal: do not let it produce a design or operation more complex than the problem needs.

## Tests

- Verify each behavior in a test case of its own, named after that behavior, instead of packing several behaviors into one case: the first failure stops the case and hides the rest, and the case's name cannot say which behavior broke. Several assertions on one behavior, such as the fields of one result, still belong in one case.

## Comments

- Write zero code comments. A comment is a last resort, reached only after every alternative has failed to carry the information: a more precise name, an extracted function or named constant, restructured control flow, a type or signature, a test that states the expectation, a commit message, a pull request description, or documentation. Before writing one, name which of those you tried and why each cannot hold the fact; if you cannot name it, there is no comment to write.
- Only a WHY that survives that elimination is admissible: an external constraint invisible from the code (an upstream bug, a protocol or vendor quirk, a deliberate deviation from the obvious approach). Treat "this is a WHY, so it is fine" as the failure mode this rule exists to prevent — most WHYs belong in a commit message or documentation, which the code does not have to carry. Apply the deletion test from the reader's side: if a competent reader loses nothing when the comment is removed, remove it.
- Never comment: WHAT the code does; documented behavior of the language, standard library, or well-known frameworks and tools (anything a reader finds in seconds in official docs); or the current task, fix, or PR. Never match surrounding comment density — a heavily commented file does not justify more or longer comments. When a comment is warranted, keep it to the shortest sentence that states the fact.
- These rules bind edits to existing code as much as new code: never add a comment while touching nearby lines, and delete comments that fail the test when you are already editing that code.

## Git Workflow

Use the matching skill for these history operations, even when a prompt just says "commit" or "pull":

- New branch → `/branch`
- New change → `/commit`
- Fix to a commit on the branch (review, CI) → `/fixup`
- Feature branch behind its upstream or its base branch → `/sync`, never merge
- Branch into one commit → `/squash`

Approval prompts (e.g. force push) are no reason to leave a skill.

These git rules and the skills they route to take precedence over repository-specific skills, instructions (`CLAUDE.md`, `AGENTS.md`), and existing conventions where they conflict. A repository's own commit or pull request rules are no reason to skip them.

### Branches

- A branch assigned by the harness (e.g. a cloud session's development branch) is a default, not a limit: this rule is standing, explicit permission to create and push other branches.
- Never commit to an assigned branch with a generated name unless it is already the head of an open pull request.
- Follow-up requests in a session continue on the current branch as separate commits by default, even when they could be merged or reverted alone.
- Start another branch with `/branch` when the user asks to split the work, when a change must be merged or released separately from the rest (e.g. an API that ships before its client, a migration deployed before the code that relies on it), when groundwork such as a preparatory refactoring is better reviewed and merged on its own, or when the current branch's pull request is merged or closed. Each extra pull request costs review time, so split only when separate review or merge is worth it. When splitting, name the reason to the user.

### Pull requests

- Create pull requests as draft, targeting the branch's `gh-merge-base` when set (GitHub MCP does not read it), pushed first, and run `/sync` first if that parent's pull request is merged or closed, with the most representative commit subject line as the title, verbatim; fill the repository's pull request template for the body. After later pushes, if the description no longer matches the final diff, rewrite it against that diff — never append changelog-style updates.

### Publishing

- Before editing anything already on the remote (pull request description or title, issue body, review comment, pushed commit message), fetch its current state first (`gh pr view`, `gh issue view`, `git fetch && git show origin/<branch>`). Session memory is not a substitute — the remote may have changed since it was last seen.
- Before publishing Japanese text (a pull request title or description, an issue, a review reply), run the `textlint` skill on it and fix every reported violation, including the detect-only rules that need manual edits (particle errors, sentence style).
- Issues, PRs, and comments on public repositories must not leak private context: internal repository/PR/issue references, team workflow details, or PII. Describe intent generically.

### Review and CI feedback

- Verify the flagged scenario can actually occur (spec, naming constraints, type system, invariants). If it cannot, the verdict is "No change" citing the constraint.
- Read the relevant code, assess the feedback's validity and trade-offs, and weigh it against the design intent — do not accept suggestions uncritically.
- Commit and push fixes before posting any reply — invoke `/fixup` (or `/commit` for an independent change), then push (`--force-with-lease` after a fixup rebase).
- Reply in the language of the comment being answered.
- **Answer what was actually said.** A question gets a direct answer, a proposed alternative gets an explicit accept-or-reject with the reason, a misreading gets the correction. Open by naming, in your own words, the concern being answered — a verdict with no visible connection to the comment reads as a non-answer — then give the verdict and its reasoning.
- **Write in the user's voice.** Replies post under the user's account; write as the account owner addressing a colleague, in the register the user's own comments use, and avoid assistant mannerisms a colleague would not type by hand. Natural register never overrides the requirements above; it is how they read, not a license to omit.
- Post replies to bots directly. Show replies to humans to the user and post them only after approval.
- Do not resolve threads: review bots that verify fixes (e.g. coderabbitai) resolve their own threads once the pushed fix is verified, and all other threads are resolved manually outside this skill.
