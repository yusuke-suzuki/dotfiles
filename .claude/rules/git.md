# Git

Apply when running git commands via the Bash tool.

## Path Arguments

Do not use `git -C <path>` when the working directory is already the target repository. Use plain `git` commands instead.

- OK: `git status`
- NG: `git -C /workspaces/project status`

## Commit

Always use the `/commit` skill instead of running `git commit` directly. The skill owns the full workflow from branch creation through commit. Do not create branches manually outside the skill — branch creation is part of the `/commit` workflow when on master/main.

## Push

Always use the `/publish` skill instead of running `git push` directly. The skill keeps the PR description in sync with the current diff.

## Editing published artifacts

When editing artifacts already on the remote — PR descriptions, PR titles, issue bodies, review comments, commit messages on a pushed branch — treat the remote as the single source of truth. Fetch the current state before producing the edit:

- PR description / title: `gh pr view <number>` (or the GitHub MCP `pull_request_read` tool)
- Issue body: `gh issue view <number>`
- Review comment: `gh api repos/<owner>/<repo>/pulls/comments/<comment-id>`
- Pushed commit message: `git fetch && git show origin/<branch>`

Session memory is not a substitute for the fetch. Between the time a draft was last seen and the time an edit is composed, the remote may have been updated by a reviewer, by a CI bot, by a prior tool call whose output was not retained, or by an external edit. Composing the edit against an outdated mental snapshot overwrites those changes silently.
