# Dotfiles Repository

This repository is the source of truth for Claude Code configuration. `install.sh` deploys `.claude/` (CLAUDE.md, settings.json, rules, skills) to `~/.claude/`.

When modifying Claude configuration, always edit the source files under this repository's `.claude/` directory — never the deployed copies under `~/.claude/`. Commit the change, then run `install.sh` to deploy.
