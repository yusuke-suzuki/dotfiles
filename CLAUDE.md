# Dotfiles Repository

This repository is the source of truth for shell, mise, Claude Code, and Cursor configuration, managed with chezmoi. `install.sh` bootstraps chezmoi; `chezmoi apply` deploys the `dot_`-prefixed sources to `$HOME` (`dot_claude/` → `~/.claude/`, `dot_zshrc` → `~/.zshrc`, and so on).

Agent guidance lives only in skills under `dot_agents/skills/` (deployed to the tool-neutral `~/.agents/skills/`, which Cursor reads natively; Claude Code reads each skill through a per-skill symlink deployed from `dot_claude/skills/symlink_<skill-name>`); there are no always-on rules. When adding a skill, create the skill directory under `dot_agents/skills/` and the matching symlink stub. Descriptions load into every session and bodies only on demand, so keep both minimal. Tool-specific configuration goes under `dot_claude/` for Claude Code and `dot_cursor/` for Cursor (currently none).

To correct agent behavior, prefer countermeasures in this order:

1. **Mechanical enforcement** — settings.json permissions or hooks, a textlint/prh dictionary entry, or a script inside a skill. A deterministic check beats prose asking the model to be careful.
2. **Skill fix** — correct the on-demand workflow that produced the violation; it loads only when invoked. Guidance that applies to one kind of task belongs here even when no skill covers it yet — a new skill costs only its description until it is relevant.
3. **Deletion or simplification** — when the violation stems from conflicting or over-constraining instructions.

Never propose "be more careful".

Deleting a source does not delete what an earlier `chezmoi apply` deployed: when removing a deployed file or skill, list its target in `.chezmoiremove`.

chezmoi source naming applies: executable scripts need the `executable_` prefix, and files deployed with a leading dot need the `dot_` prefix (plain dot-prefixed names are ignored by chezmoi).

When modifying configuration, always edit the source files in this repository — never the deployed copies under `$HOME`. Commit the change, then run `chezmoi apply` to deploy.
