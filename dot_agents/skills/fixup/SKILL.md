---
name: fixup
description: Create a fixup commit and autosquash rebase
---

# Fixup

## 1. Assess state

Run `git status` and `git fetch origin`, detect the default branch (`git symbolic-ref refs/remotes/origin/HEAD --short`), and list commits (`git log <default>..HEAD --oneline`). Stop and inform the user on the default branch or a detached HEAD — never rewrite history with nowhere to land it.

## 2. Identify target

- One commit on the branch → the target is HEAD.
- Multiple commits → match the current changes against each commit's diff. If no target is identifiable: for a new independent change, invoke `/commit`; for history needing consolidation, invoke `/squash`, then re-run `/fixup`.

## 3. Fixup and rebase

`git add <files>`, then `git commit --fixup=<target-hash>`, then `git rebase --autosquash <default>`.

`git add` does not clear paths already staged, and `--fixup` commits everything in the index. Between the two, confirm with `git diff --cached --name-only` that the index holds only the files that constitute the fix; if anything else is there, stop and ask the user to commit or unstage it.

Stop instead if `git log --merges <default>..HEAD` is non-empty: autosquash rebase drops merge commits, so the `fixup!` commit is left standing as a separate commit while the rebase still exits 0. Say so and let the user rebase manually.

## 4. Message review

Find the target's post-rebase hash in `git log <default>..HEAD`, run `git show <target>`, and read `~/.agents/skills/commit/commit-message.md`, especially "After /fixup". Evaluate whether the existing message still describes the final diff as a single coherent unit — it often does; leave it alone if so.

Only if it doesn't: draft against the final diff, not the iteration history, write it to a file, and run `~/.agents/skills/commit/scripts/validate-message.sh <file>` until it passes. If the target is HEAD, `git commit --amend -F <file>`. Otherwise `git commit --allow-empty --fixup=reword:<target>` — keep the prepared `amend!` first line and put the new message below it — then rerun `git rebase --autosquash <default>`.

## 5. Wrap up

Show `git log <default>..HEAD --oneline` and suggest pushing (`git push --force-with-lease` if the target commit was already on the remote).
