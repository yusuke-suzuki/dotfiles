# Dotfiles Repository - Claude Instructions

## Repository Structure

**CRITICAL: This is a dotfiles repository. Understanding the file structure is essential.**

### Source Files (Edit These)

This repository's `.claude/` directory contains the **source files** for Claude Code configuration:

- `.claude/CLAUDE.md` - User-level configuration (deployed to all projects)
- `.claude/rules/` - User-level rules
- `.claude/skills/` - User-level skills (core skills deployed by `install.sh`, others via `npx skills`)

**When editing Claude configuration files:**

- ALWAYS modify files in `<repository-root>/.claude/` directory
- These are version-controlled source files
- Changes should be committed to git

### Deployed Files (Do NOT Edit)

- `~/.claude/` contains deployed copies created by `install.sh`
- **NEVER edit files in `~/.claude/` when working on this project**
- These are deployment targets, not source files

### Deployment Workflow

**CLAUDE.md and rules** (via `install.sh`):

1. Edit source files in `.claude/` directory
2. Commit changes to git
3. Run `install.sh` to deploy changes to `~/.claude/`
4. Changes become active across all projects on the machine

**Core skills** (via `install.sh`):

- Core skills (commit, fixup, publish, sync, resolve-comments, lint-doc) are deployed by `install.sh`
- Defined in the `CORE_SKILLS` array in `install.sh`

**Additional skills** (via `npx skills`):

1. Edit skill files in `.claude/skills/` directory
2. Commit and push changes to git
3. Run `npx skills add yusuke-suzuki/dotfiles -g -s "skill-name"` to install
4. Skills become active across all projects on the machine

## Common Mistake to Avoid

❌ **WRONG:** Editing `~/.claude/CLAUDE.md` or `~/.claude/rules/*.md`
✓ **CORRECT:** Editing `.claude/CLAUDE.md` or `.claude/rules/*.md` in this repository

When asked to modify Claude configuration:

- Edit `.claude/CLAUDE.md` (NOT `~/.claude/CLAUDE.md`)
- Edit `.claude/rules/*.md` (NOT `~/.claude/rules/*.md`)
- Edit `.claude/skills/*/` (NOT `~/.claude/skills/*/`)
