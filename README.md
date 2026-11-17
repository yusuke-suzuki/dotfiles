# dotfiles

Personal dotfiles, managed with [chezmoi](https://www.chezmoi.io/).

## What's Included

| Source | Deploys to | Purpose |
| --- | --- | --- |
| `dot_zshrc`, `dot_zprofile` | `~/.zshrc`, `~/.zprofile` | Shell config with mise activation: `mise activate` for interactive shells, `--shims` for login shells so agent-driven commands (Cursor) resolve mise-managed tools without a `mise exec` prefix. On Apple silicon, login shells also load Homebrew's environment from `/opt/homebrew` first |
| `dot_config/mise/` | `~/.config/mise/` | Global mise configuration |
| `dot_agents/skills/` | `~/.agents/skills/` | Agent skills, shared by Claude Code and Cursor |
| `dot_claude/` | `~/.claude/` | Claude Code settings, plus per-skill symlinks into `~/.agents/skills/` |
| `.chezmoiremove` | — | Previously deployed targets that `chezmoi apply` removes |

### Agent Configuration

- **Skills** carry all agent guidance, loaded only when a task calls for them: workflow skills (`git-workflow` and the history operations it routes to) and knowledge skills (`coding-standards`, `ruby-on-rails-best-practices`). There are no always-on rules or user-level CLAUDE.md, so every session starts from the model's defaults plus skill descriptions. The content lives once under `dot_agents/skills/` and deploys to the tool-neutral `~/.agents/skills/`: [Cursor loads it natively](https://cursor.com/docs/skills) as one of its first-class skill locations (no reliance on its compatibility fallback that scans `~/.claude/skills/`), and Claude Code reads it through per-skill symlinks at `~/.claude/skills/<skill-name>` ([documented behavior](https://code.claude.com/docs/en/skills); symlinking each entry rather than the whole directory also keeps `~/.claude/skills/` a real directory, so claude.ai-synced skills under `~/.claude/skills/synced/` stay Claude-only instead of leaking into Cursor). Skill files reference their own scripts via `~/.agents/skills/…` so the instructions work identically in both tools.
- **mise tools in Claude Code**: Claude Code runs Bash commands as non-login shells from a snapshot that pins `PATH` to the one Claude Code was launched with (the Mac app extracts it from `~/.zshrc`, where `mise activate` drops the shims and adds only the tools resolved when the profile was read), so neither `~/.zprofile` shims nor the `mise activate` hook reach them. `settings.json` points `CLAUDE_ENV_FILE` at `~/.claude/env.sh`, which puts the mise shims on `PATH`; Claude Code sources it after the snapshot, so `bundle exec` and `bin/rspec` resolve the project's Ruby without a `mise exec` prefix. It is an env setting rather than a `SessionStart` hook because a project's `disableAllHooks` also switches off user-level hooks.
- **Tool-specific behavior** stays under each tool's own directory — Claude Code hooks and settings in `dot_claude/settings.json.tmpl`, Cursor-only configuration in `dot_cursor/` (currently none) — so the two tools can diverge (e.g. a hook enabled for one and absent for the other). Cursor's "Include Third-party Plugins, Skills, and Other Configs" setting can stay off: nothing here depends on Cursor scanning `~/.claude/`.

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
