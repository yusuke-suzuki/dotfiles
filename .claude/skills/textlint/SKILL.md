---
name: textlint
description: Auto-format Japanese prose with textlint — katakana loanword replacement, half-width spacing and parentheses, ja-technical-writing rules. Use on Japanese drafts (PR descriptions, issue bodies, documents) before sending, or when asked to lint/format Japanese text.
---

# Textlint

Write the draft to a file, then run:

```bash
{SKILL_BASE_DIR}/scripts/lint.sh <file>          # report violations
{SKILL_BASE_DIR}/scripts/lint.sh --fix <file>    # auto-fix in place
```

Dependencies run via `npx` (pinned in `lint.sh`); the first run downloads them into the npx cache.

Rules live in `.textlintrc.json` (preset-ja-technical-writing, preset-ai-writing, preset-ja-spacing, no-mixed-zenkaku-and-hankaku-alphabet) and `prh.yml` (katakana loanwords with established plain-Japanese equivalents, full-width parentheses). Context-dependent loanwords (ロジック, マッピング, クランプ, ラッパー) are intentionally absent from the dictionary — replace them yourself when no established technical term is intended.

After `--fix`, review the remaining report: some rules (particle errors, sentence style) are detect-only and need manual edits.
