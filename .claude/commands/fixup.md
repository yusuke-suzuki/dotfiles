---
description: Create a fixup commit and autosquash rebase
allowed-tools: Bash(git status:*), Bash(git fetch:*), Bash(git log:*), Bash(git diff:*), Read, Glob
---

# Fixup

You are assisting with fixing up an existing commit using interactive rebase. Follow these steps:

## 1. Initial Assessment

- Run `git status` to see if there are uncommitted changes
- Run `git fetch origin` to get latest remote updates
- Display existing commits with `git log origin/main..HEAD --oneline`

## 2. Create Fixup Commit

If there are uncommitted changes:

1. Show the commit history
2. Ask user which commit hash to fixup (or identify it based on context)
3. Stage changes with `git add .` or ask which files to stage
4. Create a fixup commit:

   ```bash
   git commit --fixup=<commit-hash>
   ```

## 3. Autosquash Rebase

Run interactive rebase with autosquash:

```bash
git rebase -i --autosquash origin/main
```

The autosquash option will automatically arrange and mark fixup commits for squashing.

## 4. Post-Rebase Actions

After rebase completes:

1. Display the final commit history:

   ```bash
   git log origin/main..HEAD --oneline
   ```

2. Inform the user to run `/publish` to push changes and update the PR

## Key Principles

- Use `--fixup=<hash>` to create fixup commits targeting specific commits
- `--autosquash` automatically merges fixup commits during rebase
- Commit messages follow the `commit-message` rule
