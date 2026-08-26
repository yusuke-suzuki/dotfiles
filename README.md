# dotfiles

Personal dotfiles for managing development environment configurations.

## What's Included

### Agent Configuration

- **rules/** - Engineering rules, loaded into every conversation of both Claude Code and Cursor
- **skills/** - Specialized capabilities, loaded only when a task calls for them

Guidance that applies to one kind of task belongs in the skill that handles it, not in a rule — skills stay out of context until they are relevant.

Both formats are shared across tools from a single source:

- **Skills**: [Cursor loads skills](https://cursor.com/docs/skills) from `~/.claude/skills/` for compatibility with Claude Code, so one deployment covers both.
- **Rules**: the same rule files are deployed twice — to `~/.claude/rules/*.md` for Claude Code and to `~/.cursor/rules/*.mdc` for [Cursor's user rule files](https://cursor.com/help/customization/rules). The content is byte-identical; only the extension differs, because each tool ignores the other's (Cursor ignores plain `.md` in its rules directory, Claude Code ignores `.mdc`). The files carry Cursor's frontmatter (`description`, `alwaysApply`); Claude Code tolerates those fields.

There is no user-level CLAUDE.md: rules without `paths` frontmatter load with the same priority, and unlike CLAUDE.md they reach Cursor too. Note that `~/.cursor/rules` stays machine-local — Cursor does not sync it between devices; re-running `install.sh` on each machine is the sync mechanism.

### mise Configuration

Global mise configuration template. `install.sh` also sets up shell activation following the [official two-file setup](https://mise.jdx.dev/dev-tools/shims.html): `mise activate` in the interactive shell config (`~/.zshrc` / `~/.bashrc`) and `mise activate --shims` in the login shell config (`~/.zprofile` / `~/.bash_profile`), so non-interactive shells — such as the ones Claude Code and Cursor run commands in — resolve mise-managed tools without a `mise exec` prefix. Lines are appended only when the file does not already reference `mise activate`, so hand-written setups are preserved.

## Installation

```bash
gh repo clone yusuke-suzuki/dotfiles ~/dotfiles
cd ~/dotfiles
./install.sh
```

### What Gets Installed

```text
~/.claude/
├── settings.json
├── rules/
│   └── *.md
└── skills/

~/.cursor/
└── rules/
    └── *.mdc

~/.config/mise/
└── config.toml
```

### Requirements

- Git
- GitHub CLI (`gh`)
- mise
- Node.js / npm (the `textlint` skill runs textlint via `npx`)

### Updating

```bash
cd ~/dotfiles
git pull
./install.sh
```
