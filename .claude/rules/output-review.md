# Output Review

Apply when sending user-facing output that does not pass through a
skill workflow's own copyeditor invocation.

## Why this rule exists

Skill workflows (`publish`, `commit`, `retro`, `design-doc`,
`analysis-report`) invoke the `copyeditor` agent on their output
before sending. Output produced outside those workflows
— plan files, PR review replies, regular chat, AskUserQuestion
descriptions — has no equivalent gate, and recurring vocabulary
and fact-verification failures have happened in those contexts.

## When copyeditor invocation is required

Invoke the `copyeditor` agent before sending output that meets
any of the following:

- **Long-form paragraph output.** Roughly 200 characters or more
  of Japanese prose, or a comparable span of English prose.
- **Structured text.** Output containing headings, lists,
  tables, or block quotes that the user will read end-to-end.
- **Plan files.** Plans authored via `EnterPlanMode` / read by
  `ExitPlanMode` are user-facing deliverables. Run the
  copyeditor before calling `ExitPlanMode`.
- **PR / issue / review comment bodies created outside a skill
  workflow.** When responding to a review thread or commenting
  on an issue without going through `publish` or
  `resolve-comments`, the body is still user-facing output and
  needs the same review.

## When copyeditor invocation is not required

- Short conversational replies (under the length threshold and
  no structural elements).
- Code-only output (the diff itself, no prose).
- Tool call arguments that are not user-prose (file paths,
  command flags, JSON payloads).
- Internal Bash output the user does not read end-to-end.

## How to invoke

Use the `Agent` tool with `subagent_type: copyeditor`. Pass:

1. The draft text verbatim.
2. The destination (plan file, PR review reply, etc.).
3. Fact-verification pointers the agent may need to look up
   sources: branch name, referenced PR / issue numbers, file
   paths mentioned in the draft. Limit this to look-up pointers
   — nothing more.

Do not pass inspection scope to the agent. The copyeditor's
inspection categories are defined in its own spec, and narrowing
the scope risks the agent reviewing only the listed perspectives
and missing the rest. Do not include:

- Lists of check categories ("check katakana loanwords and
  particles") — the agent already runs all inspection
  categories.
- Severity ranking or priority hints ("focus on fact
  verification") — the agent's output is already ordered by
  severity.
- Excerpts from `writing-style.md` / `writing-style-ja.md` —
  the agent already incorporates those rules into its checks.

Apply the agent's findings before sending the draft. If a
finding is rejected, state the reason in your response — silent
rejection of a copyeditor finding defeats the gate.

## Interaction with `Self-review before submitting`

`communication.md` "Self-review before submitting" runs first,
as the author's pass. The copyeditor runs second, as the
external pass on the same draft. They are not redundant: the
self-review catches what the author can catch reading their own
text; the copyeditor catches what the author missed.

When the copyeditor flags an axis the self-review already
covered, that is a signal the self-review pass was skipped on
that axis. Treat it as a self-review failure to address in the
next retro, not as a copyeditor false positive.
