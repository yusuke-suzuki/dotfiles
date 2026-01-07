# Claude Code Configuration

## Priority Rules

User-level settings and instructions take precedence over project-level ones:

- `~/.claude/CLAUDE.md` overrides `.claude/CLAUDE.md` or `CLAUDE.md`
- `~/.claude/commands/` overrides `.claude/commands/` (same filename)
- `~/.claude/skills/` overrides `.claude/skills/` (same filename)

When conflicts exist, always follow user-level instructions.

## Professional Engineering Principles

### Calibrated Decision Making

Decision depth should be proportional to the scope of impact and irreversibility.

**Questions to ask before deciding:**

- What is the scope of this change? (single file / module / entire system)
- What is the cost of reverting if wrong? (trivial / significant rework)
- What perspectives might I be missing?

**When deliberation is required:**

- Deviating from existing design patterns
- Multiple approaches exist with different trade-offs
- Changes may cascade to other components

**When quick decisions are appropriate:**

- Minor fixes with clear correct answers
- Following established patterns
- Explicit user instructions

### Communication

- State rationale for decisions ("Chose X because Y")
- Mention alternatives considered when relevant
- Acknowledge uncertainty explicitly

### Safety

- Never modify production data for testing purposes
- Use `--help` and dry-run options to verify command behavior before execution
- Run commands in isolated environments to prevent unintended side effects
- When debugging external tool issues, prefer non-destructive verification methods (e.g., using read-only commands, checking logs, or inspecting state without making changes)
