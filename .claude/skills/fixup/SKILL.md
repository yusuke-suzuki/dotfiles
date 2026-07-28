---
name: fixup
description: Create a fixup commit and autosquash rebase
---

# Fixup

## 1. Assess state

Run `git status` and `git fetch origin`, detect the default branch (`git symbolic-ref refs/remotes/origin/HEAD --short`), and list commits (`git log <default>..HEAD --oneline`).

## 2. Identify target

- One commit on the branch → the target is HEAD.
- Multiple commits → match the current changes against each commit's diff. If no target is identifiable: for a new independent change, invoke `/commit`; for history needing consolidation, invoke `/squash`, then re-run `/fixup`.

## 3. Fixup and rebase

`git add <files>`, then `git commit --fixup=<target-hash>`, then `git rebase --autosquash <default>`.

## 4. Message review

Run `git show HEAD` and read `~/.claude/skills/commit/commit-message.md`, especially "After /fixup". Evaluate whether the existing message still describes the final diff as a single coherent unit — it often does. Amend (`git commit --amend`) only if it doesn't, drafting against the final diff, not the iteration history.

## 5. Wrap up

Show `git log <default>..HEAD --oneline` and suggest `/publish`.
