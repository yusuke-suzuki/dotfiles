---
name: sync
description: Sync feature branch with main via rebase
---

# Sync

## 1. Assess state

Run `git status` and `git fetch origin`, detect the default branch (`git symbolic-ref refs/remotes/origin/HEAD --short`), and show unpushed commits (`git log <default>..HEAD --oneline`). Stop and inform the user on the default branch or a detached HEAD — never rewrite history with nowhere to land it.

The working directory must be clean — if not, ask the user to commit or stash first; do not rebase over uncommitted changes.

## 2. Rebase

Run `git rebase <default>`. On conflicts: show the conflicting files (`git status`), have the user resolve them, stage with `git add`, and continue with `git rebase --continue` until done. If conflicts are too complex, the user can `git rebase --abort`.

## 3. Wrap up

Show the rebased history and suggest pushing with `git push --force-with-lease`.
