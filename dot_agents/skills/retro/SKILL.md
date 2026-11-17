---
name: retro
description: Review the session for rule violations, analyze root causes, and create a GitHub issue with countermeasures
---

# Retrospective

Identify violations of the deployed skills (`~/.agents/skills/`) in this session, analyze root causes, and record countermeasures as a GitHub issue.

## 1. Violations

List each confirmed violation: what happened, which skill section was violated, and when. Do not pad with hypothetical or borderline cases.

## 2. Root causes

Group related violations and classify each cause:

- **Guidance gap** — no skill covers it, or its guidance is insufficient
- **Load failure** — the skill exists but was not loaded; its description did not match the task
- **Execution failure** — the skill was loaded but not followed
- **Skill workflow deficiency** — the skill's instructions are unclear, incomplete, or misleading

## 3. Countermeasures

Always-loaded text is a budget: skill descriptions load into every session, and there are no always-on rules. Prefer countermeasures in this order:

1. **Mechanical enforcement** — settings.json permissions or hooks, a textlint/prh dictionary entry, or a script inside a skill. A deterministic check beats prose asking the model to be careful.
2. **Skill fix** — correct the skill body that produced the violation, or its description for a load failure. Guidance with no skill yet goes into a new one; only its description costs tokens until it is relevant.
3. **Deletion or simplification** — when the violation stems from conflicting or over-constraining instructions.
4. **Always-on rule (last resort)** — only when the mistake is expensive (data loss, leaking private context, destructive operations), spans every kind of task, no skill description can reliably trigger on it, and the model would not get it right from context alone; a line or two.

"No countermeasure" is a valid conclusion for a one-off failure unlikely to recur — record the violation and move on.

Each countermeasure names the file, the change, and why it prevents recurrence. Never propose "be more careful".

## 4. User review

Enter plan mode (EnterPlanMode) and write the full analysis in the user's response language. Present via ExitPlanMode; do not proceed until approved. The user may correct the analysis, revise countermeasures, and strip sensitive information.

## 5. Create issue

Create the issue on `yusuke-suzuki/dotfiles`, in English, titled `retro: <concise summary>`, with sections `## Violations` (table), `## Root Causes`, and `## Proposed Countermeasures` (task checkboxes). With `gh`, pass the body inline via quoted heredoc (`<<'EOF'`, so the body is not shell-expanded); with MCP, use `issue_write` (if it rejects cross-repository targeting, inform the user and stop).

Since the repository is public, describe violations in terms of the rules themselves, not the private task being performed.

Do not implement countermeasures in this skill. If no violations were found, inform the user and create no issue.
