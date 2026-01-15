#!/bin/bash
set -e

# Dotfiles Installer
# This script installs:
#   - Claude Code custom slash commands and CLAUDE.md
#   - mise configuration
# Run this script from the cloned repository directory

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="$SCRIPT_DIR/.claude"
CLAUDE_DIR="$HOME/.claude"
COMMANDS_DIR="$CLAUDE_DIR/commands"
SKILLS_DIR="$CLAUDE_DIR/skills"
RULES_DIR="$CLAUDE_DIR/rules"
MISE_CONFIG_DIR="$HOME/.config/mise"

echo "Installing dotfiles..."
echo ""

# Check if source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "❌ Error: .claude directory not found in $SCRIPT_DIR"
    echo "Please run this script from the dotfiles repository directory."
    exit 1
fi

# Clean and recreate directories
echo "🧹 Cleaning existing configurations..."
rm -rf "$COMMANDS_DIR" "$SKILLS_DIR" "$RULES_DIR"
mkdir -p "$COMMANDS_DIR" "$SKILLS_DIR" "$RULES_DIR"

# Install CLAUDE.md (backup existing if present)
echo "📝 Installing CLAUDE.md..."
if [ -f "$CLAUDE_DIR/CLAUDE.md" ]; then
    backup="$CLAUDE_DIR/CLAUDE.md.backup.$(date +%Y%m%d_%H%M%S)"
    echo "   Backing up existing CLAUDE.md to: $backup"
    mv "$CLAUDE_DIR/CLAUDE.md" "$backup"
fi
cp "$SOURCE_DIR/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"

# Install each command file
for cmd_path in "$SOURCE_DIR"/commands/*.md; do
    if [ -f "$cmd_path" ]; then
        cmd_file=$(basename "$cmd_path")
        echo "📄 Installing command: $cmd_file"
        cp "$cmd_path" "$COMMANDS_DIR/$cmd_file"
    fi
done

# Install skills
echo ""
echo "📚 Installing skills..."
for skill_dir in "$SOURCE_DIR"/skills/*/; do
    if [ -d "$skill_dir" ]; then
        skill_name=$(basename "$skill_dir")
        dest_dir="$SKILLS_DIR/$skill_name"
        echo "   Installing skill: $skill_name"
        cp -r "$skill_dir" "$dest_dir"
    fi
done

# Install rules
echo ""
echo "📏 Installing rules..."
for rule_path in "$SOURCE_DIR"/rules/*.md; do
    if [ -f "$rule_path" ]; then
        rule_file=$(basename "$rule_path")
        echo "   Installing rule: $rule_file"
        cp "$rule_path" "$RULES_DIR/$rule_file"
    fi
done

echo ""

# ============================================
# mise configuration
# ============================================
echo "Installing mise configuration..."

# Check mise is installed
if ! command -v mise &> /dev/null; then
    echo "  [ERROR] mise is not installed." >&2
    echo "  Please install it by following the instructions at https://mise.jdx.dev/getting-started.html" >&2
    exit 1
fi

# Create mise config directory
if [ ! -d "$MISE_CONFIG_DIR" ]; then
    echo "  Creating directory: $MISE_CONFIG_DIR"
    mkdir -p "$MISE_CONFIG_DIR"
fi

# Install mise config (backup existing if present)
if [ -f "$MISE_CONFIG_DIR/config.toml" ]; then
    backup="$MISE_CONFIG_DIR/config.toml.backup.$(date +%Y%m%d_%H%M%S)"
    echo "  Backing up existing config.toml to: $backup"
    mv "$MISE_CONFIG_DIR/config.toml" "$backup"
fi
cp "$SCRIPT_DIR/mise/config.toml.template" "$MISE_CONFIG_DIR/config.toml"
echo "  Installed: $MISE_CONFIG_DIR/config.toml"

echo ""
echo "Installation complete!"
echo ""
echo "Installed files:"
echo "  - $CLAUDE_DIR/CLAUDE.md"
for cmd_file in "$COMMANDS_DIR"/*.md; do
    if [ -f "$cmd_file" ]; then
        echo "  - $cmd_file"
    fi
done
for skill_dir in "$SKILLS_DIR"/*/; do
    if [ -d "$skill_dir" ]; then
        echo "  - $skill_dir"
    fi
done
for rule_file in "$RULES_DIR"/*.md; do
    if [ -f "$rule_file" ]; then
        echo "  - $rule_file"
    fi
done
echo "  - $MISE_CONFIG_DIR/config.toml"
echo ""
echo "Claude Code commands:"
for cmd_file in "$COMMANDS_DIR"/*.md; do
    if [ -f "$cmd_file" ]; then
        cmd_name=$(basename "$cmd_file" .md)
        description=$(grep -m1 "^description:" "$cmd_file" | sed 's/^description:[[:space:]]*//')
        printf "  /%-16s - %s\n" "$cmd_name" "$description"
    fi
done
echo ""
echo "Claude Code skills:"
for skill_dir in "$SKILLS_DIR"/*/; do
    if [ -d "$skill_dir" ]; then
        skill_name=$(basename "$skill_dir")
        skill_file="$skill_dir/SKILL.md"
        if [ -f "$skill_file" ]; then
            description=$(grep -m1 "^description:" "$skill_file" | sed 's/^description:[[:space:]]*//')
            printf "  %-18s - %s\n" "$skill_name" "$description"
        fi
    fi
done
echo ""
echo "mise setup:"
echo "  Add the following to your shell config (e.g., ~/.bashrc, ~/.zshrc):"
echo '    eval "$(mise activate)"'
