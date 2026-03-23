---
name: commit
description: Create a git commit with Conventional Commits format
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
- Derive 2-3 branch name candidates from the staged changes (e.g. `feat/add-login`, `docs/update-readme`)
- Present candidates to the user via AskUserQuestion and let them choose or provide their own
- Always create a new branch with `git switch -c <branch-name>`
- NEVER switch to an existing branch. If the chosen name conflicts
  with an existing branch, inform the user and ask for a different name.

**If on a feature branch:**
- Display the current branch name
- Show existing commits relative to main
- Ask the user via AskUserQuestion to confirm that committing to
  this branch is correct before proceeding

## 3. Diff Analysis

Understand the changes before staging:

- Review staged changes: `git diff --staged`
- Review unstaged changes: `git diff`
- Group changes by semantic intent (one logical change per commit)

## 4. Commit Creation

- Never stage files that contain secrets (.env, credentials, private keys)
- **Verify subject length before committing:**
  Run `echo -n "<subject>" | wc -m` and confirm the result is ≤ 50.
  If it exceeds 50, shorten the subject and re-verify. Do not proceed
  with `git commit` until the check passes.
- When writing the message body, explain WHY the change is needed.
  Do not list every file or sub-change — the diff shows that.
  Focus on the core motivation; omit supporting changes unless
  they have independent rationale a reviewer needs to understand.
- If changes fall into multiple distinct groups, create one commit per group
- For each group: `git add <files>`, craft a commit message, then `git commit`

## Key Constraints

- NEVER commit directly to master/main
- NEVER use `git commit --fixup` or `git commit --amend` (use `/fixup` command instead)
- NEVER reference `git log` messages as a style guide for commit messages, as past messages may not follow the correct format.
- This command creates a NEW, INDEPENDENT commit only
