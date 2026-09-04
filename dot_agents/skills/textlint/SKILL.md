---
name: textlint
description: Auto-format Japanese prose with textlint — katakana loanword replacement, half-width spacing and parentheses, ja-technical-writing rules. Use on any Japanese text before it is published or committed — drafts (PR descriptions, issue bodies, review replies, documents) and Japanese text in source files (code comments, docstrings, test case titles) — or when asked to lint/format Japanese text.
---

# Textlint

Write the draft to a file, then run:

```bash
~/.agents/skills/textlint/scripts/lint.sh <file>          # report violations
~/.agents/skills/textlint/scripts/lint.sh --fix <file>    # auto-fix in place
```

Dependencies run via `npx` (pinned in `lint.sh`); the first run downloads them into the npx cache.

The target style is plain Japanese over katakana loanwords wherever a natural equivalent exists, half-width spaces around alphanumerics, code spans, and links, and half-width parentheses. Rules live in `.textlintrc.json` (preset-ja-technical-writing, preset-ai-writing, preset-ja-spacing, no-mixed-zenkaku-and-hankaku-alphabet) and `prh.yml` (katakana loanwords with established plain-Japanese equivalents, full-width parentheses). Context-dependent loanwords (ロジック, マッピング, クランプ, ラッパー) are intentionally absent from the dictionary — replace them yourself when no established technical term is intended.

After `--fix`, review the remaining report: some rules (particle errors, sentence style) are detect-only and need manual edits.

## Japanese text embedded in source files

textlint parses only `.md` and `.txt`; running `lint.sh` on a source file (`.ts`, `.rb`, …) is a silent no-op. Extract the Japanese fragments (code comments, docstrings, test case titles) into a scratch `.txt` file — one fragment per block, blocks separated by blank lines, keeping the original line breaks of multiline comments — run `lint.sh --fix` on it, then edit each fixed fragment back into its place in the source.

`ja-no-mixed-period` reports lines that do not end with 。 but never appends one on `--fix` — ignore those reports for comments and test case titles the surrounding code writes without 句点, and for hard-wrapped lines that break mid-sentence.

Out of scope: string literals whose exact value affects behavior or recorded data (assertion expectations, API response fixtures, seeds).
