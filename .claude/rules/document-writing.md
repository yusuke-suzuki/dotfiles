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

Write naturally. Avoid:

- Bullet lists where prose flows better
- Exaggerated or emphatic expressions:
  - "revolutionary", "game-changing", "seamless", "robust", "cutting-edge"
  - "very", "extremely", "significantly" (without quantitative evidence)
  - "This is important because...", "It's worth noting...", "Crucially..."
- Repeating information
- Vague expressions (overuse of "etc.", "such as", "and so on")

### Style Consistency

When editing existing documents, match the established writing style:

- **Japanese documents**: Match the formality level (敬語 vs 常体)
  - If the document uses です/ます (polite form), continue with polite form
  - If the document uses である/だ (plain form), continue with plain form
- **English documents**: Match the tone and voice (formal, casual, technical)
- Never mix styles within the same document, except in clearly demarcated sections (e.g., quoted text, appendices, or code examples)
