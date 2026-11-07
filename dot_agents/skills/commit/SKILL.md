---
name: commit
description: Create a git commit with Conventional Commits format. Invoke as soon as changes are ready — staging and message authoring are part of this workflow.
---

# Commit

Message conventions live in `commit-message.md` in this skill's base directory — read it before drafting any message.

## 1. Assess state

Run `git status` and `git fetch origin`, detect the default branch (`git symbolic-ref refs/remotes/origin/HEAD --short`; if unset, run `git remote set-head origin --auto` first), and review the changes (`git diff`, `git diff --staged`). On a feature branch, show `git log <default>..HEAD --oneline`.

## 2. Branch

Never commit to the default branch. Invoke `/branch` first when on the default branch, or when the change is independent of the branch's existing commits.

## 3. Commit

- Group changes by semantic intent — one logical change per commit; create one commit per group.
- If the diff adds or edits Japanese text (code comments, docstrings, test case titles, documents), run the `textlint` skill on it before committing.
- Never stage files containing secrets (.env, credentials, private keys).
- Write the drafted message to a file and run `~/.agents/skills/commit/scripts/validate-message.sh <file>` — fix every `NG`, judge each `CHECK`, re-run until it passes, then commit with `git commit -F <file>`. It checks format only; the body explaining the why (per `commit-message.md`) is on you.
- Do not use past `git log` messages as a style guide, and never use `--fixup` or `--amend` here — `/fixup` owns those.
