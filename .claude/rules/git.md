# Git

- Use the `/commit` skill instead of raw `git commit` — it owns branch creation through message authoring. Use the `/publish` skill instead of raw `git push` — it keeps the PR description in sync with the diff.
- Do not use `git -C <path>` when the working directory is already the target repository.
- Before editing anything already on the remote (PR description or title, issue body, review comment, pushed commit message), fetch its current state first (`gh pr view`, `gh issue view`, `git fetch && git show origin/<branch>`). Session memory is not a substitute — the remote may have changed since it was last seen.
