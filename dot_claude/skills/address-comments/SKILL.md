---
name: address-comments
description: Address PR review comments — analyze, fix, push, and reply
---

# Address Comments

## 1. Fetch threads

Identify the PR for the current branch (`gh pr view --json number,headRepositoryOwner`, or MCP `list_pull_requests`). Fetch review threads with thread ids, resolution state, and embedded comments:

- **`gh`** (GraphQL — neither REST nor `gh pr view --json` exposes thread ids or `isResolved`): query `repository → pullRequest → reviewThreads(first: 5, after: $endCursor) { pageInfo { hasNextPage endCursor } nodes { id isResolved comments(first: 20) { pageInfo { hasNextPage endCursor } nodes { databaseId author { login } body path line diffHunk } } } }`
- **MCP**: `pull_request_read` with `method: "get_review_comments"`, paging with `perPage` and `after`

Page the thread list by passing its `endCursor` back as `after` while `hasNextPage` is true. A thread whose `comments` report `hasNextPage` needs a follow-up query on that thread's `id` with its own comment cursor — one shared cursor cannot page several threads. Keep pages to 5-10 — bot comments are long, and one oversized page can exceed the tool's token limit and spill to a file that then has to be read back.

Exclude unresolved threads whose last comment is the current user's own reply (`gh api /user` or MCP `get_me` for the login) — they are awaiting the reviewer's response and re-enter scope only when a newer comment arrives. Display the remaining unresolved threads: author, path, line, diff hunk, body.

Review bots wrap their own verification transcripts, bundled linter output, and tracking metadata in `<details>` blocks and HTML comments, which routinely outweigh the finding itself. Before reading the bodies, drop `(?s)<!--.*?-->` and every `<details>` block that carries no fenced `suggestion` or `diff` — those hold the reviewer's proposed change and are the one part worth keeping.

## 2. Analyze

For each unresolved comment:

1. Verify the flagged scenario can actually occur (spec, naming constraints, type system, invariants). If it cannot, draft a "No change" reply citing the constraint and skip the rest.
2. Read the relevant code, assess the feedback's validity and trade-offs, and weigh it against the design intent — do not accept suggestions uncritically.
3. Draft the action: **Fix** (specific changes) or **No change** (rationale).

## 3. Plan approval

Enter plan mode (EnterPlanMode) and write the per-comment plan in the user's response language: path/line, the verdict with its reasoning, and the action. Do not quote the comment back — step 1 already displayed it — and keep each entry to a few lines. Present via ExitPlanMode and do not proceed until approved. Once approved, execute steps 4-6 in a single pass — do not re-enter plan mode or revise the approved actions.

## 4. Fix and push

Apply the approved fixes, then commit and push before posting any reply — invoke `/fixup` (or `/commit` for an independent change), then push (`--force-with-lease` after a fixup rebase). A reply posted while the fix exists only locally cannot be verified: review bots such as coderabbitai respond that they cannot confirm the fix.

Skip this step when every action is "No change".

## 5. Reply

Reply on every thread selected in step 1 (one reply per thread) to keep an audit trail, regardless of author (human or bot), matching the original comment's language. For fixes, reference the pushed commit id.

Default to a conclusion plus a one-line rationale; do not restate what the diff or the resolved state already shows.

Post to the `databaseId` of the thread's **first** comment — the reply endpoint takes a top-level comment id, not that of a reply: `gh api -X POST /repos/{owner}/{repo}/pulls/{number}/comments/{comment_id}/replies -f body="..."`, or MCP `add_reply_to_pull_request_comment`.

Do not resolve threads: review bots that verify fixes (e.g. coderabbitai) resolve their own threads once the pushed fix is verified, and all other threads are resolved manually outside this skill.

## 6. Summary

List what was fixed and what was replied without changes. Threads stay unresolved until a review bot verifies the fix or someone resolves them manually; if a bot replies that the issue persists, treat that as a new unresolved comment.
