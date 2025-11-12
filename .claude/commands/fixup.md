You are assisting with a commit fixup and squash workflow using interactive rebase. Follow these steps:

## 1. Initial Assessment

Check the current state:
- Run `git status` to see if there are uncommitted changes
- Run `git fetch origin` to get latest remote updates
- Display existing commits with `git log origin/master..HEAD --oneline` or `git log origin/main..HEAD --oneline`
- Check if a PR is open with `gh pr view`

## 2. Workflow Based on Changes

### With Uncommitted Changes:

1. **Identify Target Commit:**
   - Show the commit history
   - Ask user which commit hash to fixup (or identify it based on context)

2. **Create Fixup Commit:**
   - Stage changes with `git add .` or ask which files to stage
   - Create a fixup commit: `git commit --fixup=<commit-hash>`

3. **Interactive Rebase:**
   - Run `git rebase -i --autosquash origin/master` or `git rebase -i --autosquash origin/main`
   - The autosquash option will automatically arrange fixup commits

4. **Force Push:**
   - Push with `git push --force-with-lease` (safer than --force)

### Without Changes (Consolidating Existing Fixups):

1. **Interactive Rebase:**
   - Run `git rebase -i --autosquash origin/master` or `git rebase -i --autosquash origin/main`
   - This will consolidate any existing fixup commits

2. **Force Push:**
   - Push with `git push --force-with-lease`

## 3. Post-Rebase Actions

After rebasing, **ALWAYS** execute these steps:

1. **Display the final commit history:**
   - Run `git log origin/master..HEAD --oneline` or `git log origin/main..HEAD --oneline`

2. **Update PR description (MANDATORY):**
   - Run `gh pr view` to check if PR exists
   - If PR exists, **ALWAYS** run `gh pr edit` to update the description
   - The PR description must reflect the consolidated commit history after fixup
   - Never skip this step - PR descriptions must stay in sync with commits

## Key Principles

- Use `--fixup=<hash>` to create fixup commits targeting specific commits
- `--autosquash` automatically merges fixup commits during rebase
- Always use `--force-with-lease` instead of `--force` for safety
- Commit messages follow the project's conventions per CLAUDE.md
- Update PR descriptions to reflect the consolidated commit history
