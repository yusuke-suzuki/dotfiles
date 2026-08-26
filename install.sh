#!/bin/bash
set -e

# Apply this repository as the chezmoi source
# Run this script from the cloned repository directory
# mise is the one manually installed prerequisite; chezmoi is mise-managed

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# On a fresh machine mise may not be on PATH yet (shell config is what
# this script deploys), so fall back to its default install location
MISE="$(command -v mise || echo "$HOME/.local/bin/mise")"
if [ ! -x "$MISE" ]; then
    echo "❌ mise is required. Install it first: https://mise.jdx.dev/getting-started.html"
    exit 1
fi

if ! "$MISE" which chezmoi &> /dev/null; then
    echo "Installing chezmoi via mise..."
    "$MISE" use --global chezmoi@latest
fi
chezmoi() { "$MISE" exec -- chezmoi "$@"; }

# Persist the source directory so bare chezmoi commands (apply, diff,
# merge, update) work from anywhere. chezmoi rejects multiple config
# formats, so detect every supported one before creating the default
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/chezmoi"
CONFIG_FILE=""
for candidate in "$CONFIG_DIR"/chezmoi.toml "$CONFIG_DIR"/chezmoi.yaml \
    "$CONFIG_DIR"/chezmoi.json "$CONFIG_DIR"/chezmoi.jsonc; do
    if [ -f "$candidate" ]; then
        CONFIG_FILE="$candidate"
        break
    fi
done
if [ -z "$CONFIG_FILE" ]; then
    mkdir -p "$CONFIG_DIR"
    printf 'sourceDir = "%s"\n' "$SCRIPT_DIR" > "$CONFIG_DIR/chezmoi.toml"
elif [ "$(chezmoi source-path)" != "$SCRIPT_DIR" ]; then
    # Bare chezmoi commands (update, diff, merge) follow the configured
    # sourceDir, so applying from a different clone must not proceed silently
    echo "❌ $CONFIG_FILE does not point at this clone."
    echo "   Set sourceDir = \"$SCRIPT_DIR\" there (or remove the file) and re-run."
    exit 1
fi

chezmoi apply --source "$SCRIPT_DIR" --verbose

# Install the remaining tools the deployed global config declares
"$MISE" install
