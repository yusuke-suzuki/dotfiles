# Dotfiles Repository

This repository is the source of truth for Claude Code configuration. `install.sh` deploys `.claude/` (CLAUDE.md, settings.json, skills) to `~/.claude/`, and writes `~/.cursor/user-rules.md` for Cursor, which reads the skills from `~/.claude/skills/` directly.

Instructions that only matter for a specific task belong in that task's skill rather than CLAUDE.md, which loads into every session.

When modifying Claude configuration, always edit the source files under this repository's `.claude/` directory — never the deployed copies under `~/.claude/`. Commit the change, then run `install.sh` to deploy.
