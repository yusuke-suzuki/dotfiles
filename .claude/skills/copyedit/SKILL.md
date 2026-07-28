---
name: copyedit
description: Review user-facing output for factual accuracy, internal consistency, and expression naturalness before sending. Invoke explicitly when copyediting is needed.
---

# Copyedit

Final review pass on a draft (PR description, commit message, issue body, design doc, review reply) before it reaches its destination. Catch what the author missed; do not rewrite to preference. If the destination is not stated, infer it from the draft's shape and say so.

## 1. Mechanical checks (textlint)

Write the draft to a file and run from this skill's base directory:

```bash
{SKILL_BASE_DIR}/scripts/lint.sh <draft-file>          # report
{SKILL_BASE_DIR}/scripts/lint.sh --fix <draft-file>    # auto-fix
```

Covers Japanese technical-writing rules, half-width spacing around alphanumerics/code/links, full-width parentheses, and katakana loanword replacement (`prh.yml`). For Japanese drafts, apply `--fix`, then review the remaining report. Context-dependent loanwords the dictionary skips (ロジック, マッピング, クランプ, ラッパー) still need judgment: replace them when no established technical term is intended.

## 2. Judgment checks

What textlint cannot verify:

- **Facts** — check every concrete reference against its source: PR/issue numbers (`gh pr view`), commit ids (`git show`), file paths (Read/Glob), identifiers (Grep), numeric claims, and quotes (byte-for-byte). Names introduced by a proposed design must not be described as currently existing. Report anything uncheckable as "could not verify" — never pass it silently.
- **Consistency** — one term per concept; no internal contradictions; terminology matches referenced specs; heading/list shapes consistent.
- **Argument quality** — problem statements name the consequence, not just the fact ("X is duplicated, so a change needs two edits"); categorized lists partition cleanly.
- **Reader perspective** — the reader has no chat history: no conversational references (「先ほど」「ご指摘の通り」); first-use terms defined in the document.
- **Quantitative claims** — percentages cite the denominator N; numbers state their scope (time range, segment, version); causal language only with a named mechanism.

## 3. Report

Return three sections — Verified (with sources), Could not verify (with reasons), Findings (location, issue, suggestion) — ordered by severity: factual errors, contradictions, argument quality, reader perspective, naturalness, formatting. Close with an overall judgment: ready, ready with minor edits, or needs rework.

## Boundaries

Do not invent facts, fill in omissions, change the author's argument, or suggest pure style preferences. Read-only verification — no tests, builds, or destructive commands.
