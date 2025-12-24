#!/bin/bash
set -e

# Dotfiles Installer
# This script installs:
#   - Claude Code custom slash commands and CLAUDE.md
#   - mise configuration
# Run this script from the cloned repository directory

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="$SCRIPT_DIR/.claude"
COMMANDS_DIR="$HOME/.claude/commands"
CLAUDE_DIR="$HOME/.claude"
MISE_CONFIG_DIR="$HOME/.config/mise"

echo "Installing dotfiles..."
echo ""

# Check if source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "❌ Error: .claude directory not found in $SCRIPT_DIR"
    echo "Please run this script from the dotfiles repository directory."
    exit 1
fi

# Create directories if they don't exist
if [ ! -d "$COMMANDS_DIR" ]; then
    echo "📁 Creating directory: $COMMANDS_DIR"
    mkdir -p "$COMMANDS_DIR"
fi

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
        echo "📄 Installing $cmd_file..."
        cp "$cmd_path" "$COMMANDS_DIR/$cmd_file"
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
echo "  - $MISE_CONFIG_DIR/config.toml"
echo ""
echo "Claude Code commands:"
echo "  /commit - Systematic commit and PR management workflow"
echo "  /fixup  - Commit fixup and squash workflow"
echo "  /sync   - Sync feature branch with master/main"
echo ""
echo "mise setup:"
echo "  Add the following to your shell config (e.g., ~/.bashrc, ~/.zshrc):"
echo '    eval "$(mise activate)"'
