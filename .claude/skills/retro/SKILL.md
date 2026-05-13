---
name: retro
description: Review the session for rule violations, analyze root causes, and create a GitHub issue with countermeasures
---

# Retrospective

You are conducting a retrospective on the current session. The goal is
to identify violations of CLAUDE.md, rules, and skill workflows,
analyze root causes, and propose countermeasures as a GitHub issue.

## 1. Violation Inventory

Review the conversation history and list each instance where your
behavior violated `~/.claude/CLAUDE.md`, any rule in
`~/.claude/rules/`, or any skill workflow in `~/.claude/skills/`.
For each violation, record:

- **What happened** — the concrete action or omission
- **Which rule or skill was violated** — cite the file and section
- **When it occurred** — brief context of the conversation point

Only include confirmed violations. Do not pad the list with
hypothetical or borderline cases.

## 2. Root Cause Analysis

Group related violations and identify underlying patterns. Ask:

- Is the same root cause behind multiple violations?
- Is the violated rule unclear, missing, or scoped too narrowly?
- Did the violation stem from a gap in the rules themselves or from
  failure to follow existing rules?
- Did a skill's workflow lack clarity, miss a step, or guide the
  agent toward the wrong action?

Distinguish between:

- **Rule gaps** — the rule doesn't exist or is insufficient
- **Execution failures** — the rule exists but was not followed
- **Skill workflow deficiencies** — the skill's instructions are
  unclear, incomplete, or produce suboptimal results

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

Use the `EnterPlanMode` tool to enter plan mode, then write the full
analysis (violations, root causes, countermeasures) to the plan file.
The plan is a user-facing deliverable, so write it in the user's
response language (`language` in `~/.claude/settings.json`). Use the
`ExitPlanMode` tool to present it for user review.

The user reviews the plan and may:

- Correct inaccurate analysis
- Add, remove, or revise countermeasures
- Remove sensitive information (internal URLs, tokens, PII, private
  repository references) before the issue is created

Do not proceed beyond Step 4 until the user approves the plan.

## 5. Copyedit before submitting

Before creating the issue, invoke the `copyeditor` agent on the
approved issue body.

Use the `Agent` tool with `subagent_type: copyeditor`. Pass:

1. The approved issue body verbatim (violations table, root
   causes, countermeasures).
2. The destination: "GitHub issue body on yusuke-suzuki/dotfiles".
3. Context for fact verification: the rule and skill file paths
   the body cites, and any referenced PR / issue numbers.

Apply the agent's findings before issue creation. If a finding
is rejected, state the reason inline.

## 6. Create GitHub Issue

Create an issue on the dotfiles repository.

**With `gh`**: use a HEREDOC inline within the command. Do not stage
the body to a local file (e.g. `/tmp/issue-body.md`) — once the file
exists, the follow-up `gh` call sends content the user has not yet
reviewed.

```bash
gh issue create -R yusuke-suzuki/dotfiles \
  --title "<title>" \
  --body-file - <<'EOF'
<body>
EOF
```

**With GitHub MCP**: use the `issue_write` tool with `owner: "yusuke-suzuki"`, `repo: "dotfiles"`, and the title and body as parameters. If the tool rejects cross-repository targeting, inform the user and end the workflow.

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
- Write the issue title and body in English.
