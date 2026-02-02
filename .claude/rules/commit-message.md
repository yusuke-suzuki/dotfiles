# Commit Message Conventions

Apply when creating git commits.

## Format

- [Conventional Commits](https://www.conventionalcommits.org/) format
- English, imperative mood, present tense
- Example: `feat: add user authentication` (not `added`)

## Subject Line

- Maximum 50 characters (including prefix and scope)
- Verify: `echo -n "subject" | wc -c`

## Body

- Blank line after subject
- Wrap at 72 characters
- Add blank lines between paragraphs for readability
- Explain the rationale for the change (the "why"), not just what was modified or how it was implemented

## Example

```text
feat: add user authentication

Implement JWT-based authentication to secure API endpoints.
This addresses the security requirements outlined in issue #123.
```
