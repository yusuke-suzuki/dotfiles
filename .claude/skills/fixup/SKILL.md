---
name: fixup
description: Create a fixup commit and autosquash rebase
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

Run non-interactive rebase with autosquash:

```bash
git rebase --autosquash origin/main
```

## 4. Commit Message Review

After rebase completes, verify the commit message in two phases.

### Phase 1: Evaluate

1. Display the rebased commit:

   ```bash
   git show HEAD
   ```

2. Read `.claude/rules/commit-message.md` — especially the
   "After /fixup or --autosquash rebase" section.

3. Evaluate whether the existing message accurately describes the
   purpose of the final diff as a single coherent unit.

4. If the message is accurate, skip amending and proceed to Step 5.

### Phase 2: Amend (only if needed)

If the message does not accurately describe the commit's purpose:

1. Draft a corrected message based on the final diff —
   not on what changed between iterations
2. Explain what is inaccurate and why
3. Update with `git commit --amend`

## 5. Post-Rebase Actions

After message review:

1. Display the final commit history:

   ```bash
   git log origin/main..HEAD --oneline
   ```

2. Inform the user to run `/publish` to push changes and update the PR

## Key Principles

- Use `--fixup=<hash>` to create fixup commits targeting specific commits
- `--autosquash` automatically merges fixup commits during rebase
- After rebase, evaluate the existing message before amending — it is
  often already accurate and needs no change
- Read `commit-message.md` before drafting any corrected message
- Commit messages follow the `commit-message` rule
