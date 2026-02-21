---
name: technical-writing
description: Write technical design documents (design docs, specs, proposals). Use when creating design documents, technical specifications, project proposals, or similar structured technical content.
---

# Technical Writing

## Workflow

1. **Understand context**: Problem, stakeholders, constraints
2. **Choose template**: Based on document type
3. **Write**: Section by section

## Document Templates

- Design Doc: [templates/design-doc.md](templates/design-doc.md) — describes problem definition through solution. Sections 5-9 are optional; include only when applicable.

## Key Principles

### Data-Driven Decision Making

Base design decisions on real data, not assumptions.

### Code Verification

All code in documents must be verified before inclusion.

- Include only in executable state
- When editing content within code blocks, verify correctness by executing the code. This applies to every edit regardless of size — including renames, constant changes, and incremental modifications
- Never fabricate data

### Problem First

- Start with the problem, not the solution
- Make the "why" compelling before the "how"
