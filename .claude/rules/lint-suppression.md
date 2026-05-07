# Lint Suppression

Apply when adding any inline lint suppression comment
(`# rubocop:disable`, `# eslint-disable`, `// noqa`, etc.).

## Three checks before suppressing

Before adding a suppression comment, answer all three questions.
Suppression is allowed only when each can be answered concretely.

1. **What does the rule prevent?** Name the specific failure mode
   the rule was designed to catch (e.g., "this rule prevents
   accidental shadowing of a standard library name"). If the
   rule's intent cannot be stated, the suppression is uninformed.
2. **Does an alternative implementation avoid the issue?** Try the
   alternative first. Suppression is a last resort once the
   alternative has been ruled out — not a first response to a
   failing lint. If the alternative is rejected, name the reason
   (cost, readability, scope) so the rejection is auditable.
3. **Is the rule misapplied for this context?** Some rules
   trigger on patterns the rule was not designed for (e.g., a
   complexity metric counting boilerplate that has no real
   complexity). When the rule is misapplied, suppression is
   correct; when it is correctly flagging a real issue,
   suppression hides the issue rather than fixing it.

Suppression without all three checks passing is not allowed. The
default response to a lint failure is to fix the underlying issue.

## When suppressing

Document the reason inline alongside the suppression comment, in
the form "suppress because <reason from checks 2 or 3>". A
suppression without an inline reason rots — the next reader
cannot tell whether the rule was misapplied or whether the
suppression was a shortcut, and removing the suppression to
re-evaluate becomes risky.
