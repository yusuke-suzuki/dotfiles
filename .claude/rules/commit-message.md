# Commit Message Conventions

Apply when creating git commits.

## Format

- Conventional Commits format
- English, imperative mood, present tense
- Example: `feat: add user authentication` (not `added`)

## Subject Line

- Maximum 50 characters (including prefix and scope)
- Verify: `echo -n "subject" | wc -c`

## Body

- Blank line after subject
- Start each sentence on a new line
- Wrap at 72 characters
- Add blank lines between paragraphs for readability
- Explain the rationale for the change (the "why"),
  not just what was modified or how it was implemented

### Examples

**Bad** - describes what changed, sentences not separated by newlines:
```
refactor: reorganize auth module

Remove legacy login handler. Move token refresh logic to middleware. Update error codes to use standard format.

Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
```

**Good** - explains why, each sentence on a new line, blank lines between paragraphs:
```
refactor: reorganize auth module

The legacy login handler duplicated logic already
covered by the OAuth flow introduced in v2.

Moving token refresh into middleware reduces repeated
try/catch blocks across six route handlers.

Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
```
