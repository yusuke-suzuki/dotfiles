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
