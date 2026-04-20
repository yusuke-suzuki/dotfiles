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

## Verify before explaining your own actions

When asked about the cause of your own prior action ("why did you do
X?"), do not answer from reconstruction or guesswork. Verify against
the actual record — tool call history, referenced context, file state
— before responding.

If verification is not possible in the current context, say so
explicitly rather than offering a plausible-sounding guess.
