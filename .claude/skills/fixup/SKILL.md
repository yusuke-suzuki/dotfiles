---
name: fixup
description: Create a fixup commit and autosquash rebase
---

# Fixup

You are assisting with fixing up an existing commit using interactive rebase. Follow these steps:

## 1. Initial Assessment

- Run `git status` to see if there are uncommitted changes
- Run `git fetch origin` to get latest remote updates
- Detect the default branch:
  ```bash
  git symbolic-ref refs/remotes/origin/HEAD --short
  ```
- Display existing commits with `git log <default>..HEAD --oneline`

## 2. Identify Target Commit

Determine the fixup target automatically based on the branch state:

**If the branch has 1 commit:**
- The target is HEAD. Proceed directly to Step 3.

**If the branch has multiple commits:**
- Compare the changed files and diff content against each commit in the branch to identify the target.
- **Target identified:** Proceed to Step 3 with that commit.
- **Target not identifiable:** Analyze the changes and commit history, then invoke the appropriate skill automatically:
  - If the changes are a new independent feature or fix: invoke `/commit` via the Skill tool.
  - If the commit history needs consolidation: invoke `/squash` via the Skill tool, then re-invoke `/fixup` after squash completes.

## 3. Create Fixup Commit

1. Stage changes with `git add <files>`
2. Create a fixup commit:

   ```bash
   git commit --fixup=<target-hash>
   ```

## 4. Autosquash Rebase

Run non-interactive rebase with autosquash:

```bash
git rebase --autosquash <default>
```

## 5. Commit Message Review

After rebase completes, verify the commit message in two phases.

### Phase 1: Evaluate

1. Display the rebased commit:

   ```bash
   git show HEAD
   ```

2. Read `.claude/rules/commit-message.md` — especially the "After /fixup or --autosquash rebase" section.

3. Evaluate whether the existing message accurately describes the purpose of the final diff as a single coherent unit.

4. If the message is accurate, skip amending and proceed to Step 6.

### Phase 2: Amend (only if needed)

If the message does not accurately describe the commit's purpose:

1. Draft a corrected message based on the final diff — not on what changed between iterations
2. Explain what is inaccurate and why
3. Update with `git commit --amend`

## 6. Post-Rebase Actions

After message review:

1. Display the final commit history:

   ```bash
   git log <default>..HEAD --oneline
   ```

2. Inform the user to run `/publish` to push changes and update the PR

## Key Principles

- Use `--fixup=<hash>` to create fixup commits targeting specific commits
- `--autosquash` automatically merges fixup commits during rebase
- After rebase, evaluate the existing message before amending — it is often already accurate and needs no change
- Read `commit-message.md` before drafting any corrected message
- Commit messages follow the `commit-message` rule
