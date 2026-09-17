---
name: copyedit
description: Verify the factual references in a draft bound for a public destination — PR description, issue body, review reply.
disable-model-invocation: true
---

# Copyedit

Fact-check a draft before it reaches a public destination: PR description, issue body, review reply. Other drafts — commit messages, design notes, chat replies — are out of scope.

For Japanese drafts, run the `textlint` skill first.

## Check

Verify every reference whose source lies outside the draft:

- PR and issue numbers — `gh pr view`, `gh issue view`
- commit IDs — `git show`
- quotes — byte-for-byte against the original
- numeric claims — against the data they summarize

Names introduced by a proposed design must not be described as already existing.

File paths and identifiers are out of scope; a mistake in either surfaces in the diff.

## Report

Two lists — Findings (location, issue, suggestion) and Could not verify (with the reason) — then one line of judgment: ready, ready with minor edits, or needs rework. Do not enumerate what checked out.

## Boundaries

Do not invent facts, fill in omissions, or change the author's argument. Wording and style belong to textlint. The textlint pre-pass may modify the draft file; beyond that this is read-only.
