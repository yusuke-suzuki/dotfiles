# Tool Usage

Use dedicated tools instead of Bash equivalents.

| Operation  | Dedicated tool | Bash (denied in settings.json) |
| ---------- | -------------- | ------------------------------ |
| Read files | Read           | `cat`                          |
| Edit files | Edit           | `sed`, `awk`                   |

When a dedicated tool returns a precondition error (e.g., "file not
read yet"), satisfy the precondition and retry. For example, if Edit
fails because the file was not read, use Read first, then retry Edit.
