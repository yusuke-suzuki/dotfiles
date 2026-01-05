# Coding Standards

Apply when writing or reviewing code.

## Naming

- Names must convey domain meaning - avoid generic names like `base_query`, `data`, `result`, `tmp`
- When uncertain about naming or patterns, investigate the codebase first

## Design

- Keep functions and classes focused on a single responsibility
- Prioritize readability over cleverness
- Prioritize maintainability over brevity
- Preserve existing behavior unless explicitly changing it
- Maintain consistency across related files and similar patterns

## Quality

- Never compromise quality for CI cost or time savings
- Ensure changes are testable
- Consider backward compatibility
- Assess performance implications
- Think about edge cases and error handling
- Plan for future maintainability
