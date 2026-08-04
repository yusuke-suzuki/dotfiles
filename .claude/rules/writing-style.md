# Writing Style

- In Japanese prose, prefer plain Japanese over katakana loanwords when a natural equivalent exists, put half-width spaces around alphanumerics/code spans/links, and use half-width parentheses `()`.
- Before publishing Japanese prose (PR description, issue body, review comment, document) and before committing changes that add or edit Japanese text (code comments, docstrings, test case titles, documents), run the `textlint` skill's auto-fix and review what it cannot fix.
- Replace relative references (「以前」「今後」, old/new contrasts) with concrete ones (class name, method name, PR number, commit id). Do not invent background or motivation the user has not stated.
- Hard-wrap only fixed-width destinations (commit messages at 72 columns, code comments) — never Markdown paragraphs.
- End generated documents and PR descriptions with this signature (after any template's closing line):

  ```text
  🤖 Generated with [Claude Code](https://claude.ai/code)
  ```
