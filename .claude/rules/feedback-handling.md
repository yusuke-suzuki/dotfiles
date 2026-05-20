# Feedback Handling

Apply when responding to real-time user feedback about your own behavior or prior actions.

## Do not update memory or rules on the spot

When the user gives behavioral feedback during a session, do not write to memory or rule files immediately. Defer durable behavioral guidance to the `/retro` workflow at session end.

Self-initiated writes mid-session conflict with the user's retrospective process: the retro is the stage where violations, root causes, and countermeasures are structured together, and skipping ahead to a memory write fragments that analysis.

One-off factual memories the user explicitly asks to save (e.g. "remember that the Grafana dashboard is at X") fall outside this rule — it targets behavioral corrections, not factual capture.

## Verify before answering

When responding from your own knowledge or reconstruction, verify against the actual source before answering. The following situations require verification:

1. **Explaining your own prior actions** — when asked about the cause of your own prior action ("why did you do X?"), verify against the actual record (tool call history, referenced context, file state). If verification is not possible in the current context, say so explicitly rather than offering a plausible-sounding guess.

   This includes the case where your own posted output appears to have been modified externally. Verify by comparing what was sent (tool call arguments, prior message) against what now exists on the remote. Do not produce plausible-sounding guesses like "the system seems to have modified it" — fetch the current state and the original payload, then state the diff factually.
2. **Answering questions about a rule, config, or spec** — read the relevant file first. Do not paraphrase from memory when the source is accessible.
3. **Carrying subagent output into a deliverable** — when incorporating Plan / Explore agent reports into a PR description, commit message, or code, re-verify the technical claims against the source. Subagent output is unverified until you check it.
4. **Responding to a reviewer's flagged scenario** — before analyzing mechanisms, applying a defensive fix, or accepting a reviewer's proposed change, verify whether the flagged scenario can actually occur. Check the spec, naming constraints, type system, or other invariants that may make the scenario impossible. A theoretically valid concern about an impossible scenario does not warrant a fix — reply with the constraint that rules the scenario out, and stop. This applies equally to human reviewers and automated bots.

## Suppress test execution during design discussions

While the user is iterating on a design (back-and-forth on naming, structure, or approach — "discussion mode"), refrain from running tests, builds, or other expensive verifications until the discussion settles or the user explicitly requests them.

Running tests during design iteration:

- Slows the conversation while the design is still moving.
- Suggests confidence in a draft that may still change.
- Pulls focus from the design question to test output.

Resume normal verification once the design is agreed.
