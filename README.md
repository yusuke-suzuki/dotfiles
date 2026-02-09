# dotfiles

Personal dotfiles for managing development environment configurations.

## What's Included

### Claude Code Configuration

- **CLAUDE.md** - Professional engineering principles
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
└── skills/

~/.config/mise/
└── config.toml
```

### Requirements

- Git
- GitHub CLI (`gh`)
- Google Cloud SDK (`bq`)
- mise

### Updating

```bash
cd ~/dotfiles
git pull
./install.sh
```

Existing files are automatically backed up before installation.

## Installing Skills via npx skills

You can also install individual skills or groups of skills using the Agent Skills ecosystem.

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
