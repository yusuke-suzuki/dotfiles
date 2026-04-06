# Git

Apply when running git commands via the Bash tool.

## Path Arguments

Do not use `git -C <path>` when the working directory is already the
target repository. Use plain `git` commands instead.

- OK: `git status`
- NG: `git -C /workspaces/project status`

## Commit

Always use the `/commit` skill instead of running `git commit` directly.
The skill owns the full workflow from branch creation through commit.
Do not create branches manually outside the skill — branch creation
is part of the `/commit` workflow when on master/main.

## Push

Always use the `/publish` skill instead of running `git push` directly.
The skill keeps the PR description in sync with the current diff.

Pushing to main/master and bypassing GPG signing are denied in
settings.json. If a commit fails due to signing errors, investigate
the root cause and report it instead of bypassing the signature.
