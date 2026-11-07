---
name: sync
description: Sync feature branch with main via rebase
---

# Sync

## 1. Assess state

Run `git status` and `git fetch origin`, detect the default branch (`git symbolic-ref refs/remotes/origin/HEAD --short`; if unset, run `git remote set-head origin --auto` first), and show unpushed commits (`git log <default>..HEAD --oneline`). Stop and inform the user on the default branch or a detached HEAD — never rewrite history with nowhere to land it.

The working directory must be clean — if not, ask the user to commit or stash first; do not rebase over uncommitted changes.

## 2. Rebase

If the branch has an upstream and `git log HEAD..@{u}` is non-empty, run `git rebase @{u}` first — otherwise the force push below overwrites those commits. Stop instead if `git log --merges @{u}..HEAD` is non-empty: that rebase would drop the merge commits before the check below can see them.

If `git log --merges <default>..HEAD` is non-empty, record `git merge-tree --write-tree <default> HEAD` before rebasing (stop if it fails or reports conflicts) and, after the rebase, confirm `git diff <tree> HEAD` is empty — a non-empty diff is a merge-resolution change the rebase dropped; stop and show it.

Run `git rebase <default>`. On conflicts in this or the upstream rebase (finish the upstream one before starting this one): show the conflicting files (`git status`), have the user resolve them, stage with `git add`, and continue with `git rebase --continue` until done. If conflicts are too complex, the user can `git rebase --abort`, and the skill ends there without suggesting a push.

## 3. Wrap up

Show the rebased history and suggest pushing with `git push --force-with-lease`.
