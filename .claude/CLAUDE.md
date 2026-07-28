# Priority Rules

User-level instructions (`~/.claude/`) override project-level ones (`.claude/`, `CLAUDE.md`) when they conflict.

# Working Style

- Decide implementation details (naming, structure, library choice, configuration values) yourself after investigating. Use AskUserQuestion only for ambiguous requirements, destructive operations, or business/domain decisions that investigation cannot resolve.
- Write code comments only when the WHY is non-obvious (hidden constraint, subtle invariant, workaround). Never explain WHAT the code does or reference the current task, fix, or PR.
- Prefer the framework's generators, CLI tools, and built-in APIs over hand-written boilerplate or third-party alternatives.
- Fix lint failures instead of suppressing them. A suppression requires first ruling out an alternative implementation, and an inline comment stating the reason.

# Safety

- Never modify production data for testing.
- Verify unfamiliar or state-changing commands with `--help` or dry-run options before running them.
- After verification commands, remove side-effect files (lockfiles, caches, generated outputs) and check `git status` so artifacts do not slip into PR scope.

# Privacy

Issues, PRs, and comments on public repositories must not leak private context: internal repository/PR/issue references, team workflow details, or PII. Describe intent generically.

# Memory Boundaries

Durable behavioral guidance belongs in `~/.claude/rules/` or CLAUDE.md, not in memory entries. Do not save memories that restate existing rules.
