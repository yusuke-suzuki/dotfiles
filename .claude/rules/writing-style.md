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

## Vocabulary

Prefer plain words. Replace abstract jargon, domain-foreign
metaphors, evaluative adjectives without concrete indicators,
and ungrounded abstract nouns with the plainest alternative
that carries the same meaning.

The `copyeditor` agent runs the detailed checks (modifier-of
relationships, evaluative adjective replacement, false-contrast
framing, fact verification against source). The intent at the
authoring stage is to catch the obvious cases before invoking
it.

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
