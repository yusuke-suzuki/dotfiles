# Document Writing

Apply when writing or editing documents.

## Structural Integrity

A document is not a collection of independent sections but a logically coherent narrative. Each section should build on previous sections, and all content should serve the document's central argument or purpose.

### Principles for Modifications

1. **Read the entire document before editing** - Understand the overall structure and argument before making partial changes
2. **Consider impact on the narrative** - Evaluate how modifications affect the logical flow of the entire document
3. **Update all related occurrences** - Search the entire document for terms/expressions being modified and update all instances
4. **Remove obsolete sections** - Actively delete sections that become redundant or unnecessary after modifications

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

## Writing Style

Write naturally. Avoid:

- Bullet lists where prose flows better
- Exaggerated or emphatic expressions:
  - "revolutionary", "game-changing", "seamless", "robust", "cutting-edge"
  - "very", "extremely", "significantly" (without quantitative evidence)
  - "This is important because...", "It's worth noting...", "Crucially..."
- Repeating information
- Vague expressions (overuse of "etc.", "such as", "and so on")
