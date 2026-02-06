---
name: lint-doc
description: Check documents against style rules and fix violations. Use after writing or editing documents to ensure compliance with document-writing and text-formatting-ja rules.
---

# Document Linting

## Workflow

### 1. Target Identification

Identify the document to check from recent context (recently edited or discussed files). If no clear target, ask user to provide the file path.

### 2. Rule Check

Read the target file and check against [document-writing](rules/document-writing.md) and [text-formatting-ja](rules/text-formatting-ja.md). For Japanese documents, apply both rules. For English documents, apply document-writing only.

### 3. Report Findings

List all violations found with:

- Line number
- Violation type
- Current text
- Suggested fix

### 4. Apply Fixes

Ask user whether to:

1. **Auto-fix all** - Apply all suggested fixes
2. **Review each** - Confirm each fix individually
3. **Report only** - Show violations without fixing

## Scope Exclusions

Do NOT modify content inside:

- Backticks (inline code, code blocks)
- Database values or API responses
- Quoted text from external sources
