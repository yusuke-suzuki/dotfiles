# dotfiles

Personal dotfiles for managing development environment configurations.

## What's Included

### Claude Code Configuration

- **CLAUDE.md** - Professional engineering principles
- **rules/** - Always-on rules applied across all conversations
- **skills/** - Specialized capabilities for specific tasks (core skills installed by `install.sh`, others via `npx skills`)

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
└── skills/        # Core skills only

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

## Installing Additional Skills

Core skills are installed automatically by `install.sh`. Additional skills can be installed per environment using the Agent Skills ecosystem.

### All Skills

```bash
npx skills add yusuke-suzuki/dotfiles --all -g
```

### By Workflow

**Analysis Workflow**

```bash
npx skills add yusuke-suzuki/dotfiles -g -s "bq-studio analysis-report"
```

**Looker Studio Workflow**

```bash
npx skills add yusuke-suzuki/dotfiles -g -s "bq-studio looker-studio-report"
```

**Technical Writing Workflow**

```bash
npx skills add yusuke-suzuki/dotfiles -g -s "technical-writing"
```

**Git Workflow**

```bash
npx skills add yusuke-suzuki/dotfiles -g -s "commit fixup publish sync resolve-comments"
```

### Individual Skills

```bash
# List available skills
npx skills add yusuke-suzuki/dotfiles -l

# Install specific skill
npx skills add yusuke-suzuki/dotfiles -g -s "skill-name"
```

**Note:** Some skills have dependencies on other skills. The workflow commands above include all required dependencies.
