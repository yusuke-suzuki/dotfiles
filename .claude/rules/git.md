# Git

- Use the `/commit` skill instead of raw `git commit` — it owns branch creation through message authoring.
- Pull requests: create as draft with the most representative commit subject line as the title, verbatim; fill the repository's pull request template for the body. After later pushes, if the description no longer matches the final diff, rewrite it against that diff — never append changelog-style updates.
- Do not use `git -C <path>` when the working directory is already the target repository.
- Before editing anything already on the remote (PR description or title, issue body, review comment, pushed commit message), fetch its current state first (`gh pr view`, `gh issue view`, `git fetch && git show origin/<branch>`). Session memory is not a substitute — the remote may have changed since it was last seen.
