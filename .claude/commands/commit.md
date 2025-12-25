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
- Craft a commit message following the conventions below
- Execute `git commit`

## Commit Message Conventions

### Format

- Use [Conventional Commits](https://www.conventionalcommits.org/) format
- Write in English using imperative mood and present tense
- Example: `feat: add user authentication` not `feat: added user authentication`

### Subject Line

- Maximum 50 characters including prefix and scope
- Verify character count before committing:

  ```bash
  echo -n "your subject line" | wc -c
  ```

- If over 50 characters, shorten before committing

### Body

- Separate subject from body with a blank line
- Wrap body text at 72 characters
- Add blank lines between paragraphs for readability
- Explain **what** and **why**, not **how**

### Example

```text
feat: add user authentication

Implement JWT-based authentication to secure API endpoints.
This addresses the security requirements outlined in issue #123.
```

## Key Constraints

- NEVER commit directly to master/main
- NEVER use `git commit --fixup` or `git commit --amend` (use `/fixup` command instead)
- This command creates a NEW, INDEPENDENT commit only
