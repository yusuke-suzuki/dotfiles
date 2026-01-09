# Document Writing

Apply when writing or editing documents.

## Structural Integrity

A document is a logically coherent narrative, not a collection of independent sections. Each section's story determines what belongs and what doesn't: add content that advances the story, remove content that contradicts or distracts from it.

When modifying a document:

1. **Read first** - Understand the overall structure before making partial changes
2. **Update all affected sections** - When the story changes, maintain consistency throughout
3. **Remove obsolete content** - Delete content that becomes redundant after modifications

## Content Verification

All code and queries in documents must be verified before inclusion.

- SQL: Validate syntax with `bq query --dry_run`, execute to confirm, and include actual results
- Code: Include only in executable state
- Never fabricate data

## Data-Driven

- Include real data, not hypotheticals
- Define KPIs with baselines and targets
- Quantify impact (counts, costs, time)

## Diagrams

Use Mermaid notation for diagrams. Do not use ASCII art.

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
