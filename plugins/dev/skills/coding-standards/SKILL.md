---
name: coding-standards
description: Standards for writing, editing, or reviewing code. Load before any code change, however small.
---

# Coding Standards

## Code

- Set the ideal design as the goal before treating existing code as a constraint. Existing code is evidence of what works today, not a standard to build on: when its structure makes a requirement awkward, change the structure instead of patching around it or stacking complexity on top. Meeting the literal request on a flawed foundation is not done.
- Distance to the ideal is no reason to drop it. Plan the path (preparatory refactors first, as separate commits); when it exceeds the request's scope, present the ideal and the path to the user instead of silently settling for the patch.
- Never mix a structural change (a refactoring) and a behavioral change (a feature or a fix) in one commit, whether or not the refactoring prepares for the change.
- Leave code you work in cleaner than you found it, but never mix a cleanup the request does not need into the requested change: put it in its own commit, or in its own pull request when the git-workflow branch rules call for one.
- Match surrounding code in naming and idiom once it is raised to standard.
- Do not use class inheritance; compose behavior through delegation instead. Subclassing a base class the framework requires (e.g. `ApplicationRecord`) is the only exception.
- Prefer the framework's generators, CLI tools, and built-in APIs over hand-written boilerplate or third-party alternatives.
- Fix lint failures instead of suppressing them. A suppression requires first ruling out an alternative implementation, and an inline comment stating the reason.

## Comments

- Write zero code comments. A comment is a last resort, reached only after every alternative has failed to carry the information: a more precise name, an extracted function or named constant, restructured control flow, a type or signature, a test that states the expectation, a commit message, a pull request description, or documentation. Before writing one, name which of those you tried and why each cannot hold the fact; if you cannot name it, there is no comment to write.
- Only a WHY that survives that elimination is admissible: an external constraint invisible from the code (an upstream bug, a protocol or vendor quirk, a deliberate deviation from the obvious approach). Treat "this is a WHY, so it is fine" as the failure mode this rule exists to prevent — most WHYs belong in a commit message or documentation, which the code does not have to carry. Apply the deletion test from the reader's side: if a competent reader loses nothing when the comment is removed, remove it.
- Never comment: WHAT the code does; documented behavior of the language, standard library, or well-known frameworks and tools (anything a reader finds in seconds in official docs); or the current task, fix, or PR. Never match surrounding comment density — a heavily commented file does not justify more or longer comments. When a comment is warranted, keep it to the shortest sentence that states the fact.
- These rules bind edits to existing code as much as new code: never add a comment while touching nearby lines, and delete comments that fail the test when you are already editing that code.
