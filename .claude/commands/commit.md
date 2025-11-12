You are assisting with a systematic commit and PR management workflow. Follow these steps carefully:

## IMPORTANT: Command Purpose

This command creates a **NEW, INDEPENDENT commit**.

- **NEVER use `git commit --fixup`** or `git commit --amend`
- This command is for adding new commits to the branch history
- If you need to modify an existing commit, use the `/fixup` command instead

## 1. Initial State Assessment

First, check your current position:
- Run `git status` to see uncommitted changes
- Run `git fetch origin` to get latest remote updates
- Identify whether you're on master/main or a feature branch
- If on a feature branch, show commits with `git log origin/master..HEAD --oneline` or `git log origin/main..HEAD --oneline`

## 2. Branch Handling

**If on master/main:**
- Ask the user for a feature branch name
- Create and switch to it using `git switch -c <branch-name>`

**If already on a feature branch:**
- Display the current branch name
- Show existing commits relative to master/main

## 3. Commit Creation

- Stage changes with `git add .` or ask user which files to stage
- Craft a commit message following CLAUDE.md guidelines (Conventional Commits format)
- IMPORTANT: Before finalizing, verify the subject line is 50 characters or less using `echo -n "subject line" | wc -c`
- Execute the commit with `git commit -m "..."` (standard commit, NOT fixup or amend)

## 4. Post-Commit Actions

After committing:
- Push your branch with `git push -u origin HEAD`
- Check for existing PR with `gh pr view`
- If PR exists: Update the PR description if needed with `gh pr edit`
- If no PR exists: Create a new one with `gh pr create`
- Display the commit history and PR URL

## Key Constraints

- **NEVER** commit directly to master/main
- Commit messages MUST follow Conventional Commits conventions per CLAUDE.md
- PR title MUST match the commit message subject line exactly
- Always use `git push -u origin HEAD` for the first push of a new branch
