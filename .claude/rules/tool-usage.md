# Tool Usage

- Use dedicated tools over Bash equivalents: Read instead of `cat`, Edit instead of `sed`/`awk`. On a precondition error (e.g. Edit before Read), satisfy the precondition and retry.
- Prefer GitHub CLI (`gh`) over MCP GitHub tools when both are available.
- Pass user-facing bodies to `gh` and similar CLI commands inline via heredoc, never via a temp file — the body must be visible in the tool call so the user can review it before it runs.
- Never chain a destructive command (`rm`, `git rm`, `git reset`, `git clean`, `DROP`/`DELETE`, file overwrite) with `&&` after a pipeline: a pipeline's exit status is its last command's, so an upstream failure is masked and the destruction runs anyway. Run the fallible step alone, confirm its output, then run the destructive step in a separate call.
