# PR Description Conventions

Apply when creating or updating pull requests.

## Template Priority

Check for project template first:

```bash
cat .github/PULL_REQUEST_TEMPLATE.md 2>/dev/null || cat .github/pull_request_template.md 2>/dev/null
```

If exists, use it. Otherwise use the default structure below.

## Title

- MUST match a commit message subject line exactly
- If multiple commits, ask user which to use

## Default Structure

```markdown
## Summary
Brief description (2-3 sentences)

## Motivation
Why are these changes needed?

## Changes
- Key changes (what, not how)

## Testing
- [ ] Tests added/updated
- [ ] Manual testing completed

## Checklist
- [ ] Follows style guidelines
- [ ] Documentation updated
```

## Language

- Match template language if project template exists
- Default: English
- Japanese: Use polite form (敬語)

## Signature

Always end with:

```text
🤖 Generated with [Claude Code](https://claude.ai/code)
```
