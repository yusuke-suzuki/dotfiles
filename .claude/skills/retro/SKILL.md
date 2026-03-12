---
name: retro
description: Review the session for rule violations, analyze root causes, and create a GitHub issue with countermeasures
---

# Retrospective

You are conducting a retrospective on the current session. The goal is
to identify violations of CLAUDE.md and rules, analyze root causes,
and propose countermeasures as a GitHub issue.

## 1. Violation Inventory

Review the conversation history and list each instance where your
behavior violated `~/.claude/CLAUDE.md` or any rule in
`~/.claude/rules/`. For each violation, record:

- **What happened** — the concrete action or omission
- **Which rule was violated** — cite the file and section
- **When it occurred** — brief context of the conversation point

Only include confirmed violations. Do not pad the list with
hypothetical or borderline cases.

## 2. Root Cause Analysis

Group related violations and identify underlying patterns. Ask:

- Is the same root cause behind multiple violations?
- Is the violated rule unclear, missing, or scoped too narrowly?
- Did the violation stem from a gap in the rules themselves or from
  failure to follow existing rules?

Distinguish between rule gaps (the rule doesn't exist or is
insufficient) and execution failures (the rule exists but was not
followed).

## 3. Countermeasures

For each root cause, propose a concrete countermeasure. A
countermeasure must be one of:

- **New rule** — add a rule that doesn't exist yet
- **Rule amendment** — strengthen or clarify an existing rule
- **Rule restructure** — reorganize rules so they apply in the right
  contexts
- **CLAUDE.md amendment** — strengthen or clarify a core principle
- **Skill fix** — correct a skill whose workflow produces the
  violation

Each countermeasure should specify:

- Which file to modify (or create)
- What change to make
- Why the change prevents recurrence

Avoid vague proposals like "be more careful." Every countermeasure
must be a durable change to rules, skills, or CLAUDE.md.

## 4. User Review

Present the full analysis (violations, root causes, countermeasures)
to the user. Use AskUserQuestion to confirm:

- Whether the analysis is accurate
- Whether any countermeasures should be added, removed, or revised

Incorporate feedback before proceeding.

## 5. Create GitHub Issue

Create an issue on the dotfiles repository:

```bash
gh issue create -R yusuke-suzuki/dotfiles
```

**Title format:** `retro: <concise summary of the session's failures>`

**Body structure:**

```markdown
## Violations

<table of violations from step 1>

## Root Causes

<grouped analysis from step 2>

## Proposed Countermeasures

<action items from step 3, each as a task list checkbox>
```

**Privacy:** Since the issue is on a public repository, strip any
project-specific details from private contexts. Describe violations
in terms of the rules themselves, not the specific task being
performed.

## Key Constraints

- Do NOT implement countermeasures in this skill. The issue tracks
  the work; implementation happens in separate commits.
- Do NOT create an issue if no violations were found. Inform the
  user and end the workflow.
- Use the conversation language for the issue body. Ask the user
  via AskUserQuestion if the language is ambiguous.
