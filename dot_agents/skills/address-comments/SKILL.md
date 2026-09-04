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

Fetch the current user's login (`gh api /user` or MCP `get_me`) to identify the user's own comments — threads where the user commented last stay in scope, and step 2 decides their disposition. Display all unresolved threads: author, path, line, diff hunk, body.

Review bots wrap their own verification transcripts, bundled linter output, and tracking metadata in `<details>` blocks and HTML comments, which routinely outweigh the finding itself. Before reading a bot-authored body, drop `(?s)<!--.*?-->` and every `<details>` block that carries no fenced `suggestion` or `diff` — those hold the bot's proposed change and are the one part worth keeping. Leave human-authored comments intact: a human's `<details>` block can hold the finding itself.

## 2. Analyze

For each thread selected in step 1, covering every comment the thread contains — later comments refine or extend the finding, and none may be silently dropped:

1. Verify the flagged scenario can actually occur (spec, naming constraints, type system, invariants). If it cannot, the verdict is "No change" citing the constraint.
2. Read the relevant code, assess the feedback's validity and trade-offs, and weigh it against the design intent — do not accept suggestions uncritically.
3. Consolidate into one verdict and action per thread: **Fix** (specific changes), **No change** (rationale), or **Waiting** — the user's own last comment already states the complete response (verdict and rationale), so the thread needs nothing until the reviewer replies. A last comment of the user's that is a memo, a plan note, or an interim answer promising work is not Waiting; the promised work is the thread's action. For Fix and No change, the rationale here is the seed for the review reply — keep the design reason, not only the code change.

## 3. Draft replies

Write the final reply text for every thread whose action is Fix or No change — one reply per thread, regardless of author (human or bot), to keep an audit trail; a Waiting thread gets no reply — before entering plan mode, in the language of the comment being answered. The plan review in step 4 is the only review these bodies get, so draft at posting quality; there is no later polishing step.

A reply is a turn in a conversation with the reviewer, and reviewers judge it as they would a design decision. Write for a reviewer who has not seen the plan and cannot infer intent from the diff:

- **Answer what was actually said.** A question gets a direct answer, a proposed alternative gets an explicit accept-or-reject with the reason, a misreading gets the correction. Open by naming, in your own words, the concern being answered — a verdict with no visible connection to the comment reads as a non-answer — then give the verdict and its reasoning.
- **Reason for the reviewer, not for the record.** Grounds are things the reviewer can check — a constraint, a spec, observed code behavior, a measured trade-off — stated so that someone who disagrees knows exactly what to dispute. A rationale that asserts the author's intent or effort defends the author instead of informing the reviewer. Carry the step 2 rationale over in full; do not compress it to one line.
- **Complete sentences, explicit referents.** Every sentence keeps its subject and object explicit; never compress to a fragment whose actor or target the reviewer must reconstruct from context they do not have. Where brevity and clarity conflict, clarity wins. The diff already shows *what* changed; the reply carries the *why* — so do not quote the review back wholesale or narrate the code change line by line, but do spell out every referent by name.
- **Write in the user's voice.** Replies post under the user's account; write as the account owner addressing a colleague, in the register the user's own comments use, and avoid assistant mannerisms a colleague would not type by hand. Natural register never overrides the requirements above; it is how they read, not a license to omit.
- For a Fix, reference the pushed commit with a placeholder for the id; step 6 substitutes the real id after push.

Every draft then passes the lint gate before it enters the plan:

1. For Japanese drafts, run the `textlint` skill and fix every reported violation, including the detect-only rules that need manual edits (particle errors, sentence style). Reports are blockers, not advisories: a draft with an unaddressed violation neither enters the plan nor gets posted.
2. Run the `copyedit` skill's checks over the drafts (facts, consistency, reader perspective) and fix every finding, re-running until clean — copyedit findings block the plan and the posting exactly as textlint reports do.

## 4. Plan approval

Enter plan mode (EnterPlanMode) and write the per-comment plan in the user's response language. For each unresolved thread, include its thread id and first-comment `databaseId` (the posting target in step 6 — two threads can share path, line, and body, so the plan must carry the immutable key), path/line, the stripped bodies of all its comments from step 1 in posted order, the verdict with its reasoning, the action, and the reply text drafted and linted in step 3 — verbatim and in full, in its posting language; a Waiting thread carries its Waiting reasoning instead of a reply, so the judgment can be overridden at approval. The reply body in the plan is itself a reviewable artifact; do not summarize it. The plan must be enough to approve without opening GitHub. Present via ExitPlanMode and do not proceed until approved. Once approved, execute steps 5-7 in a single pass — do not re-enter plan mode or revise the approved actions.

## 5. Fix and push

Apply the approved fixes, then commit and push before posting any reply — invoke `/fixup` (or `/commit` for an independent change), then push (`--force-with-lease` after a fixup rebase). A reply posted while the fix exists only locally cannot be verified: review bots such as coderabbitai respond that they cannot confirm the fix.

Skip this step unless at least one action is a Fix.

## 6. Reply

Post each approved reply exactly as approved, substituting only the pushed commit id for its placeholder — no other rewriting after approval.

Post to the `databaseId` of the thread's **first** comment, as recorded in the approved plan entry — the reply endpoint takes a top-level comment id, not that of a reply: `gh api -X POST /repos/{owner}/{repo}/pulls/{number}/comments/{comment_id}/replies -f body="..."`, or MCP `add_reply_to_pull_request_comment`.

Do not resolve threads: review bots that verify fixes (e.g. coderabbitai) resolve their own threads once the pushed fix is verified, and all other threads are resolved manually outside this skill.

## 7. Summary

List what was fixed, what was replied without changes, and which threads are waiting on the reviewer. Threads stay unresolved until a review bot verifies the fix or someone resolves them manually; if a bot replies that the issue persists, treat that as a new unresolved comment.
