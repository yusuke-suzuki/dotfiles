#!/bin/bash
set -euo pipefail

SKILL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if [ ! -x "$SKILL_DIR/node_modules/.bin/textlint" ]; then
    npm install --prefix "$SKILL_DIR" --no-audit --no-fund --silent
fi

FIX=""
if [ "${1:-}" = "--fix" ]; then
    FIX="--fix"
    shift
fi

exec "$SKILL_DIR/node_modules/.bin/textlint" --config "$SKILL_DIR/.textlintrc.json" ${FIX:+"$FIX"} "$@"
