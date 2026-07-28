# dotfiles

Personal dotfiles for managing development environment configurations.

## What's Included

### Claude Code Configuration

- **CLAUDE.md** - Professional engineering principles
- **rules/** - Always-on rules applied across all conversations
- **skills/** - Specialized capabilities for specific tasks

### mise Configuration

Global mise configuration template.

## Installation

```bash
gh repo clone yusuke-suzuki/dotfiles ~/dotfiles
cd ~/dotfiles
./install.sh
```

### What Gets Installed

```text
~/.claude/
├── CLAUDE.md
├── rules/
└── skills/

~/.config/mise/
└── config.toml
```

### Requirements

- Git
- GitHub CLI (`gh`)
- mise
- Node.js / npm (used by the `copyedit` skill to run textlint)

### Updating

```bash
cd ~/dotfiles
git pull
./install.sh
```
