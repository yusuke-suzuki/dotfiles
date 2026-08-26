---
name: commit
description: Create a git commit with Conventional Commits format. Invoke as soon as changes are ready — branch creation, staging, and message authoring are all part of this workflow.
---

# Commit

Message conventions live in `commit-message.md` in this skill's base directory — read it before drafting any message.

## 1. Assess state

Run `git status` and `git fetch origin`, detect the default branch (`git symbolic-ref refs/remotes/origin/HEAD --short`), and review the changes (`git diff`, `git diff --staged`). On a feature branch, show `git log <default>..HEAD --oneline`.

## 2. Branch

Never commit to the default branch.

- **On the default branch:** derive a descriptive branch name from the changes (e.g. `feat/add-login`), create it with `git switch -c`, and announce the choice. Never switch to an existing branch; on a name conflict, pick an alternative.
- **On a feature branch with unrelated existing commits** (leftover from a different task): announce the mismatch, then branch off the latest remote default (`git switch -c <name> <default>`) so the work does not pass through the local default branch. Ask the user if relatedness is unclear.

## 3. Commit

- Group changes by semantic intent — one logical change per commit; create one commit per group.
- If the diff adds or edits Japanese text (code comments, docstrings, test case titles, documents), run the `textlint` skill on it before committing.
- Never stage files containing secrets (.env, credentials, private keys).
- Write the drafted message to a file and run `{SKILL_BASE_DIR}/scripts/validate-message.sh <file>` — fix every `NG`, judge each `CHECK`, re-run until it passes, then commit with `git commit -F <file>`. It checks format only; the body explaining the why (per `commit-message.md`) is on you.
- Do not use past `git log` messages as a style guide, and never use `--fixup` or `--amend` here — `/fixup` owns those.
