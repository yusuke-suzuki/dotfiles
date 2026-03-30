---
name: resolve-comments
description: Resolve PR review comments
---

# Resolve Comments

You are assisting with resolving PR review comments. Follow these steps:

## 1. Fetch Review Comments

First, get PR info and review comments:

```bash
gh pr view --json number,headRepositoryOwner
gh api /repos/{owner}/{repo}/pulls/{number}/comments
```

Format and display comments showing: author, file path, line number, diff hunk, and comment body.

Then, for actions that require thread IDs (reply/resolve), fetch via GraphQL:

```bash
gh api graphql -f query='
query {
  repository(owner: "OWNER", name: "REPO") {
    pullRequest(number: NUMBER) {
      reviewThreads(first: 50) {
        nodes {
          id
          isResolved
          comments(first: 10) {
            nodes {
              databaseId
              body
              path
              line
            }
          }
        }
      }
    }
  }
}'
```

## 2. Analyze and Draft Response Plan

For each unresolved comment:

1. Read the relevant source code to understand the full context
2. Assess the feedback: Is it technically correct? Does it improve the code?
3. Evaluate trade-offs: complexity, scope, practical impact
4. Do not accept suggestions uncritically — weigh them against the
   code's design intent and existing patterns
5. Draft a recommended action: fix (with specific changes) or
   explain why no change is needed (with rationale)

## 3. Present Plan for Review

Enter plan mode and write a response plan to the plan file containing
all comments and their proposed resolutions:

- For each comment, include:
  - The comment text (quoted)
  - File path and line number
  - Your analysis of the feedback's validity
  - Recommended action: **Fix** (describe what to change) or
    **No change** (explain why)
- Exit plan mode to present the plan for user review

The user reviews the plan and either approves or provides corrections.
Do not proceed to Step 4 until the plan is approved.

## 4. Execute Approved Plan

After approval, process all comments according to the plan:

**Principle:** Reply to every comment to maintain an audit trail of resolution decisions. This is mandatory for all comments, regardless of author (human, bot, or automated tool), and applies even if no human is expected to read the reply.

**If fix required:**

- Make the necessary code changes
- Reply to acknowledge the fix (e.g., "Done")
- Resolve the thread
- Inform user to use `/fixup` or `/commit` after all fixes are complete

**If no action needed:**

- Draft a reply with clear rationale (e.g., "Won't fix because...", "Intentional design because...")
- **Match the language of the original comment** (e.g., reply in Japanese if the comment is in Japanese)
- Reply to the last comment in the thread (use its `databaseId` as `comment_id`)
- **Step 1 — Reply** (must succeed before proceeding to Step 2):

```
POST /repos/{owner}/{repo}/pulls/{number}/comments/{comment_id}/replies
```

```bash
gh api /repos/{owner}/{repo}/pulls/{number}/comments/{comment_id}/replies -X POST -f body="..."
```

- **Step 2 — Resolve** (only after the reply in Step 1 succeeds):

```bash
gh api graphql -f query='
mutation {
  resolveReviewThread(input: {threadId: "THREAD_ID"}) {
    thread { isResolved }
  }
}'
```

**Never run reply and resolve in parallel.** If the reply fails, do not resolve the thread.

## 5. Summary

After processing all comments:

- List what was fixed (if any)
- List what was resolved without changes (if any)
- Suggest next steps (e.g., `/fixup` to amend, `/publish` to push)
