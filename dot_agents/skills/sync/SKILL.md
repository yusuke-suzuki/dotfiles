---
name: sync
description: Sync feature branch with its base via rebase
---

# Sync

## 1. Assess state

Run `git status` and `git fetch origin`, detect the default branch (`git symbolic-ref refs/remotes/origin/HEAD --short`; if unset, run `git remote set-head origin --auto` first), and resolve `<base>`: `git config branch.<current>.gh-merge-base`, else the pull request's `baseRefName` (`gh pr view --json baseRefName`, or GitHub MCP), else the default branch. `<base-ref>` is `<default>` for the default branch; otherwise whichever of `origin/<base>` and the local `<base>` contains the other, or the one that exists; stop and ask the user if they diverged or neither exists. A base other than the default branch is retired when its pull request is merged. Stop and ask the user when its pull request is closed unmerged, or when `origin/<base>` exists but `git ls-remote --heads origin <base>` is empty without a merged pull request. Stop and inform the user on the default branch or a detached HEAD — never rewrite history with nowhere to land it.

The working directory must be clean — if not, ask the user to commit or stash first; do not rebase over uncommitted changes.

## 2. Rebase

If the branch has an upstream and `git log HEAD..@{u}` is non-empty, run `git rebase @{u}` first — otherwise the force push below overwrites those commits. Stop instead if `git log --merges @{u}..HEAD` is non-empty: that rebase would drop the merge commits before the check below can see them.

`<fork>` is `git merge-base --fork-point <base-ref> HEAD`. If that fails, use `git merge-base <base-ref> HEAD` for the default branch; for any other base, stop and ask the user for the fork point. `<onto>` is `<base-ref>`, or for a retired base the merged parent pull request's own base (`<default>` for the default branch, else `origin/<that base>`).

If `git log --merges <fork>..HEAD` is non-empty, stop and leave the rebase to the user on git older than 2.40; otherwise record `git merge-tree --write-tree --merge-base <fork> <onto> HEAD` before rebasing (stop if it fails or reports conflicts) and, after the rebase, confirm `git diff <tree> HEAD` is empty — a non-empty diff is a merge-resolution change the rebase dropped; stop and show it.

Run `git rebase --onto <onto> <fork>`. On conflicts in this or the upstream rebase (finish the upstream one before starting this one): show the conflicting files (`git status`), have the user resolve them, stage with `git add`, and continue with `git rebase --continue` until done. If conflicts are too complex, the user can `git rebase --abort`, and the skill ends there without suggesting a push.

## 3. Wrap up

Show the rebased history and suggest pushing with `git push --force-with-lease`. For a retired base, only after that push succeeds, point `branch.<current>.gh-merge-base` at the new base (`git config --unset` it for the default branch) and retarget the pull request there if one exists.
