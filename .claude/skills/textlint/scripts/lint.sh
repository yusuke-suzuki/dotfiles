#!/bin/bash
set -euo pipefail

SKILL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

FIX=""
if [ "${1:-}" = "--fix" ]; then
    FIX="--fix"
    shift
fi

exec npx --yes \
    --package textlint@15.7.1 \
    --package textlint-rule-preset-ja-technical-writing@12.0.2 \
    --package textlint-rule-preset-ja-spacing@3.0.2 \
    --package textlint-rule-prh@6.1.0 \
    --package @textlint-ja/textlint-rule-preset-ai-writing@1.7.0 \
    --package textlint-rule-no-mixed-zenkaku-and-hankaku-alphabet@1.0.1 \
    textlint --config "$SKILL_DIR/.textlintrc.json" ${FIX:+"$FIX"} "$@"
