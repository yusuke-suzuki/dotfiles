# Tool Usage

Use dedicated tools instead of Bash equivalents.

## GitHub CLI vs MCP

When both GitHub CLI (`gh`) and MCP GitHub tools are available, always prefer GitHub CLI. Use MCP GitHub tools only when the equivalent `gh` command does not exist or cannot achieve the desired result.

## Dedicated Tools vs Bash

| Operation  | Dedicated tool | Bash (denied in settings.json) |
| ---------- | -------------- | ------------------------------ |
| Read files | Read           | `cat`                          |
| Edit files | Edit           | `sed`, `awk`                   |

When a dedicated tool returns a precondition error (e.g., "file not read yet"), satisfy the precondition and retry. For example, if Edit fails because the file was not read, use Read first, then retry Edit.

## CLI body delivery

When passing a user-facing body to `gh api`, `gh pr edit`, `gh pr create`, `gh issue create`, `gh issue comment`, or any similar command, supply the body inline via heredoc — not by writing the body to a temp file and reading it back. The body must be visible in the tool call itself so the user can review it before the call executes.

OK — heredoc inline:

```bash
gh api ... -f body="$(cat <<'EOF'
body content
EOF
)"
```

NG — temp file:

```bash
printf '...' > /tmp/body.md && gh api ... --input /tmp/body.md
```

Heredoc keeps the published artifact and the tool-call record aligned. Temp files hide the body from the tool call and force the user to open another file to audit what was sent. This applies to any CLI body, not just to the `publish` skill.

## Destructive commands and exit status

A pipeline's exit status is the last command's, so `fallible-step | grep | tail` reports the filter's success and hides the fallible step's failure. Chaining a destructive follow-up onto such a pipeline with `&&` lets the destruction run on top of an unnoticed failure.

NG — the rollback's failure is masked and the delete runs anyway:

```bash
rails db:rollback | grep -v noise | tail -3 && rm db/migrate/x.rb
```

OK — run the fallible step alone, confirm its outcome from the output, then run the destructive step in a separate call:

```bash
rails db:rollback
# confirm "reverted" in the output, then:
rm db/migrate/x.rb
```

Destructive or state-changing commands (`rm`, `git rm`, `git reset`, `git clean`, `DROP` / `DELETE`, overwriting a file) never belong on the right side of `&&` after a pipeline.
