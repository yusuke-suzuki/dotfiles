#!/bin/bash
set -euo pipefail

SKILL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

FIX=""
if [ "${1:-}" = "--fix" ]; then
    FIX="--fix"
    shift
fi

run_textlint() {
    npx --yes \
        --package textlint@15.7.1 \
        --package textlint-rule-preset-ja-technical-writing@12.0.2 \
        --package textlint-rule-preset-ja-spacing@3.0.2 \
        --package textlint-rule-prh@6.1.0 \
        --package @textlint-ja/textlint-rule-preset-ai-writing@1.7.0 \
        --package textlint-rule-no-mixed-zenkaku-and-hankaku-alphabet@1.0.1 \
        textlint --config "$SKILL_DIR/.textlintrc.json" "$@"
}

# A fix can produce text that another rule then fixes — a full-width paren
# becomes half-width, which in turn needs spaces around it — and textlint
# applies only one of two fixes that overlap, so one pass leaves those behind.
if [ -n "$FIX" ]; then
    run_textlint --fix "$@" > /dev/null || true
    run_textlint --fix "$@" > /dev/null || true
fi

# Always report rather than reuse the --fix output, which lists what it fixed
# and stays silent about the detect-only rules that need a manual edit.
run_textlint "$@"
