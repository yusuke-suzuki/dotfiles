# Dotfiles Repository

This repository is the source of truth for shell, mise, Claude Code, and Cursor configuration, managed with chezmoi. `install.sh` bootstraps chezmoi; `chezmoi apply` deploys the `dot_`-prefixed sources to `$HOME` (`dot_claude/` → `~/.claude/`, `dot_zshrc` → `~/.zshrc`, and so on).

Rule content lives once under `.chezmoitemplates/rules/` and reaches both tools through the `.tmpl` includes in `dot_claude/rules/` (as `.md`) and `dot_cursor/rules/` (as `.mdc`). Rule files carry Cursor's frontmatter (`description`, `alwaysApply`) and must stay valid for both tools. When adding a rule, create the shared template and both includes. Instructions that only matter for a specific task belong in that task's skill rather than a rule, which loads into every session.

chezmoi source naming applies: executable scripts need the `executable_` prefix, and files deployed with a leading dot need the `dot_` prefix (plain dot-prefixed names are ignored by chezmoi).

When modifying configuration, always edit the source files in this repository — never the deployed copies under `$HOME`. Commit the change, then run `chezmoi apply` to deploy.
