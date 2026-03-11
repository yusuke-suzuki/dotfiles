---
name: publish
description: Push commits and create/update pull request
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

When updating, rewrite the description against the final diff.
The description is for reviewers of the final code, not a work log
of development iterations. Do not append changelogs (e.g., "Fixed X
in this update", "Previously Y was broken").

**If no PR exists:**

1. Choose title:
   - MUST match a commit message subject line exactly
   - If multiple commits, ask user which to use

2. Select template:
   ```bash
   find . -maxdepth 2 -iname "pull_request_template.md" -print -quit
   ```
   - **Project template exists**: Read it and use it verbatim as the
     body skeleton. Preserve all sections including empty ones. Fill in
     only the content within each section; do not add, remove, or
     reorder sections. Match its language.
   - **No project template**: Always ask the user via `AskUserQuestion`
     which language to use. Do not infer from the conversation language.
     - English (default) → [templates/pr-template.md](templates/pr-template.md)
     - Japanese (敬語) → [templates/pr-template-ja.md](templates/pr-template-ja.md)

3. Ask user whether to create as draft or ready for review
4. Create the PR

**IMPORTANT**: Always read the selected template file before creating the PR description.

## 4. Final Output

- Display the PR URL
- Show the current commit history relative to main
