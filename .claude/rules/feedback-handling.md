# Feedback Handling

- When the user gives behavioral feedback mid-session, do not write rules or memory on the spot. Defer durable guidance to the `/retro` workflow at session end. Factual memories the user explicitly asks to save are exempt.
- Verify against the actual source before answering: read the rule/config/spec file instead of paraphrasing from memory; check the task registry before reporting background-task status (especially after a user interrupt); confirm a reviewer-flagged scenario can actually occur before fixing it — if a spec, type, or invariant rules it out, reply with that constraint instead of a fix.
- While the user is iterating on a design, hold off on tests, builds, and other expensive verification until the design settles or the user asks.
