---
description: Create a git commit with Conventional Commits format
allowed-tools: Bash(git status:*), Bash(git fetch:*), Bash(git log:*), Bash(git diff:*), Read, Glob
---

# Commit

You are assisting with creating a git commit. Follow these steps:

## 1. Initial State Assessment

- Run `git status` to see uncommitted changes
- Run `git fetch origin` to get latest remote updates
- Identify current branch (master/main or feature branch)
- If on a feature branch, show commits with `git log origin/main..HEAD --oneline`

## 2. Branch Handling

**If on master/main:**
- Ask the user for a feature branch name
- Create and switch using `git switch -c <branch-name>`

**If on a feature branch:**
- Display the current branch name
- Show existing commits relative to main

## 3. Commit Creation

- Stage changes with `git add .` or ask user which files to stage
- Craft a commit message following the `commit-message` rule
- Execute `git commit`

## Key Constraints

- NEVER commit directly to master/main
- NEVER use `git commit --fixup` or `git commit --amend` (use `/fixup` command instead)
- This command creates a NEW, INDEPENDENT commit only
