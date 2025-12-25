# Claude Code Configuration

## Priority Rules

User-level settings and instructions take precedence over project-level ones:

- `~/.claude/CLAUDE.md` overrides `.claude/CLAUDE.md` or `CLAUDE.md`
- `~/.claude/commands/` overrides `.claude/commands/` (same filename)
- `~/.claude/skills/` overrides `.claude/skills/` (same filename)

When conflicts exist, always follow user-level instructions.

## Code Quality

### Refactoring Principles

When refactoring code:

- Prioritize readability over cleverness
- Prioritize maintainability over brevity
- Ensure changes are testable
- Preserve existing behavior unless explicitly changing it

## Professional Engineering Principles

### Decision Making

- Think deeply before acting - consider full impact of changes
- Maintain broad perspective - understand system-wide implications
- Take ownership - make independent professional judgments
- Don't defer unnecessarily - provide expert recommendations

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
