# Tool Usage

Apply when using tools to read, write, or modify files.

## File Search

Use the Glob tool for all file search operations. Never use `ls`,
`find`, or `locate` via Bash, even when Glob returns no results.

If Glob returns no results, adjust the pattern or search path and
retry with Glob. Do not fall back to Bash alternatives.

### Incorrect pattern

- ❌ Glob returns empty → use `ls` via Bash
- ❌ Glob returns empty → use `find` via Bash
- ❌ Glob returns empty → use `locate` via Bash

## Tool Precondition Errors

When a dedicated tool (Edit, Write) returns a precondition error
(e.g., "file not read yet"), satisfy the precondition using the
appropriate tool and retry. Never fall back to Bash equivalents
(cat, sed, awk) to bypass the error.

### Correct pattern

1. Edit fails with "unread file" error
2. Read the file with the Read tool
3. Retry with Edit

### Incorrect pattern

- ❌ Edit fails → use `sed -i` via Bash
- ❌ Read tool unavailable → use `cat` via Bash
