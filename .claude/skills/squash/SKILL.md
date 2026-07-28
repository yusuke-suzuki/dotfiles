---
name: squash
description: Squash all branch commits into a single commit
---

# Squash

## 1. Assess state

Run `git status` and `git fetch origin`, detect the default branch (`git symbolic-ref refs/remotes/origin/HEAD --short`), and list commits (`git log <default>..HEAD --oneline`). With only one commit, inform the user that squash is not needed and exit.

## 2. Consistency check

If semantically distinct commits are mixed (e.g. an unrelated feature and a bug fix), warn via AskUserQuestion and suggest splitting into separate branches; proceed only on confirmation.

## 3. Squash

```bash
git reset --soft <default>
git commit
```

## 4. Message

Write against the full diff, following `~/.claude/skills/commit/commit-message.md`. Do not reference the pre-squash history (avoid "combine feature X and fix Y") — describe the final state as a single coherent intent.

## 5. Wrap up

Show `git show HEAD --stat` and suggest `/publish`.
