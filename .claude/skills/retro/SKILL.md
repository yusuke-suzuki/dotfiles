---
name: retro
description: Review the session for rule violations, analyze root causes, and create a GitHub issue with countermeasures
---

# Retrospective

Identify violations of `~/.claude/CLAUDE.md`, `~/.claude/rules/`, and skill workflows in this session, analyze root causes, and record countermeasures as a GitHub issue.

## 1. Violations

List each confirmed violation: what happened, which rule or skill section was violated, and when. Do not pad with hypothetical or borderline cases.

## 2. Root causes

Group related violations and classify each cause:

- **Rule gap** — the rule doesn't exist or is insufficient
- **Execution failure** — the rule exists but was not followed
- **Skill workflow deficiency** — the skill's instructions are unclear, incomplete, or misleading

## 3. Countermeasures

For each root cause, propose a durable change (new rule, rule amendment or restructure, CLAUDE.md amendment, or skill fix) specifying the file, the change, and why it prevents recurrence. Never propose "be more careful".

## 4. User review

Enter plan mode (EnterPlanMode) and write the full analysis in the user's response language (`language` in `~/.claude/settings.json`). Present via ExitPlanMode; do not proceed until approved. The user may correct the analysis, revise countermeasures, and strip sensitive information.

## 5. Create issue

Create the issue on `yusuke-suzuki/dotfiles`, in English, titled `retro: <concise summary>`, with sections `## Violations` (table), `## Root Causes`, and `## Proposed Countermeasures` (task checkboxes). With `gh`, pass the body inline via heredoc; with MCP, use `issue_write` (if it rejects cross-repository targeting, inform the user and stop).

Since the repository is public, describe violations in terms of the rules themselves, not the private task being performed.

Do not implement countermeasures in this skill. If no violations were found, inform the user and create no issue.
