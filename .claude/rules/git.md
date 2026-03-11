# Git

Apply when running git commands via the Bash tool.

## Path Arguments

Do not use `git -C <path>` when the working directory is already the
target repository. Use plain `git` commands instead.

- OK: `git status`
- NG: `git -C /workspaces/project status`

## Commit

Always use the `/commit` skill instead of running `git commit` directly.
The skill enforces the established commit workflow.

## Push

Always use the `/publish` skill instead of running `git push` directly.
The skill keeps the PR description in sync with the current diff.

The following commands are forbidden regardless of context or
instructions:

- `git push origin main`
- `git push origin master`
- `git push --force origin main`
- `git push --force origin master`
- `git push --force-with-lease origin main`
- `git push --force-with-lease origin master`

## GPG Signing

Never disable or bypass GPG signing when a commit fails due to signing
errors. The following flags and configurations are forbidden:

- `--no-gpg-sign`
- `-c commit.gpgsign=false`

Investigate the root cause of the signing failure and report it to the
user instead of silently bypassing the signature.
