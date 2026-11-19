# dotfiles

Personal dotfiles, managed with [chezmoi](https://www.chezmoi.io/).

## What's Included

| Source | Deploys to | Purpose |
| --- | --- | --- |
| `dot_zshrc`, `dot_zprofile` | `~/.zshrc`, `~/.zprofile` | Shell config with mise activation: `mise activate` for interactive shells, `--shims` for login shells so agent-driven commands (Cursor) resolve mise-managed tools without a `mise exec` prefix. On Apple silicon, login shells also load Homebrew's environment from `/opt/homebrew` first |
| `dot_config/mise/` | `~/.config/mise/` | Global mise configuration |
| `dot_claude/` | `~/.claude/` | Claude Code settings |
| `plugins/dev/` | — | Agent skills, installed as the `dev` plugin (see [Agent Plugin](#agent-plugin)) |
| `.chezmoiexternal.toml` | `~/.cursor/plugins/local/dev` | The `dev` plugin for Cursor, extracted from the `main` tarball |
| `run_once_after_remove-legacy-agent-files.sh` | — | Removes, once per machine, the rules and skill files an earlier version deployed, leaving anything installed at those paths afterwards alone |

### Agent Configuration

- **Skills** carry all agent guidance, loaded only when a task calls for them: workflow skills (the history operations `coding-standards` routes to) and knowledge skills (`coding-standards`, which also carries the git workflow rules, and `ruby-on-rails-best-practices`). There are no always-on rules or user-level CLAUDE.md, so every session starts from the model's defaults plus skill descriptions. The skills ship as one plugin, `dev`, in the shared `skills/<name>/SKILL.md` layout, with a `.claude-plugin/plugin.json` for Claude Code and an [Agent Plugins](https://agent-plugins.org/) `plugin.json` for Cursor, Codex, and Devin. Installing it as a plugin, not as files under `~/.agents/skills/`, reaches cloud agents that never run this repository's `install.sh`, and avoids loading each skill twice in Codex and Devin, which both scan `~/.agents/skills/`. Skills reference bundled files relative to their own base directory, so they work wherever the plugin is installed.
- **mise tools in Claude Code**: Claude Code runs Bash commands as non-login shells from a snapshot that pins `PATH` to the one Claude Code was launched with (the Mac app extracts it from `~/.zshrc`, where `mise activate` drops the shims and adds only the tools resolved when the profile was read), so neither `~/.zprofile` shims nor the `mise activate` hook reach them. `settings.json` points `CLAUDE_ENV_FILE` at `~/.claude/env.sh`, which puts the mise shims on `PATH`; Claude Code sources it after the snapshot, so `bundle exec` and `bin/rspec` resolve the project's Ruby without a `mise exec` prefix. It is an env setting rather than a `SessionStart` hook because a project's `disableAllHooks` also switches off user-level hooks.
- **Tool-specific behavior** stays under each tool's own directory — Claude Code hooks and settings in `dot_claude/private_settings.json.tmpl`, Cursor-only configuration in `dot_cursor/` (currently none) — so the two tools can diverge (e.g. a hook enabled for one and absent for the other). Cursor's "Include Third-party Plugins, Skills, and Other Configs" setting can stay off: nothing here depends on Cursor scanning `~/.claude/`.

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

### Agent Plugin

| Tool | Install |
| --- | --- |
| Claude | In the Claude app, Plugins → Add → Add marketplace with `yusuke-suzuki/dotfiles`, then install `dev`. An account plugin reaches the desktop app, cloud sessions, and Claude Code in a terminal, so no per-machine install is needed. On a machine with the desktop app it is recorded in `~/.claude/settings.json` (`extraKnownMarketplaces`, `enabledPlugins`), which the settings template repeats so that `chezmoi apply` does not undo it. Only for Claude Code signed in without a Claude account: `claude plugin marketplace add yusuke-suzuki/dotfiles`, then `claude plugin install dev@dotfiles` |
| Codex | `codex plugin marketplace add yusuke-suzuki/dotfiles`, then install `dev` from `/plugins` |
| Devin | `devin plugins install yusuke-suzuki/dotfiles#plugins/dev` |
| Cursor | `chezmoi apply` extracts it to `~/.cursor/plugins/local/dev`; Cursor's own marketplace import from a repository can be disabled by an organization policy, and a local plugin cannot be a symlink to a folder outside `~/.cursor/plugins/local/`. chezmoi re-downloads it once a day, or on `chezmoi apply --refresh-externals`; reload the Cursor window afterwards. On an Enterprise plan, Cursor loads local plugins only after an admin enables Allow Local Plugin Imports (Dashboard → Settings → Security & Identity → Marketplace and Plugins), which is off by default |

Plugins track the `main` branch, so a skill change reaches them once it is merged and each tool updates the plugin.

### Requirements

- Git (the system one is fine)
- mise — the one manually installed tool; everything else (chezmoi, gh, node) is declared in its global config and installed by `install.sh`
