# Feedback Handling

Apply when responding to real-time user feedback about your own
behavior or prior actions.

## Do not update memory or rules on the spot

When the user gives behavioral feedback during a session, do not write
to memory or rule files immediately. Defer durable behavioral guidance
to the `/retro` workflow at session end.

Self-initiated writes mid-session conflict with the user's retrospective
process: the retro is the stage where violations, root causes, and
countermeasures are structured together, and skipping ahead to a
memory write fragments that analysis.

One-off factual memories the user explicitly asks to save (e.g. "remember
that the Grafana dashboard is at X") fall outside this rule — it
targets behavioral corrections, not factual capture.

## Verify before answering

When responding from your own knowledge or reconstruction, verify
against the actual source before answering. The following situations
require verification:

1. **Explaining your own prior actions** — when asked about the
   cause of your own prior action ("why did you do X?"), verify
   against the actual record (tool call history, referenced context,
   file state). If verification is not possible in the current
   context, say so explicitly rather than offering a
   plausible-sounding guess.
2. **Answering questions about a rule, config, or spec** — read the
   relevant file first. Do not paraphrase from memory when the
   source is accessible.
3. **Stating a technical fact** (numeric boundary, semantics,
   naming, history) — verify against source code or `git log`
   rather than relying on recollection.
4. **Carrying subagent output into a deliverable** — when
   incorporating Plan / Explore agent reports into a PR description,
   commit message, or code, re-verify the technical claims against
   the source. Subagent output is unverified until you check it.
