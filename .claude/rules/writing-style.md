# Writing Style

Apply to all text output: documents, PR descriptions, commit messages, comments.

- Write plainly. Avoid exaggeration, meta-phrasings, metaphors, and abstract jargon. In Japanese, prefer plain Japanese over katakana loanwords when a natural equivalent exists (established proper nouns like `JSON`, `API`, `Pull Request` are fine).
- Do not invent background, motivation, or intent the user has not stated. Ask when needed project-specific context is missing.
- Replace relative references (「以前」「今後」, old/new contrasts) with concrete ones (class name, method name, PR number, commit id).
- In Japanese prose, put half-width spaces around alphanumerics, code spans, and links, and use half-width parentheses `()`.
- Match the established tone and formality of text being edited (です/ます vs である/だ — never mix within one context). Do not restyle database values or API responses.
- Do not hard-wrap Markdown paragraphs. Hard wrapping applies only to fixed-width destinations: commit messages (72 columns) and code comments.
- Documents are self-contained deliverables: no relative links to local files, no progress-tracking sections or meta-commentary, and first-use terms defined in the document rather than in chat history. Preserve the structure of provided templates.
- End generated documents and PR descriptions with this signature (after any template's closing line):

  ```text
  🤖 Generated with [Claude Code](https://claude.ai/code)
  ```
