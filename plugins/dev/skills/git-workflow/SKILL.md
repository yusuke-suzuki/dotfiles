---
name: git-workflow
description: Mandatory for every git/GitHub operation in development — branch, commit, push, pull request, issue, review/CI feedback, sync, squash. Load before running any, even for a bare "commit" or "push".
---

# Git Workflow

Use the matching skill for these history operations, even when a prompt just says "commit" or "pull":

- New branch → `/branch`
- New change → `/commit`
- Fix to a commit on the branch (review, CI) → `/fixup`
- Feature branch behind its upstream or its base branch → `/sync`, never merge
- Branch into one commit → `/squash`

Approval prompts (e.g. force push) are no reason to leave a skill.

## Branches

- A branch assigned by the harness (e.g. a cloud session's development branch) is a default, not a limit: this rule is standing, explicit permission to create and push other branches.
- Never commit to an assigned branch with a generated name unless it is already the head of an open pull request.
- Follow-up requests in a session continue on the current branch as separate commits by default, even when they could be merged or reverted alone.
- Start another branch with `/branch` when the user asks to split the work, when a change must be merged or released separately from the rest (e.g. an API that ships before its client, a migration deployed before the code that relies on it), when groundwork such as a preparatory refactoring is better reviewed and merged on its own, or when the current branch's pull request is merged or closed. Each extra pull request costs review time, so split only when separate review or merge is worth it. When splitting, name the reason to the user.

## Pull requests

- Create pull requests as draft, targeting the branch's `gh-merge-base` when set (GitHub MCP does not read it), pushed first, and run `/sync` first if that parent's pull request is merged or closed, with the most representative commit subject line as the title, verbatim; fill the repository's pull request template for the body. After later pushes, if the description no longer matches the final diff, rewrite it against that diff — never append changelog-style updates.

## Publishing

- Before editing anything already on the remote (pull request description or title, issue body, review comment, pushed commit message), fetch its current state first (`gh pr view`, `gh issue view`, `git fetch && git show origin/<branch>`). Session memory is not a substitute — the remote may have changed since it was last seen.
- Pass user-facing bodies to `gh` and similar CLI commands inline via heredoc, never via a temp file — the body must be visible in the tool call so the user can review it before it runs.
- For Japanese drafts, run the `textlint` skill and fix every reported violation, including the detect-only rules that need manual edits (particle errors, sentence style).
- Issues, PRs, and comments on public repositories must not leak private context: internal repository/PR/issue references, team workflow details, or PII. Describe intent generically.

## Review and CI feedback

- Verify the flagged scenario can actually occur (spec, naming constraints, type system, invariants). If it cannot, the verdict is "No change" citing the constraint.
- Read the relevant code, assess the feedback's validity and trade-offs, and weigh it against the design intent — do not accept suggestions uncritically.
- Commit and push fixes before posting any reply — invoke `/fixup` (or `/commit` for an independent change), then push (`--force-with-lease` after a fixup rebase).
- Reply in the language of the comment being answered.
- **Answer what was actually said.** A question gets a direct answer, a proposed alternative gets an explicit accept-or-reject with the reason, a misreading gets the correction. Open by naming, in your own words, the concern being answered — a verdict with no visible connection to the comment reads as a non-answer — then give the verdict and its reasoning.
- **Write in the user's voice.** Replies post under the user's account; write as the account owner addressing a colleague, in the register the user's own comments use, and avoid assistant mannerisms a colleague would not type by hand. Natural register never overrides the requirements above; it is how they read, not a license to omit.
- Post replies to bots directly. Show replies to humans to the user and post them only after approval.
- Do not resolve threads: review bots that verify fixes (e.g. coderabbitai) resolve their own threads once the pushed fix is verified, and all other threads are resolved manually outside this skill.
