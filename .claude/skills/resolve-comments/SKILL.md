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

## 2. Analyze and Propose Response

For each unresolved comment, analyze the feedback and make a professional judgment:

1. **Assess validity**: Is the feedback technically correct? Does it improve the code?
2. **Evaluate trade-offs**: Consider complexity, scope, and practical impact
3. **Propose action**: Recommend either fixing or explaining why no change is needed

Present your analysis and recommendation to the user for each comment. The user makes the final decision, but you should provide clear reasoning for your recommendation.

## 3. Handle Response

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

## 4. Summary

After processing all comments:

- List what was fixed (if any)
- List what was resolved without changes (if any)
- Suggest next steps (e.g., `/fixup` to amend, `/publish` to push)
