# dotfiles

Personal dotfiles, managed with [chezmoi](https://www.chezmoi.io/).

## What's Included

| Source | Deploys to | Purpose |
| --- | --- | --- |
| `dot_zshrc`, `dot_zprofile` | `~/.zshrc`, `~/.zprofile` | Shell config with mise activation: `mise activate` for interactive shells, `--shims` for login shells so agent-driven commands (Claude Code, Cursor) resolve mise-managed tools without a `mise exec` prefix |
| `dot_config/mise/` | `~/.config/mise/` | Global mise configuration |
| `dot_agents/skills/` | `~/.agents/skills/` | Agent skills, shared by Claude Code and Cursor |
| `dot_claude/` | `~/.claude/` | Claude Code settings and rules, plus per-skill symlinks into `~/.agents/skills/` |
| `dot_cursor/rules/` | `~/.cursor/rules/` | Cursor user rules (`.mdc`) |
| `.chezmoitemplates/rules/` | — | Single source for rule content, included by both `dot_claude/rules/*.md.tmpl` and `dot_cursor/rules/*.mdc.tmpl` |

### Agent Configuration

- **Rules** are engineering rules loaded into every conversation of both Claude Code and Cursor. The content lives once under `.chezmoitemplates/rules/` and is deployed with the extension each tool requires (Claude Code reads `~/.claude/rules/*.md`, [Cursor](https://cursor.com/help/customization/rules) reads `~/.cursor/rules/*.mdc`); the files carry Cursor's frontmatter (`description`, `alwaysApply`), which Claude Code tolerates.
- **Skills** are specialized capabilities, loaded only when a task calls for them. The content lives once under `dot_agents/skills/` and deploys to the tool-neutral `~/.agents/skills/`: [Cursor loads it natively](https://cursor.com/docs/skills) as one of its first-class skill locations (no reliance on its compatibility fallback that scans `~/.claude/skills/`), and Claude Code reads it through per-skill symlinks at `~/.claude/skills/<skill-name>` ([documented behavior](https://code.claude.com/docs/en/skills); symlinking each entry rather than the whole directory also keeps `~/.claude/skills/` a real directory, so claude.ai-synced skills under `~/.claude/skills/synced/` stay Claude-only instead of leaking into Cursor). Skill files reference their own scripts via `~/.agents/skills/…` so the instructions work identically in both tools.
- **Tool-specific behavior** stays under each tool's own directory — Claude Code hooks and settings in `dot_claude/settings.json`, Cursor-only configuration in `dot_cursor/` — so the two tools can diverge (e.g. a hook enabled for one and absent for the other). Cursor's "Include Third-party Plugins, Skills, and Other Configs" setting can stay off: nothing here depends on Cursor scanning `~/.claude/`.

Guidance that applies to one kind of task belongs in the skill that handles it, not in a rule — skills stay out of context until they are relevant. There is no user-level CLAUDE.md: rules load with the same priority and, unlike CLAUDE.md, reach Cursor too.

## Installation

```bash
gh repo clone yusuke-suzuki/dotfiles ~/dotfiles
cd ~/dotfiles
./install.sh
```

`install.sh` installs chezmoi via mise if missing, points it at this clone (`sourceDir` in `~/.config/chezmoi/chezmoi.toml`), and runs `chezmoi apply`.

> [!WARNING]
> `chezmoi apply` overwrites `~/.zshrc` and `~/.zprofile` with the managed versions. On a machine with existing shell config, first move machine-specific content to `~/.zshrc.local` / `~/.zprofile.local` (sourced by the managed files), or reconcile with `chezmoi diff` and `chezmoi merge ~/.zshrc` after the bootstrap.

### Updating

```bash
chezmoi update   # git pull the source directory, then apply
```

After editing sources locally, run `chezmoi apply` to deploy.

> [!WARNING]
> On a machine where an earlier version deployed the skills as real directories under `~/.claude/skills/`, remove those skill directories once before applying (e.g. `rm -rf ~/.claude/skills/commit` for each managed skill) so chezmoi can replace them with symlinks into `~/.agents/skills/`. `~/.claude/skills/` itself stays a real directory, so unmanaged content such as `~/.claude/skills/synced/` is unaffected.

### Requirements

- Git (the system one is fine)
- mise — the one manually installed tool; everything else (chezmoi, gh, node) is declared in its global config and installed by `install.sh`
