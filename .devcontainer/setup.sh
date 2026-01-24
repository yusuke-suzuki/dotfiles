#!/bin/bash
set -e

# Skip Claude Code CLI installation in remote environments (already installed)
if [ "$CLAUDE_CODE_REMOTE" = "true" ]; then
    echo "Claude Code on the Web environment detected. Skipping CLI installation."
    exit 0
fi

# Install Claude Code CLI for local Dev Container environments
echo "Installing Claude Code CLI..."
curl -fsSL https://claude.ai/install.sh | bash
