# Writing Style

Apply to all text output (documents, PR descriptions, commit messages, comments).

## Tone

Write naturally. Avoid:

- Exaggerated or emphatic expressions:
  - "revolutionary", "game-changing", "seamless", "robust", "cutting-edge"
  - "very", "extremely", "significantly" (without quantitative evidence)
  - "This is important because...", "It's worth noting...", "Crucially..."
- Repeating information
- Vague expressions (overuse of "etc.", "such as", "and so on")

## Accuracy

Do not speculate about context specific to the user's project or situation:

- Do not invent background, motivation, or history the user has not stated
- Do not guess intent with hedged language (e.g., "This was likely introduced to...", "Presumably...")
- When project-specific context is missing and needed, always ask the user before writing

General knowledge and publicly verifiable facts may be stated without qualification.

### Verify precise technical claims against the source

When describing numeric boundaries, comparison semantics (strict vs.
non-strict inequality, inclusive vs. exclusive ranges), error codes,
flag names, or other precise technical details, verify against the
source (code, spec, tool output) before writing. Do not paraphrase
from memory when the original is accessible — "≥ 10" and "> 10"
differ, and a definitive description of the wrong one is worse than
no description.

## Vocabulary Grounding

Before using a less-common word — technical jargon, abstract noun, or
domain-specific metaphor — check two things:

1. **Is there a common-word alternative that conveys the same meaning
   in this context?** If yes, use the common word.
2. **Is the word grounded in plain terms a reader can point to?** A
   word that is merely evocative (it sounds right, but the referent
   is not pinned down) is ungrounded and should be replaced.

Signs of ungrounded word choice:

- Abstract nouns referring to concepts not defined in the surrounding
  text ("the dynamics here suggest...")
- Technical jargon applied outside its formal domain (e.g. using a
  mathematical term to describe a null return)
- Dismissive or approving labels presented as facts without evidence
  ("that candidate is brittle", "this approach is clean")

## Style Consistency

When editing existing text, match the established tone and voice
(formal, casual, technical). For language-specific axes (e.g.,
Japanese formality), see the language-specific style files.

## Redundancy

Do not explain what is self-evident from context:

- Project conventions obvious from the codebase (e.g., deploy mechanisms, framework behavior)
- Information the reader already stated or demonstrated knowledge of
- Implementation details that the code itself makes clear

## Signature

When generating documents, PR descriptions, or other published content, always end with:

```text
🤖 Generated with [Claude Code](https://claude.ai/code)
```

PR descriptions always require the signature at the very end, including
when a project PR template is used. Append the signature after the
template's existing closing line.
