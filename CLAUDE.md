# Dotfiles Repository

This repository is the source of truth for Claude Code and Cursor configuration. `install.sh` deploys `.claude/` (settings.json, rules, skills) to `~/.claude/`, and deploys the same rule files to `~/.cursor/rules/` with the `.mdc` extension Cursor requires. Cursor reads the skills from `~/.claude/skills/` directly.

Rule files carry Cursor's frontmatter (`description`, `alwaysApply`) and must stay valid for both tools. Instructions that only matter for a specific task belong in that task's skill rather than a rule, which loads into every session.

When modifying Claude configuration, always edit the source files under this repository's `.claude/` directory — never the deployed copies under `~/.claude/`. Commit the change, then run `install.sh` to deploy.
