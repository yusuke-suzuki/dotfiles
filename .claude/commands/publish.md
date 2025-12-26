---
description: Push commits and create/update pull request
allowed-tools: Bash(git status:*), Bash(git fetch:*), Bash(git log:*), Bash(git diff:*), Bash(gh pr view:*), Read, Glob
---

# Publish

You are assisting with pushing commits and managing pull requests. Follow these steps:

## 1. Initial State Assessment

- Run `git status` to check current branch and sync status
- Run `git fetch origin` to get latest remote updates
- Determine push strategy based on branch state

## 2. Push Strategy

**If branch is ahead of remote (normal push):**

```bash
git push -u origin HEAD
```

**If branch has diverged from remote (after rebase):**

```bash
git push --force-with-lease
```

## 3. PR Management

After pushing, check for existing PR:

```bash
gh pr view
```

**If PR exists:**

- Review the current PR description
- Compare with the actual changes (`git diff origin/main...HEAD`)
- Update description if it doesn't accurately reflect the changes: `gh pr edit`

**If no PR exists:**

- Create a new PR: `gh pr create`

## PR Guidelines

Follow the `pr-description` rule.

Additionally:

- Ask user whether to create as draft or ready for review

## 4. Final Output

- Display the PR URL
- Show the current commit history relative to main
