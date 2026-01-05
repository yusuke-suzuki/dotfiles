# dotfiles

Personal dotfiles for managing development environment configurations.

## What's Included

### Claude Code Configuration

Configuration files for Claude Code that can be installed globally.

#### Global Configuration (`CLAUDE.md`)

Professional engineering principles for decision making and communication.

#### Rules

Standards automatically applied based on context:

- **commit-message** - Conventional Commits format
- **pr-description** - Pull request structure and conventions
- **coding-standards** - Naming, design, and quality guidelines
- **document-writing** - Writing style and consistency
- **text-formatting-ja** - Japanese text formatting

#### Slash Commands

- **`/commit`** - Create commits with Conventional Commits format
- **`/fixup`** - Create fixup commits and autosquash rebase
- **`/publish`** - Push commits and create/update pull requests
- **`/sync`** - Sync feature branch with main via rebase

#### Skills

- **technical-writing** - Technical document creation (design docs, specs)
- **data-querying** - SQL query development with BigQuery
- **analytics-design** - Looker Studio report design

### mise Configuration

Global mise configuration template (`~/.config/mise/config.toml`).

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
│   ├── commit.md
│   ├── fixup.md
│   ├── publish.md
│   └── sync.md
├── rules/
│   ├── coding-standards.md
│   ├── commit-message.md
│   ├── document-writing.md
│   ├── pr-description.md
│   └── text-formatting-ja.md
└── skills/
    ├── analytics-design/
    ├── data-querying/
    └── technical-writing/

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
