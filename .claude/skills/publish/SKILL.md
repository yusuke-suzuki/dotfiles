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
  git symbolic-ref refs/remotes/origin/HEAD --short
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

**With `gh`**:

```bash
gh pr list --head <current-branch> --limit 1
```

**With GitHub MCP**: use the `list_pull_requests` tool with owner and repo, and filter by the current branch as the head.

**If PR exists** (output contains a row):

- Extract the PR number from the first column
- Review the current PR description:

  **With `gh`**:

  ```bash
  gh pr view <number>
  ```

  **With GitHub MCP**: use the `pull_request_read` tool with owner, repo, and the PR number.

  **MANDATORY**: This fetch is required before any edit to the PR description, regardless of what is remembered from earlier in the conversation. Session memory is not a substitute — the remote may have been updated by review, by another tool, or by a prior edit that did not reach the local conversation. Skipping this step produces edits that overwrite or contradict the live description.
- Compare with the actual changes (`git diff <default>...HEAD`)
- When domain terminology has shifted on the branch (renames in spec text, prose, comments, identifiers), check that the PR-description vocabulary matches the current terms — not the prior terms. "API contract unchanged" is not sufficient evidence that the PR body is current; prose vocabulary drifts independently of code contracts and must be verified against the current spec wording.
- Update description if it doesn't accurately reflect the changes:

  **With `gh`**:

  ```bash
  gh pr edit <number>
  ```

  **With GitHub MCP**: use the `update_pull_request` tool with owner, repo, and the PR number.

When updating, rewrite the description against the final diff. The description is for reviewers of the final code, not a work log of development iterations. Do not append changelogs (e.g., "Fixed X in this update", "Previously Y was broken").

Before sending the updated body to `gh pr edit` (or the GitHub MCP `update_pull_request` tool), invoke the `copyeditor` agent on the draft. See "Copyedit before submitting" below.

**If no PR exists:**

1. Choose title:
   - MUST match a commit message subject line exactly
   - If multiple commits, select the one that best represents the overall change (prefer `feat`/`fix` over `chore`/`refactor`; prefer the commit with the broadest scope)
   - Announce which commit message was chosen as the title

2. Select template: Search for a project-level PR template using `find`:
   ```
   find . -iname 'pull_request_template.md'
   ```
   If multiple files match, prefer the one closest to the repository root (fewest path segments).
   - **Project template exists**: Read it and use it verbatim as the body skeleton. Preserve all sections including empty ones. Fill in only the content within each section; do not add, remove, or reorder sections. Match its language.
   - **No project template**: Ask the user via `AskUserQuestion` which language to use. Do not infer from the conversation language.
     - English → `{SKILL_BASE_DIR}/templates/pr-template.md`
     - Japanese (敬語) → `{SKILL_BASE_DIR}/templates/pr-template-ja.md`

     Replace `{SKILL_BASE_DIR}` with the absolute path from the "Base directory" runtime header provided when this skill is invoked.

3. Create the PR as **draft** by default:

   **With `gh`**:

   ```bash
   gh pr create --draft --title "..." --body-file ...
   ```

   **With GitHub MCP**: use the `create_pull_request` tool with owner, repo, title, body, head, base, and `draft: true`.

   Only create as ready for review if the user explicitly requested it (e.g., "ready", "not draft", "ready for review").

**IMPORTANT**: Always read the selected template file before creating the PR description.

Before sending the body to `gh pr create` (or the GitHub MCP `create_pull_request` tool), invoke the `copyeditor` agent on the draft. See "Copyedit before submitting" below.

When passing the body to `gh pr create` or `gh pr edit`, use a HEREDOC inline within the command. Do not stage the body to a local file (e.g. `/tmp/pr-body.md`) and pass it via `--body-file <path>`.

OK:

```bash
gh pr create --title "..." --body-file - <<'EOF'
body content here
EOF
```

NG: `Write /tmp/pr-body.md`, then `gh pr create --title "..." --body-file /tmp/pr-body.md`

The user reviews tool calls before they run. Inline HEREDOC puts the body in the call so they see it before approving. A separate Write step bypasses this — once the file exists, the follow-up `gh` call sends content the user has not yet reviewed.

## 4. Copyedit before submitting

Before any `gh pr create` or `gh pr edit` call, invoke the `copyeditor` agent on the drafted PR body.

Use the `Agent` tool with `subagent_type: copyeditor`. Pass:

1. The draft body verbatim.
2. The destination: "PR description" plus the target PR number when editing.
3. Context for fact verification: current branch, base branch, referenced PR / issue numbers, file paths mentioned in the draft.

Apply the agent's findings before submitting. If a finding is rejected, state the reason inline — silent rejection defeats the gate.

For findings marked "could not verify", either supply the missing source to the agent and re-run, or rephrase the claim to remove the unverifiable assertion.

## 5. Final Output

- Display the PR URL
- Show the current commit history relative to the default branch
