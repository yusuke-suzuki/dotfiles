---
name: fixup
description: Create a fixup commit and autosquash rebase
---

# Fixup

## 1. Assess state

Run `git status` and `git fetch origin`, detect the default branch (`git symbolic-ref refs/remotes/origin/HEAD --short`; if unset, run `git remote set-head origin --auto` first), and list commits (`git log <default>..HEAD --oneline`). Stop and inform the user on the default branch or a detached HEAD — never rewrite history with nowhere to land it. If the branch has an upstream and `git log HEAD..@{u}` is non-empty, stop and run `/sync` first.

## 2. Identify target

- One commit on the branch → the target is HEAD.
- Multiple commits → match the current changes against each commit's diff. If no target is identifiable: for a new independent change, invoke `/commit`; for history needing consolidation, invoke `/squash`, then re-run `/fixup`.
- If `git config branch.<current>.gh-merge-base` names a parent and `git merge-base --is-ancestor <target> <parent>` succeeds, stop: the target belongs to the parent, so fix it there.

## 3. Fixup and rebase

Stop first if `git log --merges <target>~1..HEAD` is non-empty: autosquash rebase drops merge commits, so the `fixup!` commit is left standing as a separate commit while the rebase still exits 0. Say so and let the user rebase manually.

`git add <files>`, then `git commit --fixup=<target-hash>`, then `GIT_SEQUENCE_EDITOR=: git rebase -i --autosquash <target>~1` — before git 2.44, `--autosquash` without `-i` is silently ignored. Confirm no `fixup!` or `amend!` commit remains in `git log <default>..HEAD`.

`git add` does not clear paths already staged, and `--fixup` commits everything in the index. Between the two, confirm with `git diff --cached --name-only` that the index holds only the files that constitute the fix; if anything else is there, stop and ask the user to commit or unstage it.

## 4. Message review

Find the target's post-rebase hash in `git log <default>..HEAD`, run `git show <target>`, and read `~/.agents/skills/commit/commit-message.md`, especially "After /fixup". Evaluate whether the existing message still describes the final diff as a single coherent unit — it often does; leave it alone if so.

Only if it doesn't: redraft the whole message from the final diff, never by appending to the old one, no longer than a fresh commit of that diff would need. Write it to a file, and run `~/.agents/skills/commit/scripts/validate-message.sh <file>` until it passes. If the target is HEAD, `git commit --amend -F <file>`. Otherwise `git commit --allow-empty --fixup=reword:<target>` — keep the prepared `amend!` first line and put the new message below it — then rerun `GIT_SEQUENCE_EDITOR=: git rebase -i --autosquash <target>~1` and confirm no `amend!` commit remains.

## 5. Wrap up

Show `git log <default>..HEAD --oneline` and suggest pushing (`git push --force-with-lease` if the target commit was already on the remote).
