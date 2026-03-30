---
name: publish
description: Push commits and create/update pull request
---

# Publish

You are assisting with pushing commits and managing pull requests. Follow these steps:

## 1. Initial State Assessment

- Run `git status` to check current branch and sync status
- Run `git fetch origin` to get latest remote updates
- Detect the default branch:
  ```bash
  gh repo view --json defaultBranchRef -q '.defaultBranchRef.name'
  ```
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
gh pr list --head "$(git branch --show-current)" --limit 1
```

**If PR exists** (output contains a row):

- Extract the PR number from the first column
- Review the current PR description: `gh pr view <number>`
- Compare with the actual changes (`git diff origin/<default>...HEAD`)
- Update description if it doesn't accurately reflect the changes: `gh pr edit <number>`

When updating, rewrite the description against the final diff.
The description is for reviewers of the final code, not a work log
of development iterations. Do not append changelogs (e.g., "Fixed X
in this update", "Previously Y was broken").

**If no PR exists:**

1. Choose title:
   - MUST match a commit message subject line exactly
   - If multiple commits, select the one that best represents the
     overall change (prefer `feat`/`fix` over `chore`/`refactor`;
     prefer the commit with the broadest scope)
   - Announce which commit message was chosen as the title

2. Select template:
   Use Glob to search for a project-level PR template:
   ```
   Glob pattern: **/pull_request_template.md
   ```
   If multiple files match, prefer the one closest to the repository
   root (fewest path segments).
   - **Project template exists**: Read it and use it verbatim as the
     body skeleton. Preserve all sections including empty ones. Fill in
     only the content within each section; do not add, remove, or
     reorder sections. Match its language.
   - **No project template**: Ask the user via `AskUserQuestion` which
     language to use. Do not infer from the conversation language.
     - English → `{SKILL_BASE_DIR}/templates/pr-template.md`
     - Japanese (敬語) → `{SKILL_BASE_DIR}/templates/pr-template-ja.md`

     Replace `{SKILL_BASE_DIR}` with the absolute path from the
     "Base directory" runtime header provided when this skill is invoked.

3. Create the PR as **draft** by default.
   Only create as ready for review if the user explicitly requested it
   (e.g., "ready", "not draft", "ready for review").

**IMPORTANT**: Always read the selected template file before creating the PR description.

## 4. Final Output

- Display the PR URL
- Show the current commit history relative to the default branch
