# Tool Usage

Use dedicated tools instead of Bash equivalents.

| Operation      | Dedicated tool | Bash (denied in settings.json) |
| -------------- | -------------- | ------------------------------ |
| File search    | Glob           | `find`                         |
| Content search | Grep           | `grep`, `rg`                   |
| Read files     | Read           | `cat`                          |
| Edit files     | Edit           | `sed`, `awk`                   |

If Glob or Grep returns no results, adjust the pattern or search
path and retry. Do not fall back to Bash alternatives.

When a dedicated tool returns a precondition error (e.g., "file not
read yet"), satisfy the precondition and retry. For example, if Edit
fails because the file was not read, use Read first, then retry Edit.
