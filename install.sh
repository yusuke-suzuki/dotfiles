#!/bin/bash
set -e

# Dotfiles Installer
# This script installs:
#   - Claude Code CLAUDE.md, settings.json, and skills
#   - Cursor user rules, ready to paste into Customize → Rules
#   - mise configuration
# Run this script from the cloned repository directory

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="$SCRIPT_DIR/.claude"
CLAUDE_DIR="$HOME/.claude"
RULES_DIR="$CLAUDE_DIR/rules"
SKILLS_DIR="$CLAUDE_DIR/skills"
AGENTS_DIR="$CLAUDE_DIR/agents"
CURSOR_DIR="$HOME/.cursor"
CURSOR_USER_RULES="$CURSOR_DIR/user-rules.md"
MISE_CONFIG_DIR="$HOME/.config/mise"

echo "Installing dotfiles..."
echo ""

# Check if source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "❌ Error: .claude directory not found in $SCRIPT_DIR"
    echo "Please run this script from the dotfiles repository directory."
    exit 1
fi

mkdir -p "$CLAUDE_DIR"

# Rules now live in CLAUDE.md and skills. Earlier runs left files behind that
# would otherwise keep loading into every session — remove those by name so
# rules added by hand stay, and drop the directory only once it is empty
echo "🧹 Removing rules installed by earlier versions..."
for legacy_rule in communication feedback-handling git tool-usage writing-style; do
    rm -f "$RULES_DIR/$legacy_rule.md"
done
rmdir "$RULES_DIR" 2>/dev/null || true

# Install CLAUDE.md
echo "📝 Installing CLAUDE.md..."
cp "$SOURCE_DIR/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"

# Install settings.json
echo "⚙️  Installing settings.json..."
cp "$SOURCE_DIR/settings.json" "$CLAUDE_DIR/settings.json"

# Install skills
echo ""
echo "🔧 Installing skills..."
mkdir -p "$SKILLS_DIR"
for skill_dir in "$SOURCE_DIR"/skills/*/; do
    if [ -d "$skill_dir" ]; then
        skill_name=$(basename "$skill_dir")
        echo "   Installing skill: $skill_name"
        rm -rf "$SKILLS_DIR/$skill_name"
        cp -r "$skill_dir" "$SKILLS_DIR/$skill_name"
    fi
done

# Install agents
if [ -d "$SOURCE_DIR/agents" ]; then
    echo ""
    echo "🤖 Installing agents..."
    rm -rf "$AGENTS_DIR"
    mkdir -p "$AGENTS_DIR"
    for agent_file in "$SOURCE_DIR"/agents/*.md; do
        if [ -f "$agent_file" ]; then
            echo "   Installing agent: $(basename "$agent_file")"
            cp "$agent_file" "$AGENTS_DIR"
        fi
    done
fi

echo ""

# ============================================
# Cursor configuration
# ============================================
echo "Installing Cursor configuration..."

# Cursor loads skills from ~/.claude/skills/ for compatibility with Claude Code,
# so the install above already covers them. Its always-on equivalent, User Rules,
# is held in Cursor's settings rather than on disk, so the best that can be
# installed is the text to paste in.
# Priority Rules is dropped along the way: Cursor resolves the conflict the
# other way round, giving project rules precedence over user rules
mkdir -p "$CURSOR_DIR"
awk '/^# /{ skip = ($0 == "# Priority Rules") } !skip' \
    "$SOURCE_DIR/CLAUDE.md" > "$CURSOR_USER_RULES"
echo "📋 Installed user rules: $CURSOR_USER_RULES"
echo "   Paste its contents into Customize → Rules → User Rules — and again"
echo "   after any install that changes them, since Cursor keeps its own copy."

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
echo "  - $CLAUDE_DIR/settings.json"
echo "  - $CURSOR_USER_RULES"
for skill_dir in "$SKILLS_DIR"/*/; do
    if [ -d "$skill_dir" ]; then
        echo "  - $skill_dir"
    fi
done
if [ -d "$AGENTS_DIR" ]; then
    for agent_file in "$AGENTS_DIR"/*.md; do
        if [ -f "$agent_file" ]; then
            echo "  - $agent_file"
        fi
    done
fi
if [ "$MISE_INSTALLED" = true ]; then
    echo "  - $MISE_CONFIG_DIR/config.toml"
fi
if [ "$MISE_INSTALLED" = true ]; then
    echo ""
    echo "mise setup:"
    echo "  Add the following to your shell config (e.g., ~/.bashrc, ~/.zshrc):"
    echo '    eval "$(mise activate)"'
fi
