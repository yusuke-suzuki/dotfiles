---
name: resolve-comments
description: Resolve PR review comments
---

# Resolve Comments

You are assisting with resolving PR review comments. Follow these steps:

## 1. Fetch Review Comments

Identify the PR for the current branch:

**With `gh`**:

```bash
gh pr view --json number,headRepositoryOwner
```

**With GitHub MCP**: use the `list_pull_requests` tool with owner, repo, and the current branch as the head.

Fetch review threads with thread IDs, resolution state, and embedded comments:

**With `gh`**: fetch via GraphQL since thread IDs are not exposed by the REST API:

```bash
gh api graphql -f query='query {
  repository(owner: "OWNER", name: "REPO") {
    pullRequest(number: NUMBER) {
      reviewThreads(first: 50) {
        nodes {
          id
          isResolved
          comments(first: 50) {
            nodes {
              databaseId
              author { login }
              body
              path
              line
              diffHunk
            }
          }
        }
      }
    }
  }
}'
```

**With GitHub MCP**: use the `pull_request_read` tool with `method: "get_review_comments"`, owner, repo, and the PR number. The response returns review threads with `id`, `isResolved`, and embedded comments containing `databaseId`, author, body, path, line, and diff hunk.

Format and display unresolved threads showing: author, file path, line number, diff hunk, and comment body.

## 2. Analyze and Draft Response Plan

For each unresolved comment:

1. Verify the premise: can the flagged scenario actually occur? Check the spec, naming constraints, type system, or other invariants. If the scenario is impossible, draft a "No change" reply citing the constraint and skip the remaining steps for this comment — a theoretically valid concern about an impossible scenario does not warrant a fix.
2. Read the relevant source code to understand the full context
3. Assess the feedback: Is it technically correct? Does it improve the code?
4. Evaluate trade-offs: complexity, scope, practical impact
5. Do not accept suggestions uncritically — weigh them against the code's design intent and existing patterns
6. Draft a recommended action: fix (with specific changes) or explain why no change is needed (with rationale)

## 3. Present Plan for Review

Use the `EnterPlanMode` tool to enter plan mode, then write a response plan to the plan file containing all comments and their proposed resolutions. The plan is a user-facing deliverable, so write it in the user's response language (`language` in `~/.claude/settings.json`).

- For each comment, include:
  - The comment text (quoted)
  - File path and line number
  - Your analysis of the feedback's validity
  - Recommended action: **Fix** (describe what to change) or **No change** (explain why)
- Use the `ExitPlanMode` tool to present the plan for user review

The user reviews the plan and either approves or provides corrections. Do not proceed to Step 4 until the plan is approved.

## 4. Execute Approved Plan

After approval, process all comments according to the plan:

**Principle:** Reply to every comment to maintain an audit trail of resolution decisions. This is mandatory for all comments, regardless of author (human, bot, or automated tool), and applies even if no human is expected to read the reply.

**If fix required:**

- Make the necessary code changes
- Draft a brief acknowledgment as the reply (e.g., "Done")
- Inform user to use `/fixup` or `/commit` after all fixes are complete

**If no action needed:**

- Draft a reply with clear rationale (e.g., "Won't fix because...", "Intentional design because...")
- **Match the language of the original comment** (e.g., reply in Japanese if the comment is in Japanese)

**Step 1 — Reply** (must succeed before proceeding to Step 2):

Reply to the last comment in the thread (use its `databaseId` as `comment_id`).

**With `gh`**:

```bash
gh api -X POST /repos/{owner}/{repo}/pulls/{number}/comments/{comment_id}/replies -f body="..."
```

**With GitHub MCP**: use the `add_reply_to_pull_request_comment` tool with owner, repo, pullNumber, commentId, and the reply body.

**Step 2 — Resolve** (only after the reply in Step 1 succeeds):

**With `gh`**:

```bash
gh api graphql -f query='mutation {
  resolveReviewThread(input: {threadId: "THREAD_ID"}) {
    thread { isResolved }
  }
}'
```

**With GitHub MCP**: use the `pull_request_review_write` tool with `method: "resolve_thread"` and the thread ID obtained in Step 1's fetch.

**Never run reply and resolve in parallel.** If the reply fails, do not resolve the thread.

## 5. Summary

After processing all comments:

- List what was fixed (if any)
- List what was resolved without changes (if any)
- Suggest next steps (e.g., `/fixup` to amend, `/publish` to push)
