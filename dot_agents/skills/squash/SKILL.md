---
name: squash
description: Squash all branch commits into a single commit
---

# Squash

## 1. Assess state

Run `git status` and `git fetch origin`, detect the default branch (`git symbolic-ref refs/remotes/origin/HEAD --short`; if unset, run `git remote set-head origin --auto` first), and resolve `<base>`: `git config branch.<current>.gh-merge-base`, else the pull request's `baseRefName` (`gh pr view --json baseRefName`, or GitHub MCP), else the default branch. `<base-ref>` is `<default>` for the default branch; otherwise whichever of `origin/<base>` and the local `<base>` contains the other, or the one that exists; stop and ask the user if they diverged or neither exists. List commits (`git log <base-ref>..HEAD --oneline`). On the default branch, stop and inform the user — never rewrite history there. The working tree and index must be clean; ask the user to commit or stash first otherwise. If the branch has an upstream and `git log HEAD..@{u}` is non-empty, or the base is not the default branch and `git merge-base --is-ancestor <base-ref> HEAD` fails, its pull request is merged or closed, or `git merge-base --fork-point <base-ref> HEAD` fails or differs from `git merge-base <base-ref> HEAD`, stop and run `/sync` first. With only one commit, inform the user that squash is not needed and exit.

## 2. Consistency check

If semantically distinct commits are mixed (e.g. an unrelated feature and a bug fix), warn via AskUserQuestion and suggest splitting into separate branches; proceed only on confirmation.

## 3. Message

Review the full diff (`git diff <base-ref>...HEAD`) and draft the message against it, following `~/.agents/skills/commit/commit-message.md`. Do not reference the pre-squash history (avoid "combine feature X and fix Y") — describe the final state as a single coherent intent.

Write it to a file and run `~/.agents/skills/commit/scripts/validate-message.sh <file>` until it passes.

## 4. Squash

```bash
git reset --soft $(git merge-base <base-ref> HEAD)
git commit -F <file>
```

## 5. Wrap up

Show `git show HEAD --stat` and suggest pushing with `git push --force-with-lease`.
