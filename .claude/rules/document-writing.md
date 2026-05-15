# Document Writing

Apply when writing or editing documents.

## Structural Integrity

A document is a logically coherent narrative, not a collection of independent sections. Each section's story determines what belongs and what doesn't: add content that advances the story, remove content that contradicts or distracts from it.

When modifying a document:

1. **Read first** - Understand the overall structure before making partial changes
2. **Update all affected sections** - When the story changes, maintain consistency throughout
3. **Remove obsolete content** - Delete content that becomes redundant after modifications

Documents must be self-contained. Do not use relative links to other local files — they break when the document is shared outside the repository (e.g., Notion, Google Docs).

Documents are deliverables, not workspaces. Never add:

- Progress tracking sections ("Next Steps", "TODO", checklists)
- Claude's internal notes or reminders
- Meta-commentary about the writing process

Use the TodoWrite tool for task management instead.

## Templates

When a template is provided (PR templates, issue templates, etc.),
preserve its structure and formatting. Do not remove sections,
reorder items, or alter formatting (strikethrough, checkboxes, HTML
comments, etc.). Fill in the provided sections; add new sections
only if the template explicitly allows it.

## Progressive Disclosure

- Explain concepts before details
- Explain "why" before "how"
- State the next step explicitly

## Writing Style

Tone and vocabulary rules in `writing-style.md` and
`writing-style-ja.md` apply. Documents additionally:

- Avoid bullet lists where prose flows better.
- Match the established formality (敬語 vs 常体 for Japanese; formal,
  casual, or technical voice for English) when editing existing
  documents. Never mix styles within the same document, except in
  clearly demarcated sections (quoted text, appendices, code
  examples).
