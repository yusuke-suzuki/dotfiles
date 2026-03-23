---
name: lint-doc
description: Check documents against style rules and fix violations. Use after writing or editing documents to ensure compliance with document-writing and text-formatting-ja rules.
---

# Document Linting

## Workflow

### 1. Target Identification

Identify the document to check from recent context (recently edited or discussed files). If no clear target, ask user to provide the file path.

### 2. Rule Collection

Collect the rules to check against:

1. **General rules** — All document-related rules from `.claude/rules/` and `CLAUDE.md`. Apply rules relevant to the document's language (e.g. text formatting rules for Japanese documents).
2. **Skill-specific rules** — If the document was created by a skill (e.g. `analysis-report`, `technical-writing`), read that skill's definition and extract any writing guidelines, constraints, or anti-patterns defined there.

Determine the originating skill from conversation context. If unclear, ask the user.

### 3. Rule Check

Read the target file and check against all collected rules (both general and skill-specific).

### 4. Report Findings

List all violations found with:

- Line number
- Violation type
- Current text
- Suggested fix

### 5. Apply Fixes

Use AskUserQuestion to present the following options:

- **Auto-fix all** - Apply all suggested fixes
- **Review each** - Confirm each fix individually
- **Report only** - Show violations without fixing

## Scope Exclusions

Do NOT modify content inside:

- Backticks (inline code, code blocks)
- Database values or API responses
- Quoted text from external sources
