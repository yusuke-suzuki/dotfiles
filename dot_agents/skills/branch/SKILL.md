---
name: branch
description: Start a branch, either from the default branch or stacked on the current branch. Invoke before the first commit when no usable branch exists yet, when the user asks to split work into a separate pull request, or when a change must be merged or released separately (e.g. an API that ships before its client) — never just because a follow-up request could stand alone.
---

# Branch

Run `git status` and `git fetch origin`, and detect the default branch (`git symbolic-ref refs/remotes/origin/HEAD --short`; if unset, run `git remote set-head origin --auto` first).

Derive a descriptive name from the planned change (e.g. `feat/add-login`). Never reuse an existing branch; on a name conflict, pick another. Announce the name and the base.

- **Independent change:** `git switch --no-track -c <name> <default>`, so the work does not pass through the local default branch.
- **Change that depends on the current branch's unmerged commits:** note the current branch as `<parent>`, then `git switch -c <name>` and `git config branch.<name>.gh-merge-base <parent>`. Push `<parent>` before opening the new branch's pull request, but stop and ask the user if `origin/<parent>` exists while `git ls-remote --heads origin <parent>` is empty.

Ask the user when the dependency is unclear. If `git switch` refuses over uncommitted changes, stop and ask the user. Push the new branch the first time with `git push -u origin <name>`.
