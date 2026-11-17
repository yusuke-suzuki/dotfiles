#!/bin/bash
set -euo pipefail

skills=(
    address-comments branch coding-standards commit copyedit fixup git-workflow
    retro ruby-on-rails-best-practices squash sync textlint
)

deployed_skill_files=(
    address-comments/SKILL.md
    branch/SKILL.md
    coding-standards/SKILL.md
    commit/SKILL.md
    commit/commit-message.md
    commit/scripts/validate-message.sh
    copyedit/SKILL.md
    fixup/SKILL.md
    git-workflow/SKILL.md
    retro/SKILL.md
    ruby-on-rails-best-practices/SKILL.md
    squash/SKILL.md
    sync/SKILL.md
    textlint/.textlintrc.json
    textlint/SKILL.md
    textlint/prh.yml
    textlint/scripts/lint.sh
)

for skill in "${skills[@]}"; do
    link="$HOME/.claude/skills/$skill"
    if [ -L "$link" ] && [ "$(readlink "$link")" = "../../.agents/skills/$skill" ]; then
        rm "$link"
    fi
done

for file in "${deployed_skill_files[@]}"; do
    rm -f "$HOME/.agents/skills/$file"
done

for skill in "${skills[@]}"; do
    rmdir "$HOME/.agents/skills/$skill/scripts" 2>/dev/null || true
    rmdir "$HOME/.agents/skills/$skill" 2>/dev/null || true
done

rm -f "$HOME/.claude/rules/core.md" "$HOME/.cursor/rules/core.mdc"
