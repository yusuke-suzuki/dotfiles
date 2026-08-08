# Commit Message Conventions

## Format

- Conventional Commits, English, imperative mood, present tense (`feat: add user authentication`, not `added`)
- Subject ≤ 50 characters including prefix and scope
- Format rules are enforced by `~/.claude/skills/commit/scripts/validate-message.sh <message-file>` — run it on every draft

## Types

| Type       | Changelog Section        |
| ---------- | ------------------------ |
| `feat`     | Features                 |
| `fix`      | Bug Fixes                |
| `perf`     | Performance Improvements |
| `deps`     | Dependencies             |
| `revert`   | Reverts                  |
| `docs`     | Documentation            |
| `style`    | Styles                   |
| `chore`    | Miscellaneous Chores     |
| `refactor` | Code Refactoring         |
| `test`     | Tests                    |
| `build`    | Build System             |
| `ci`       | Continuous Integration   |

Based on release-please `DEFAULT_HEADINGS`; types not listed here do not appear in the generated changelog.

## Breaking Changes

Mark with `!` after the type/scope (`feat!: remove deprecated endpoint`). For detail, add a `BREAKING CHANGE:` footer.

## Body

- Blank line after the subject; start each sentence on a new line; wrap at 72 characters; blank lines between paragraphs
- Explain the rationale (the "why"), not what was modified or how
- Focus on the core motivation; do not enumerate supporting changes (refactoring, cleanup) unless their rationale is independent and non-obvious
- When the commit resolves a GitHub issue, add a closing keyword (`fixes #123`) on its own line at the end of the body, before the `Co-Authored-By` trailer

## After /fixup or --autosquash rebase

The amended commit represents the final state as a single coherent unit; there is no prior "buggy version" in history. Write the message against the actual diff, not against what changed between iterations — avoid phrases like "also fixes bugs found during review".
