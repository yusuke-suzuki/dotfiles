# dotfiles

Personal dotfiles for managing development environment configurations.

## What's Included

### Claude Code Configuration

- **CLAUDE.md** - Engineering principles, loaded into every session
- **skills/** - Specialized capabilities, loaded only when a task calls for them

Guidance that applies to one kind of task belongs in the skill that handles it, not in CLAUDE.md — skills stay out of context until they are relevant, and they are the one format other agents also read.

### Cursor Configuration

[Cursor loads skills](https://cursor.com/docs/skills) from `~/.claude/skills/` for compatibility with Claude Code, so a single install covers both tools.

CLAUDE.md has no such counterpart: Cursor keeps [User Rules](https://cursor.com/docs/rules) in its settings rather than on disk, and there is no file-based way to apply instructions across every project. `install.sh` writes the text to `~/.cursor/user-rules.md`; paste it into **Customize → Rules → User Rules**. Cursor holds its own copy from then on, so paste it again after any install that changes the file — otherwise Cursor keeps running the previous version.

The pasted text omits the priority rule that CLAUDE.md opens with, because Cursor resolves that conflict the other way round: project rules take precedence over user rules.

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
├── settings.json
└── skills/

~/.cursor/
└── user-rules.md

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
