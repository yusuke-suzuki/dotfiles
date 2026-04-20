---
name: commit
description: Create a git commit with Conventional Commits format. Invoke as soon as changes are ready — branch creation, staging, and message authoring are all part of this workflow.
---

# Commit

You are assisting with creating a git commit. Follow these steps:

## 1. Initial State Assessment

- Run `git status` to see uncommitted changes
- Run `git fetch origin` to get latest remote updates
- Detect the default branch:
  ```bash
  gh repo view --json defaultBranchRef -q '.defaultBranchRef.name'
  ```
- Identify current branch (default branch or feature branch)
- If on a feature branch, show commits with `git log origin/<default>..HEAD --oneline`

## 2. Branch Handling

**If on the default branch:**
- Derive the most descriptive branch name from the current changes
  (e.g. `feat/add-login`, `docs/update-readme`)
- Create the branch: `git switch -c <branch-name>`
- Announce the chosen name and reasoning
- NEVER switch to an existing branch. If the chosen name conflicts
  with an existing branch, append a short disambiguator or choose
  an alternative name.

**If on a feature branch whose existing commits relate to the current
changes:**
- Display the current branch name and existing commits relative to
  the default branch
- Proceed to create the commit on this branch

**If on a feature branch whose existing commits are unrelated to the
current changes** (e.g. left over from a different task after
switching focus):
- Announce the mismatch between the branch's history and the current
  changes so the user can intervene if needed
- Derive a new branch name from the current changes and create it
  off the latest remote default so uncommitted work does not pass
  through the local default branch:
  `git switch -c <branch-name> origin/<default>`
- Announce the chosen name and reasoning (as in the default-branch case)
- If uncertain whether the existing commits are related, ask the user
  before branching rather than guessing

## 3. Diff Analysis

Understand the changes before staging:

- Review staged changes: `git diff --staged`
- Review unstaged changes: `git diff`
- Group changes by semantic intent (one logical change per commit)

## 4. Commit Creation

- Never stage files that contain secrets (.env, credentials, private keys)
- **Verify the drafted commit message against all rules in
  `~/.claude/rules/commit-message.md` before running `git commit`.**
  Check at minimum:
  - Subject line is ≤ 50 characters
    (run `echo -n "<subject>" | wc -m` to confirm)
  - Subject and body are written in English
  - Format follows Conventional Commits
  - Body explains the rationale, not the mechanics
  If any check fails, fix the message and re-verify. Do not proceed
  with `git commit` until all checks pass.
- When writing the message body, explain WHY the change is needed.
  Do not list every file or sub-change — the diff shows that.
  Focus on the core motivation; omit supporting changes unless
  they have independent rationale a reviewer needs to understand.
- If changes fall into multiple distinct groups, create one commit per group
- For each group: `git add <files>`, craft a commit message, then `git commit`

## Key Constraints

- NEVER commit directly to the default branch (master/main)
- NEVER use `git commit --fixup` or `git commit --amend` (use `/fixup` command instead)
- NEVER reference `git log` messages as a style guide for commit messages, as past messages may not follow the correct format.
- This command creates a NEW, INDEPENDENT commit only
