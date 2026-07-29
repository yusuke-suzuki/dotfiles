---
name: publish
description: Push commits and create/update pull request
---

# Publish

## 1. Push

Run `git status` and `git fetch origin`, and detect the default branch (`git symbolic-ref refs/remotes/origin/HEAD --short`). Push with `git push -u origin HEAD`; if the branch has diverged from its remote after a rebase, use `git push --force-with-lease`.

## 2. PR management

Find an existing PR for the branch: `gh pr list --head <branch>`, or the MCP `list_pull_requests` tool filtered by head.

**PR exists:**

- Fetch the live description first (`gh pr view <number>` / MCP `pull_request_read`) — required before any edit, regardless of session memory.
- Compare it against `git diff <default>...HEAD`, including vocabulary that shifted through renames on the branch, and update (`gh pr edit` / MCP `update_pull_request`) if it no longer matches.
- Rewrite against the final diff for reviewers of the final code. Do not append changelogs ("Fixed X in this update").

**No PR:**

1. Title: must match one commit subject line exactly. With multiple commits, pick the most representative (prefer `feat`/`fix`, broadest scope) and announce the choice.
2. Body: search for a project template (`find . -iname 'pull_request_template.md'`; prefer the match closest to the root). If one exists, read it and use it verbatim as the skeleton — fill sections only, match its language. Otherwise ask the user's language via AskUserQuestion (do not infer from the conversation) and use `{SKILL_BASE_DIR}/templates/pr-template.md` or `pr-template-ja.md`, reading the file first.
3. Create as draft (`gh pr create --draft` / MCP `create_pull_request` with `draft: true`) unless the user explicitly asked for ready-for-review.

## 3. Output

Display the PR URL and the commit history relative to the default branch.
