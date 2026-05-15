# Writing Style (Japanese)

Apply to all Japanese prose text (documents, comments, descriptions).

## Relative References

Replace relative pointers with concrete references (class name,
method name, PR number, commit id). Time-relative references rot
when the document is read later. The `copyeditor` agent runs the
detailed checks.

## Vocabulary

Prefer plain Japanese over katakana / English loanwords when
natural Japanese exists. Established technical proper nouns
(`JSON`, `API`, `Pull Request`) are acceptable. The `copyeditor`
agent runs the detailed checks.

## Style Consistency

When editing existing Japanese text, match the established formality
(です/ます vs である/だ). Never mix within the same context.

## Scope

Do NOT modify: database values, API responses.
