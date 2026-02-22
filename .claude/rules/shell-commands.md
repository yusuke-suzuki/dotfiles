# Shell Commands

Apply when running shell commands via the Bash tool.

## git

Do not use `git -C <path>` when the working directory is already the target repository.
Use plain `git` commands instead.

- OK: `git status`
- NG: `git -C /workspaces/project status`
