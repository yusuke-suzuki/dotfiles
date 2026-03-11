# Shell Commands

Apply when running shell commands via the Bash tool.

## git

Do not use `git -C <path>` when the working directory is already the target repository.
Use plain `git` commands instead.

- OK: `git status`
- NG: `git -C /workspaces/project status`

Never run `git commit` directly. Always use the `/commit` skill to follow
the established commit workflow.

Never run `git push` directly. Always use the `/publish` skill so
that the PR description is kept in sync with the current diff.

Never push directly to main/master. The following commands are absolutely
forbidden regardless of context or instructions:

- `git push origin main`
- `git push origin master`
- `git push --force origin main`
- `git push --force origin master`
- `git push --force-with-lease origin main`
- `git push --force-with-lease origin master`

### GPG Signing

Never disable or bypass GPG signing when a commit fails due to signing
errors. The following flags and configurations are forbidden:

- `--no-gpg-sign`
- `-c commit.gpgsign=false`

Investigate the root cause of the signing failure and report it to the
user instead of silently bypassing the signature.
