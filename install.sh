#!/bin/bash
set -e

# Claude Code Configuration Installer
# This script installs custom slash commands and CLAUDE.md to ~/.claude
# Run this script from the cloned repository directory

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="$SCRIPT_DIR/.claude"
COMMANDS_DIR="$HOME/.claude/commands"
CLAUDE_DIR="$HOME/.claude"

echo "🤖 Installing Claude Code configuration..."
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
echo "✅ Installation complete!"
echo ""
echo "📁 Installed files:"
echo "  - $CLAUDE_DIR/CLAUDE.md"
for cmd_file in "$COMMANDS_DIR"/*.md; do
    if [ -f "$cmd_file" ]; then
        echo "  - $cmd_file"
    fi
done
echo ""
echo "Available commands:"
echo "  /commit - Systematic commit and PR management workflow"
echo "  /fixup  - Commit fixup and squash workflow"
echo "  /sync   - Sync feature branch with master/main"
echo ""
echo "These commands are now available globally in all your projects."
echo "Open Claude Code and type '/' to see them in action!"
