# dotfiles

Personal dotfiles, managed with [chezmoi](https://www.chezmoi.io/).

## What's Included

| Source | Deploys to | Purpose |
| --- | --- | --- |
| `dot_zshrc`, `dot_zprofile` | `~/.zshrc`, `~/.zprofile` | Shell config with mise activation: `mise activate` for interactive shells, `--shims` for login shells so agent-driven commands (Claude Code, Cursor) resolve mise-managed tools without a `mise exec` prefix |
| `dot_config/mise/` | `~/.config/mise/` | Global mise configuration |
| `dot_claude/` | `~/.claude/` | Claude Code settings, rules, and skills |
| `dot_cursor/rules/` | `~/.cursor/rules/` | Cursor user rules (`.mdc`) |
| `.chezmoitemplates/rules/` | — | Single source for rule content, included by both `dot_claude/rules/*.md.tmpl` and `dot_cursor/rules/*.mdc.tmpl` |

### Agent Configuration

- **Rules** are engineering rules loaded into every conversation of both Claude Code and Cursor. The content lives once under `.chezmoitemplates/rules/` and is deployed with the extension each tool requires (Claude Code reads `~/.claude/rules/*.md`, [Cursor](https://cursor.com/help/customization/rules) reads `~/.cursor/rules/*.mdc`); the files carry Cursor's frontmatter (`description`, `alwaysApply`), which Claude Code tolerates.
- **Skills** are specialized capabilities, loaded only when a task calls for them. [Cursor loads skills](https://cursor.com/docs/skills) from `~/.claude/skills/`, so one deployment covers both tools.

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

### Requirements

- Git (the system one is fine)
- mise — the one manually installed tool; everything else (chezmoi, gh, node) is declared in its global config and installed by `install.sh`
