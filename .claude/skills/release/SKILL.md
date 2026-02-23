---
name: release
description: Determine next semver tag, push it to trigger production deployment, and publish a GitHub release
---

# Release

You are assisting with creating a new release by pushing a semver tag and publishing a GitHub release.

## 1. Current Version

Get the latest semver tag:

```bash
git tag --sort=-v:refname | grep -E '^v[0-9]+\.[0-9]+\.[0-9]+$' | head -1
```

If no tags exist, treat the current version as `v0.1.0` and skip to step 3.

## 2. Changes Since Last Release

List commits with full messages since the latest tag:

```bash
git log <latest-tag>..HEAD --format="%h %s%n%b"
```

Read the commit subjects and bodies to understand the nature of each change.
Display a brief summary of what changed.

## 3. Version Bump Determination

Assess the overall impact of the changes:

- Breaking changes (API incompatibility, removed endpoints, renamed fields) → **major**
- New features or capabilities added → **minor**
- Bug fixes, performance improvements, internal refactoring, dependency updates → **patch**

State your recommendation with reasoning.

Then ask the user to confirm or override via AskUserQuestion:

```
Which version bump type?
- patch: vX.Y.Z → vX.Y.(Z+1)
- minor: vX.Y.Z → vX.(Y+1).0
- major: vX.Y.Z → v(X+1).0.0
```

## 4. Push Tag

Compute the next version from the bump type. Display: `<current-tag> → <next-tag>`

Ask the user to confirm via AskUserQuestion before proceeding.

On confirmation:

```bash
git tag <next-tag>
git push origin <next-tag>
```

Show workflow runs triggered by the tag push:

```bash
gh run list --branch <next-tag>
```

## 5. Create Draft GitHub Release

Create a draft release using GitHub's auto-generated release notes:

```bash
gh release create <next-tag> \
  --draft \
  --generate-notes \
  --title "<next-tag>"
```

Display the draft release URL.

## 6. Publish Release

Ask the user to confirm publishing via AskUserQuestion.

On confirmation:

```bash
gh release edit <next-tag> --draft=false
```

## 7. Final Output

- Pushed tag: `<next-tag>`
- GitHub Actions: show run URL from `gh run list --branch <next-tag>`
- GitHub release: show URL from `gh release view <next-tag> --json url -q .url`
