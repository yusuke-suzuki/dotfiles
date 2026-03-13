# Tool Usage

Apply when using tools to read, write, or modify files.

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
