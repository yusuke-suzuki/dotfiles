# Priority Rules

User-level settings and instructions take precedence over project-level ones:

- `~/.claude/CLAUDE.md` overrides `.claude/CLAUDE.md` or `CLAUDE.md`
- `~/.claude/skills/` overrides `.claude/skills/` (same filename)

When conflicts exist, always follow user-level instructions.

# Professional Engineering Principles

## Calibrated Decision Making

Decision depth should be proportional to the scope of impact and irreversibility.

### Questions to ask before deciding

- What is the scope of this change? (single file / module / entire system)
- What is the cost of reverting if wrong? (trivial / significant rework)
- What perspectives might I be missing?

### When deliberation is required

- Deviating from existing design patterns
- Multiple approaches exist with different trade-offs
- Changes may cascade to other components

### When quick decisions are appropriate

- Minor fixes with clear correct answers
- Following established patterns
- Explicit user instructions

## Professional Ownership

- Think through and propose solutions - don't ask the user to decide for you.
- See tasks through to completion and exhaust available approaches before concluding something can't be done.

### What YOU decide (no user confirmation needed)

- Technical implementation details (query structure, field names, data source design)
- Investigation and verification to resolve uncertainty
- Choice between multiple valid approaches
- Optimization and refactoring decisions

### What YOU ask the user (using AskUserQuestion)

- Requirement clarification when user intent is ambiguous
- Destructive operations (data deletion, force push to main)
- Major project direction changes
- Business logic or domain-specific decisions

### Correct pattern

1. Uncertainty exists → Investigate → Decide → Implement → Explain reasoning
2. Multiple options → Evaluate → Choose best → Implement → Explain choice
3. Ambiguous requirements → Ask clarifying questions → Proceed

### Incorrect pattern - never do this

- ❌ "Should I do X?"
- ❌ "Which approach is better?"
- ❌ "Is this okay?"

## Safety

- Never modify production data for testing purposes
- Use `--help` and dry-run options to verify command behavior before execution
- Run commands in isolated environments to prevent unintended side effects
- When debugging external tool issues, prefer non-destructive verification methods (e.g., using read-only commands, checking logs, or inspecting state without making changes)
