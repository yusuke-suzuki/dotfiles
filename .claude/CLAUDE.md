# Personal Claude Code Configuration

This configuration defines global preferences and conventions for all projects.

## Commit Message Conventions

Follow these rules when generating commit messages:

### Format

- Use [Conventional Commits](https://www.conventionalcommits.org/) format
- Write in English using imperative mood and present tense
- Example: `feat: add user authentication` not `feat: added user authentication`

### Subject Line

- Maximum 50 characters including prefix and scope
- Count characters accurately (e.g., `feat: add feature` = 18 characters)
- **IMPORTANT**: Verify character count before committing:
  ```bash
  echo -n "your subject line" | wc -c
  ```
- If over 50 characters, shorten before committing

### Body

- Separate subject from body with a blank line
- Wrap body text at 72 characters
- Add blank lines between paragraphs for readability
- Explain **what** and **why**, not **how**
- Omit introductory phrases like "Here is the commit message"

### Example

```
feat: add user authentication

Implement JWT-based authentication to secure API endpoints.
This addresses the security requirements outlined in issue #123.

The implementation uses industry-standard libraries and follows
OWASP best practices for credential storage.
```

## Code Quality

### Refactoring Principles

When refactoring code:

- Prioritize readability over cleverness
- Prioritize maintainability over brevity
- Ensure changes are testable
- Preserve existing behavior unless explicitly changing it

## Writing Style

### Avoid AI-like Writing

When writing documentation, comments, or any prose:

- Write naturally, as a human engineer would
- Avoid overly formal or stilted phrasing
- Do not use bullet-point lists to explain something that flows better as prose
- Avoid redundant emphasis phrases like "This is important because...", "It's worth noting that..."
- Do not repeat information unnecessarily
- Keep explanations concise and direct

## Localization Guidelines

### Japanese Text Formatting

Apply these rules to prose text (documents, comments, descriptions):

- **Spacing**: Add half-width spaces around alphanumeric characters and English words
  - ✅ `追加された権限 (18 件)`
  - ❌ `追加された権限（18件）`

- **Parentheses**: Use half-width `()` instead of full-width `（）`
  - ✅ `ユーザー (User) が追加されました`
  - ❌ `ユーザー（User）が追加されました`

- **Important**: DO NOT modify actual data values
  - Preserve text in backticks, database values, API responses as-is
  - These rules apply only to human-readable prose

## Pull Request Guidelines

### Before Creating/Editing a PR

1. **Check for PR template**:
   ```bash
   ls -la .github/PULL_REQUEST_TEMPLATE.md
   ```

2. **If template exists**:
   - Read the template file first
   - Follow the template structure exactly
   - Fill in all required sections appropriately

3. **If editing existing PR without template**:
   - Apply template structure if available
   - Reorganize content to match template sections
   - Keep original content but improve organization

### PR Requirements

- **Title**: MUST match commit message subject line exactly
- **Description**: Follow template structure if available
- **Checklists**: Mark items as "N/A" with explanation if not applicable
- **Japanese text**: Apply spacing and parentheses rules
- **Signature**: Always include at the end:
  ```
  🤖 Generated with [Claude Code](https://claude.ai/code)
  ```

### Example PR Structure

```markdown
## Summary
Brief description of changes (2-3 sentences)

## Motivation
Why are these changes needed?

## Changes
- Bullet point list of key changes
- Focus on what changed, not how

## Testing
- [ ] Unit tests added/updated
- [ ] Manual testing completed
- [ ] Edge cases considered

## Checklist
- [ ] Code follows project style guidelines
- [ ] Documentation updated
- [ ] Breaking changes documented

🤖 Generated with [Claude Code](https://claude.ai/code)
```

## Professional Engineering Principles

### Decision Making

- **Think deeply before acting**: Consider full impact of changes
- **Maintain broad perspective**: Understand system-wide implications
- **Take ownership**: Make independent professional judgments
- **Don't defer unnecessarily**: Provide expert recommendations

### Code Changes

- Consider backward compatibility
- Assess performance implications
- Think about edge cases and error handling
- Plan for future maintainability

### Communication

- Be clear and concise
- Provide rationale for decisions
- Surface trade-offs and alternatives
- Document non-obvious choices

### Document Consistency

When modifying any document, ensure comprehensive consistency:

1. **Identify modification point**: Clearly understand what is being changed
2. **Analyze impact scope**: Consider what other sections might be affected
3. **Check related sections**: Review the entire document for related content
4. **Verify consistency**: Ensure numbers, terms, and expressions are consistent throughout
5. **Batch update**: Update all related areas simultaneously, not piecemeal

This principle applies especially to:

- Design documents with metrics and data
- Technical specifications with cross-references
- Documentation with repeated concepts or values

## BigQuery Query Development Guidelines

### Query Verification Requirements

**CRITICAL**: All queries and data included in documentation MUST be verified with `bq` command before inclusion. This is essential for credibility and trust.

Never include:

- Unverified queries in documents
- Made-up data or results
- Queries that haven't been tested

### Query Development Process

1. **Dry Run First**: Always validate query syntax and check cost before execution
   ```bash
   bq query --project_id=<PROJECT_ID> --use_legacy_sql=false --dry_run "SELECT ..."
   ```
   - Cost guideline: <1GB is light, 2GB+ requires optimization
   - Cost: ~$5/TB ($0.005/GB)

2. **Execute and Wait**: Run query and wait at least 10 seconds for results
   ```bash
   bq query --project_id=<PROJECT_ID> --use_legacy_sql=false --format=csv "SELECT ..."
   # Wait 10+ seconds (increase to 30s if results don't appear)
   ```
   - `bq query` runs asynchronously - results may not appear immediately
   - Heavier queries (2GB+) may require longer wait times

3. **Learn from Existing Queries**: Study queries already in project documentation
   - Date range patterns
   - Table selection (especially partitioned tables)
   - Filter conditions and JOIN patterns

### Query Design Principles

- **Specify exact date ranges**: Avoid unnecessary data scans
  ```sql
  WHERE created_at >= DATETIME('2025-10-01 00:00:00')
    AND created_at < DATETIME('2025-11-01 00:00:00')
  ```

- **Always filter partitioned tables by partition key**

- **Avoid correlated subqueries**: Use JOINs or CTEs with pre-aggregation

- **Filter target records early**: Create CTEs to narrow down targets before joining large tables

### Documentation Standards

When including queries in documentation:

1. **Verify execution**: Run the exact query with `bq` command
2. **Include actual results**: Copy real output, never fabricate data
3. **Add context comments**: Explain what the query measures
4. **Note data period**: Clearly state the time period analyzed
5. **Document optimization**: Mention any performance optimizations applied

## Design Documents

Confidential design documents are stored in `~/dotfiles/docs.local/`. This directory is git-ignored and remains local-only.

### Referencing Design Documents

When working on implementation tasks, check for relevant design documents:

```bash
ls ~/dotfiles/docs.local/
```

Read design documents to understand architecture decisions, API specifications, data models, and integration patterns before implementing features.

### File Naming Convention

- `<project>-<feature>.md` for feature designs
- `<project>-architecture.md` for architecture overviews
- `<topic>-guide.md` for cross-project guidelines
