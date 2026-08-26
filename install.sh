#!/bin/bash
set -e

# Dotfiles Installer
# This script installs:
#   - Claude Code settings.json, rules, and skills
#   - The same rules for Cursor (as .mdc under ~/.cursor/rules)
#   - mise configuration and shell activation
# Run this script from the cloned repository directory

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="$SCRIPT_DIR/.claude"
CLAUDE_DIR="$HOME/.claude"
RULES_DIR="$CLAUDE_DIR/rules"
SKILLS_DIR="$CLAUDE_DIR/skills"
AGENTS_DIR="$CLAUDE_DIR/agents"
CURSOR_DIR="$HOME/.cursor"
CURSOR_RULES_DIR="$CURSOR_DIR/rules"
MISE_CONFIG_DIR="$HOME/.config/mise"

# Append a mise activation line unless the file already references mise
# activate, so hand-written setups are left untouched
ensure_mise_line() {
    local file="$1" line="$2"
    if [ -f "$file" ] && grep -q "mise activate" "$file"; then
        echo "  Already configured: $file"
        return
    fi
    if [ -s "$file" ] && [ -n "$(tail -c1 "$file")" ]; then
        echo >> "$file"
    fi
    printf '%s\n' "$line" >> "$file"
    echo "  Configured: $file"
}

echo "Installing dotfiles..."
echo ""

# Check if source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "❌ Error: .claude directory not found in $SCRIPT_DIR"
    echo "Please run this script from the dotfiles repository directory."
    exit 1
fi

mkdir -p "$CLAUDE_DIR"

# Remove files earlier versions installed under other names, so they stop
# loading into every session. Only names this repository once deployed are
# touched — files added by hand stay
echo "🧹 Removing files installed by earlier versions..."
for legacy_rule in communication feedback-handling git tool-usage writing-style; do
    rm -f "$RULES_DIR/$legacy_rule.md"
done
rm -f "$CLAUDE_DIR/CLAUDE.md"
rm -f "$CURSOR_DIR/user-rules.md"

# Install rules. The same files serve Cursor below, so they carry Cursor's
# frontmatter (description / alwaysApply) — Claude Code ignores those fields
echo "📏 Installing rules..."
mkdir -p "$RULES_DIR"
for rule_file in "$SOURCE_DIR"/rules/*.md; do
    if [ -f "$rule_file" ]; then
        echo "   Installing rule: $(basename "$rule_file")"
        cp "$rule_file" "$RULES_DIR"
    fi
done

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
# so the install above already covers them. Rules go to ~/.cursor/rules —
# same content as ~/.claude/rules, renamed to the .mdc extension Cursor
# requires (it ignores plain .md there, and Claude Code ignores .mdc)
echo "📏 Installing rules..."
mkdir -p "$CURSOR_RULES_DIR"
for rule_file in "$SOURCE_DIR"/rules/*.md; do
    if [ -f "$rule_file" ]; then
        rule_name="$(basename "$rule_file" .md).mdc"
        echo "   Installing rule: $rule_name"
        cp "$rule_file" "$CURSOR_RULES_DIR/$rule_name"
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

    # Official two-file setup (https://mise.jdx.dev/dev-tools/shims.html):
    # activate for interactive shells, shims for non-interactive ones so
    # agent-driven commands (Claude Code, Cursor) resolve mise-managed tools
    # without a `mise exec` prefix
    echo "  Configuring shell activation..."
    case "$(basename "${SHELL:-}")" in
        zsh)
            ensure_mise_line "${ZDOTDIR:-$HOME}/.zshrc" 'eval "$(mise activate zsh)"'
            ensure_mise_line "${ZDOTDIR:-$HOME}/.zprofile" 'eval "$(mise activate zsh --shims)"'
            ;;
        bash)
            # Creating ~/.bash_profile would shadow an existing ~/.profile
            # for login shells, so prefer ~/.profile in that case
            BASH_LOGIN_FILE="$HOME/.bash_profile"
            if [ ! -f "$BASH_LOGIN_FILE" ] && [ -f "$HOME/.profile" ]; then
                BASH_LOGIN_FILE="$HOME/.profile"
            fi
            ensure_mise_line "$HOME/.bashrc" 'eval "$(mise activate bash)"'
            ensure_mise_line "$BASH_LOGIN_FILE" 'eval "$(mise activate bash --shims)"'
            ;;
        *)
            echo "  ⚠️  Unsupported shell: ${SHELL:-unknown}. Configure manually:"
            echo '     interactive shells:     eval "$(mise activate)"'
            echo '     non-interactive shells: eval "$(mise activate --shims)"'
            ;;
    esac
fi

echo ""
echo "Installation complete!"
echo ""
echo "Installed files:"
echo "  - $CLAUDE_DIR/settings.json"
for rule_file in "$SOURCE_DIR"/rules/*.md; do
    if [ -f "$rule_file" ]; then
        rule_base="$(basename "$rule_file" .md)"
        echo "  - $RULES_DIR/$rule_base.md"
        echo "  - $CURSOR_RULES_DIR/$rule_base.mdc"
    fi
done
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
    echo "Restart your shell to apply mise activation."
fi
