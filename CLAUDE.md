# Dotfiles Repository

This repository is the source of truth for shell, mise, Claude Code, and Cursor configuration, managed with chezmoi. `install.sh` bootstraps chezmoi; `chezmoi apply` deploys the `dot_`-prefixed sources to `$HOME` (`dot_claude/` → `~/.claude/`, `dot_zshrc` → `~/.zshrc`, and so on).

Agent guidance lives only in skills, packaged as the `dev` plugin under `plugins/dev/`; there are no always-on rules. Claude Code and Codex install it through the marketplaces in `.claude-plugin/` and `.agents/plugins/`, Devin from `plugins/dev`, and Cursor from `~/.cursor/plugins/local/dev`, which `.chezmoiexternal.toml` extracts from the `main` tarball. When adding a skill, create `plugins/dev/skills/<name>/SKILL.md`, mark its scripts executable in git, and reference bundled files relative to the skill's base directory. Descriptions load into every session and bodies only on demand, so keep both minimal. Tool-specific configuration goes under `dot_claude/` for Claude Code and `dot_cursor/` for Cursor (currently none).

To correct agent behavior, prefer countermeasures in this order:

1. **Mechanical enforcement** — settings.json permissions or hooks, a textlint/prh dictionary entry, or a script inside a skill. A deterministic check beats prose asking the model to be careful.
2. **Skill fix** — correct the on-demand workflow that produced the violation; it loads only when invoked. Guidance that applies to one kind of task belongs here even when no skill covers it yet — a new skill costs only its description until it is relevant.
3. **Deletion or simplification** — when the violation stems from conflicting or over-constraining instructions.

Never propose "be more careful".

Deleting a source does not delete what an earlier `chezmoi apply` deployed: when removing a deployed file or skill, remove its target in a new `run_once_after_` script, not `.chezmoiremove`, which applies on every run and would also delete whatever is later installed at the same path. Never edit an existing `run_once_` script: chezmoi reruns one whose content changes, which would repeat its earlier removals.

chezmoi source naming applies outside `plugins/`, which chezmoi ignores: executable scripts need the `executable_` prefix, and files deployed with a leading dot need the `dot_` prefix (plain dot-prefixed names are ignored by chezmoi).

When modifying configuration, always edit the source files in this repository — never the deployed copies under `$HOME`. Commit the change, then run `chezmoi apply` to deploy.
