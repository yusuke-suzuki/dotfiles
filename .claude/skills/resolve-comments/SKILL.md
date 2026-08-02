---
name: resolve-comments
description: Resolve PR review comments
---

# Resolve Comments

## 1. Fetch threads

Identify the PR for the current branch (`gh pr view --json number,headRepositoryOwner`, or MCP `list_pull_requests`). Fetch review threads with thread ids, resolution state, and embedded comments:

- **`gh`** (GraphQL — REST does not expose thread ids): query `repository → pullRequest → reviewThreads(first: 50) { nodes { id isResolved comments(first: 50) { nodes { databaseId author { login } body path line diffHunk } } } }`
- **MCP**: `pull_request_read` with `method: "get_review_comments"`

Both return paginated results — follow the `pageInfo` cursors while `hasNextPage` so no thread or comment is missed.

Exclude unresolved threads whose last comment is the current user's own reply (`gh api /user` or MCP `get_me` for the login) — they are awaiting the reviewer's response and re-enter scope only when a newer comment arrives. Display the remaining unresolved threads: author, path, line, diff hunk, body.

## 2. Analyze

For each unresolved comment:

1. Verify the flagged scenario can actually occur (spec, naming constraints, type system, invariants). If it cannot, draft a "No change" reply citing the constraint and skip the rest.
2. Read the relevant code, assess the feedback's validity and trade-offs, and weigh it against the design intent — do not accept suggestions uncritically.
3. Draft the action: **Fix** (specific changes) or **No change** (rationale).

## 3. Plan approval

Enter plan mode (EnterPlanMode) and write the per-comment plan — quoted comment, path/line, analysis, recommended action — in the user's response language. Present via ExitPlanMode and do not proceed until approved.

## 4. Fix and push

Apply the approved fixes, then commit and push before posting any reply — invoke `/fixup` (or `/commit` for an independent change), then `/publish`. A reply posted while the fix exists only locally cannot be verified: review bots such as coderabbitai respond that they cannot confirm the fix.

Skip this step when every action is "No change".

## 5. Reply and resolve

Reply on every unresolved thread (one reply, posted on the thread's last comment) to keep an audit trail, regardless of author (human or bot), matching the original comment's language. For fixes, reference the pushed commit id.

1. **Reply** to the last comment's `databaseId`: `gh api -X POST /repos/{owner}/{repo}/pulls/{number}/comments/{comment_id}/replies -f body="..."`, or MCP `add_reply_to_pull_request_comment`.
2. **Resolve**: GraphQL mutation `resolveReviewThread(input: {threadId: ...})`, or MCP `pull_request_review_write` with `method: "resolve_thread"`. Reply first, then resolve — never in parallel, and never resolve if the reply failed.

Exception — do not resolve a thread where a fix was pushed and the author of the thread's root (first) comment is a review bot that verifies fixes and resolves its own threads (e.g. coderabbitai) — later replies by other authors do not change this classification. The bot's resolution is its confirmation that the pushed commit addresses the comment, and resolving manually pre-empts that verification. "No change" threads have nothing for the bot to verify, so resolve them manually as usual.

## 6. Summary

List what was fixed and what was resolved without changes. Note threads left unresolved pending a review bot's verification; if the bot later replies that the issue persists, treat that as a new unresolved comment.
