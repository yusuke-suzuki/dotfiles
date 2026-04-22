---
name: squash
description: Squash all branch commits into a single commit
---

# Squash

You are assisting with squashing all commits on the current branch
into a single commit. Follow these steps:

## 1. Initial Assessment

- Run `git status` to check for uncommitted changes
- Run `git fetch origin` to get latest remote updates
- Detect the default branch:
  ```bash
  git symbolic-ref refs/remotes/origin/HEAD --short
  ```
- Display existing commits with `git log <default>..HEAD --oneline`
- If the branch has only 1 commit, inform the user that squash is
  not needed and exit.

## 2. Semantic Consistency Check

Analyze the commits to determine whether they belong together:

- If all commits serve the same purpose: proceed to Step 3.
- If semantically distinct commits are mixed (e.g., an unrelated
  feature addition and a bug fix on the same branch): warn the user
  via AskUserQuestion that the commits appear to address different
  concerns. Suggest splitting into separate branches if appropriate.
  Only proceed if the user confirms.

## 3. Squash Commits

Combine all commits into one:

```bash
# Move HEAD back to the default branch while keeping all changes staged
git reset --soft <default>
# Create a single commit from the staged changes
git commit
```

## 4. Commit Message

Write the message against the full diff (`<default>..HEAD`),
not as a summary of the previous individual commits.

- Apply all rules from `commit-message.md`
- Subject ≤ 50 characters (verify with `echo -n "<subject>" | wc -m`)
- Body explains WHY, not WHAT — do not enumerate sub-changes
- Each sentence on its own line, wrap at 72 characters
- Do not reference the pre-squash commit history (e.g., avoid
  "combine feature X and fix Y"). Describe the final state as a
  single coherent intent.

## 5. Post-Squash Actions

1. Display the resulting commit with `git show HEAD --stat`
2. Inform the user to run `/publish` to push changes and update the PR
