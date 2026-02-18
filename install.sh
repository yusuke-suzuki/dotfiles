#!/bin/bash
set -e

# Dotfiles Installer
# This script installs:
#   - Claude Code CLAUDE.md, rules, and skills
#   - mise configuration
# Run this script from the cloned repository directory

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="$SCRIPT_DIR/.claude"
CLAUDE_DIR="$HOME/.claude"
RULES_DIR="$CLAUDE_DIR/rules"
SKILLS_DIR="$CLAUDE_DIR/skills"
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
rm -rf "$RULES_DIR" "$SKILLS_DIR"
mkdir -p "$RULES_DIR" "$SKILLS_DIR"

# Install CLAUDE.md
echo "📝 Installing CLAUDE.md..."
cp "$SOURCE_DIR/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"

# Install rules
echo "📏 Installing rules..."
for rule_file in "$SOURCE_DIR"/rules/*.md; do
    if [ -f "$rule_file" ]; then
        echo "   Installing rule: $(basename "$rule_file")"
        cp "$rule_file" "$RULES_DIR"
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

echo ""

# ============================================
# mise configuration
# ============================================
echo "Installing mise configuration..."

# Check mise is installed
if ! command -v mise &> /dev/null; then
    echo "  ⚠️  mise is not installed. Skipping mise configuration."
    MISE_INSTALLED=false
else
    MISE_INSTALLED=true

    # Create mise config directory
    if [ ! -d "$MISE_CONFIG_DIR" ]; then
        echo "  Creating directory: $MISE_CONFIG_DIR"
        mkdir -p "$MISE_CONFIG_DIR"
    fi

    # Install mise config
    cp "$SCRIPT_DIR/mise/config.toml.template" "$MISE_CONFIG_DIR/config.toml"
    echo "  Installed: $MISE_CONFIG_DIR/config.toml"
fi

echo ""
echo "Installation complete!"
echo ""
echo "Installed files:"
echo "  - $CLAUDE_DIR/CLAUDE.md"
for rule_file in "$RULES_DIR"/*.md; do
    if [ -f "$rule_file" ]; then
        echo "  - $rule_file"
    fi
done
for skill_dir in "$SKILLS_DIR"/*/; do
    if [ -d "$skill_dir" ]; then
        echo "  - $skill_dir"
    fi
done
if [ "$MISE_INSTALLED" = true ]; then
    echo "  - $MISE_CONFIG_DIR/config.toml"
fi
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
if [ "$MISE_INSTALLED" = true ]; then
    echo ""
    echo "mise setup:"
    echo "  Add the following to your shell config (e.g., ~/.bashrc, ~/.zshrc):"
    echo '    eval "$(mise activate)"'
fi
