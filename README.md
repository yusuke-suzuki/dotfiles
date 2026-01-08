# dotfiles

Personal dotfiles for managing development environment configurations.

## What's Included

### Claude Code Configuration

- **CLAUDE.md** - Professional engineering principles
- **commands/** - Slash commands for common workflows
- **rules/** - Standards automatically applied based on context
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
├── commands/
├── rules/
└── skills/

~/.config/mise/
└── config.toml
```

### Requirements

- Git
- GitHub CLI (`gh`)
- mise

### Updating

```bash
cd ~/dotfiles
git pull
./install.sh
```

Existing files are automatically backed up before installation.
