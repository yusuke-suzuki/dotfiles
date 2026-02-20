#!/bin/bash
set -e

# Dotfiles Installer
# This script installs:
#   - Claude Code CLAUDE.md, rules, and core skills
#   - mise configuration
# Additional skills can be installed via `npx skills`
# Run this script from the cloned repository directory

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="$SCRIPT_DIR/.claude"
CLAUDE_DIR="$HOME/.claude"
RULES_DIR="$CLAUDE_DIR/rules"
SKILLS_DIR="$CLAUDE_DIR/skills"
MISE_CONFIG_DIR="$HOME/.config/mise"

# Core skills installed by default
CORE_SKILLS=(commit fixup publish sync resolve-comments lint-doc)

echo "Installing dotfiles..."
echo ""

# Check if source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "❌ Error: .claude directory not found in $SCRIPT_DIR"
    echo "Please run this script from the dotfiles repository directory."
    exit 1
fi

# Clean and recreate rules directory
echo "🧹 Cleaning existing rules..."
rm -rf "$RULES_DIR"
mkdir -p "$RULES_DIR"

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

# Install core skills
echo ""
echo "🔧 Installing core skills..."
mkdir -p "$SKILLS_DIR"
for skill_name in "${CORE_SKILLS[@]}"; do
    skill_dir="$SOURCE_DIR/skills/$skill_name"
    if [ -d "$skill_dir" ]; then
        echo "   Installing skill: $skill_name"
        rm -rf "$SKILLS_DIR/$skill_name"
        cp -r "$skill_dir" "$SKILLS_DIR/$skill_name"
    else
        echo "   ⚠️  Skill not found: $skill_name"
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
for skill_name in "${CORE_SKILLS[@]}"; do
    if [ -d "$SKILLS_DIR/$skill_name" ]; then
        echo "  - $SKILLS_DIR/$skill_name/"
    fi
done
if [ "$MISE_INSTALLED" = true ]; then
    echo "  - $MISE_CONFIG_DIR/config.toml"
fi
if [ "$MISE_INSTALLED" = true ]; then
    echo ""
    echo "mise setup:"
    echo "  Add the following to your shell config (e.g., ~/.bashrc, ~/.zshrc):"
    echo '    eval "$(mise activate)"'
fi
echo ""
echo "To install additional skills:"
echo "  npx skills add yusuke-suzuki/dotfiles --all -g"
