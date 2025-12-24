# dotfiles

Personal dotfiles for managing development environment configurations.

## Claude Code Configuration

This repository manages Claude Code configuration files that can be installed globally on your machine.

### What's Included

#### Global Configuration (`CLAUDE.md`)
Personal preferences and conventions applied to all projects:
- Commit message conventions (Conventional Commits format)
- Code quality and refactoring guidelines
- Japanese text formatting rules
- Pull request guidelines
- Professional engineering principles

#### Custom Slash Commands
Reusable workflows available across all projects:

- **`/commit`** - Systematic commit and PR workflow
  - Creates feature branches if on master/main
  - Guides through Conventional Commits format
  - Creates or updates pull requests automatically

- **`/fixup`** - Interactive rebase and fixup workflow
  - Creates fixup commits for specific hashes
  - Uses `git rebase -i --autosquash`
  - Safely force pushes with `--force-with-lease`

- **`/sync`** - Sync feature branch with master/main
  - Rebases current branch on latest master/main
  - Guides through conflict resolution
  - Force pushes safely after successful rebase

### Installation

Clone this repository:

```bash
gh repo clone yusuke-suzuki/dotfiles ~/dotfiles
cd ~/dotfiles
```

Then run the install script:

```bash
./install.sh
```

### What Gets Installed

```
~/.claude/
├── CLAUDE.md              # Global configuration and conventions
└── commands/
    ├── commit.md          # /commit command
    ├── fixup.md           # /fixup command
    └── sync.md            # /sync command
```

### Requirements

- Git
- GitHub CLI (`gh`)

### Notes

- Existing `~/.claude/CLAUDE.md` is automatically backed up before installation
- Commands are intentionally generic (no project-specific lint checks)
- Add project-specific quality checks in project's local `CLAUDE.md` if needed
- All commands follow best practices (e.g., `--force-with-lease` over `--force`)

### Updating

Pull the latest changes and re-run the install script:

```bash
cd ~/dotfiles
git pull
./install.sh
```