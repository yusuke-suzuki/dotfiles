---
name: publish
description: Push commits and create/update pull request
---

# Publish

Skip any step the environment has already performed automatically (e.g. auto-pushed branches, auto-synced PR descriptions).

1. Push with `git push -u origin HEAD` (`--force-with-lease` if the branch diverged after a rebase).
2. No PR for the branch yet: create one as draft (unless the user asked for ready-for-review). Title: the most representative commit subject line, verbatim. Body: fill the repository's `.github/pull_request_template.md`; if the repository has none, use Summary / Motivation / Changes headings in the language of its existing PRs.
3. PR exists: update the description only if it no longer matches `git diff <default>...HEAD`. Rewrite against the final diff — no changelog appendices.
4. Display the PR URL.
