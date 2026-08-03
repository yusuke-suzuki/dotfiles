---
name: address-comments
description: Address PR review comments — analyze, fix, push, and reply
---

# Address Comments

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

Enter plan mode (EnterPlanMode) and write the per-comment plan — quoted comment, path/line, analysis, recommended action — in the user's response language. Present via ExitPlanMode and do not proceed until approved. Once approved, execute steps 4-6 in a single pass — do not re-enter plan mode or revise the approved actions.

## 4. Fix and push

Apply the approved fixes, then commit and push before posting any reply — invoke `/fixup` (or `/commit` for an independent change), then `/publish`. A reply posted while the fix exists only locally cannot be verified: review bots such as coderabbitai respond that they cannot confirm the fix.

Skip this step when every action is "No change".

## 5. Reply

Reply on every thread selected in step 1 (one reply, posted on the thread's last comment) to keep an audit trail, regardless of author (human or bot), matching the original comment's language. For fixes, reference the pushed commit id. Post the reply to the last comment's `databaseId`: `gh api -X POST /repos/{owner}/{repo}/pulls/{number}/comments/{comment_id}/replies -f body="..."`, or MCP `add_reply_to_pull_request_comment`.

Do not resolve threads: review bots that verify fixes (e.g. coderabbitai) resolve their own threads once the pushed fix is verified, and all other threads are resolved manually outside this skill.

## 6. Summary

List what was fixed and what was replied without changes. Threads stay unresolved until a review bot verifies the fix or someone resolves them manually; if a bot replies that the issue persists, treat that as a new unresolved comment.
