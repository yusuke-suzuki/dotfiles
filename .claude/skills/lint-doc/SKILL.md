---
name: lint-doc
description: Check documents against style rules and fix violations. Use after writing or editing documents to ensure compliance with document-writing and text-formatting-ja rules.
allowed-tools: Read, Edit, Glob
---

# Document Linting

**Rules**: Apply [document-writing](../../rules/document-writing.md) and [text-formatting-ja](../../rules/text-formatting-ja.md).

## Workflow

### 1. Target Identification

- If file path provided as argument, use that file
- Otherwise, ask user which file to check

### 2. Rule Check

Read the target file and check against each rule. For Japanese documents, apply both rules. For English documents, apply document-writing only.

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
