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

Always-on prompt text is a budget: every added rule loads into every future session, and this workflow is historically the main source of rule growth. Prefer countermeasures in this order:

1. **Mechanical enforcement** — settings.json permissions or hooks, a textlint/prh dictionary entry, or a script inside a skill. A deterministic check beats prose asking the model to be careful.
2. **Skill fix** — correct the on-demand workflow that produced the violation; it loads only when invoked.
3. **Rule deletion or simplification** — when the violation stems from conflicting or over-constraining rules.
4. **Always-on rule addition (last resort)** — only when the mistake is expensive (data loss, leaking private context, destructive operations) and the model would not get it right from context alone; a line or two, never a new section.

"No countermeasure" is a valid conclusion for a one-off failure unlikely to recur — record the violation and move on.

Each countermeasure names the file, the change, and why it prevents recurrence. Never propose "be more careful".

## 4. User review

Enter plan mode (EnterPlanMode) and write the full analysis in the user's response language. Present via ExitPlanMode; do not proceed until approved. The user may correct the analysis, revise countermeasures, and strip sensitive information.

## 5. Create issue

Create the issue on `yusuke-suzuki/dotfiles`, in English, titled `retro: <concise summary>`, with sections `## Violations` (table), `## Root Causes`, and `## Proposed Countermeasures` (task checkboxes). With `gh`, pass the body inline via quoted heredoc (`<<'EOF'`, so the body is not shell-expanded); with MCP, use `issue_write` (if it rejects cross-repository targeting, inform the user and stop).

Since the repository is public, describe violations in terms of the rules themselves, not the private task being performed.

Do not implement countermeasures in this skill. If no violations were found, inform the user and create no issue.
