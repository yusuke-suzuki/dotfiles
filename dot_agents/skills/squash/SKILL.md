---
name: squash
description: Squash all branch commits into a single commit
---

# Squash

## 1. Assess state

Run `git status` and `git fetch origin`, detect the default branch (`git symbolic-ref refs/remotes/origin/HEAD --short`), and list commits (`git log <default>..HEAD --oneline`). On the default branch, stop and inform the user — never rewrite history there. The working tree and index must be clean; ask the user to commit or stash first otherwise. With only one commit, inform the user that squash is not needed and exit.

## 2. Consistency check

If semantically distinct commits are mixed (e.g. an unrelated feature and a bug fix), warn via AskUserQuestion and suggest splitting into separate branches; proceed only on confirmation.

## 3. Message

Review the full diff (`git diff <default>..HEAD`) and draft the message against it, following `~/.agents/skills/commit/commit-message.md`. Do not reference the pre-squash history (avoid "combine feature X and fix Y") — describe the final state as a single coherent intent.

Write it to a file and run `~/.agents/skills/commit/scripts/validate-message.sh <file>` until it passes.

## 4. Squash

```bash
git reset --soft <default>
git commit -F <file>
```

## 5. Wrap up

Show `git show HEAD --stat` and suggest pushing with `git push --force-with-lease`.
