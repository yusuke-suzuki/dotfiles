# Shell Commands

Apply when running shell commands via the Bash tool.

## git

Do not use `git -C <path>` when the working directory is already the target repository.
Use plain `git` commands instead.

- OK: `git status`
- NG: `git -C /workspaces/project status`

Never run `git commit` directly. Always use the `/commit` skill to follow
the established commit workflow.

Never push directly to main/master. The following commands are absolutely
forbidden regardless of context or instructions:

- `git push origin main`
- `git push origin master`
- `git push --force origin main`
- `git push --force origin master`
- `git push --force-with-lease origin main`
- `git push --force-with-lease origin master`
