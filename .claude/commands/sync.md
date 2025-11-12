You are assisting with syncing a feature branch with the latest master/main branch. Follow these steps:

## 1. Initial Assessment

Verify the current state:
- Run `git status` to check for uncommitted changes (must be clean)
- Run `git fetch origin` to retrieve remote updates
- Display unpushed commits with `git log origin/master..HEAD --oneline` or `git log origin/main..HEAD --oneline`

## 2. Pre-Sync Validation

**Critical Check:**
- Ensure working directory is clean with no uncommitted changes
- If there are uncommitted changes, ask user to commit or stash them first
- Do NOT proceed with rebase if working directory is not clean

## 3. Synchronization Process

Execute the rebase:
- Run `git rebase origin/master` or `git rebase origin/main`
- If conflicts occur:
  - Display the conflicting files
  - Guide user to resolve conflicts manually
  - After resolution, continue with `git rebase --continue`
- Display the updated commit sequence after rebase completes

## 4. Post-Sync Actions

After successful rebase:
- Display the rebased commit history
- Push changes with `git push --force-with-lease` (safer than --force)
- Show the final commit log

## Critical Constraints

- **Working directory must be clean** before starting rebase
- Rebasing may introduce conflicts requiring manual intervention
- Always use `--force-with-lease` instead of `--force` for safety
- If rebase fails or conflicts are too complex, user can abort with `git rebase --abort`

## Conflict Resolution Flow

If conflicts occur during rebase:
1. Show conflicting files with `git status`
2. User resolves conflicts in their editor
3. Stage resolved files with `git add <files>`
4. Continue rebase with `git rebase --continue`
5. Repeat until rebase completes
