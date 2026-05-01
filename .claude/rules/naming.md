# Naming

Apply when naming functions, classes, types, files, configurations,
or any identifier future readers will encounter.

## Two evaluation axes

Evaluate every name on two independent axes. A name that scores
well on one and poorly on the other still needs revision.

### Semantic Fit

Does the name use domain-idiomatic vocabulary? A name with the
right shape but wrong domain words misleads more than it clarifies.

- Verbs and nouns should come from the domain the code operates
  in (HTTP, queueing, persistence, billing) — not from a generic
  "what the code does" reading.
- Distinct concepts within the same module must use distinct
  vocabulary. Reusing the same noun for unrelated meanings forces
  readers to disambiguate from context.

### Linguistic Naturalness

Is the name natural English? Awkward structure slows reading even
when each individual word is correct.

- Avoid noun stacks longer than three words. `UserProfileImage`
  is fine; `UserProfileImageCacheRefreshScheduler` reads as a
  paragraph.
- Avoid non-idiomatic verb choices. `getX` for things that are not
  retrievals, `processX` for anything generic, and `handleX` for
  catch-all methods all conceal what the code actually does.
- Match common collocations. Prefer `cancel` over `abort` for a
  user-initiated stop; `retry` over `redo` for a transient
  failure; `dispose` over `cleanup` for resource release.

## Critical evaluation of existing names

When extending, renaming, or duplicating an existing name, do not
assume the existing name is correct.

- Read the call sites and the type's behavior. The original name
  may have drifted from the actual responsibility.
- Citing an existing name as precedent ("we already call it `Foo`
  elsewhere") is not justification. See `CLAUDE.md` "Calibrated
  Decision Making → Citing existing patterns".
- A rename worth doing once is worth a 3-candidate trade-off
  table. See `communication.md` "Renames and structural changes".

## Naming process

1. List at least 3 candidates.
2. Evaluate each on Semantic Fit and Linguistic Naturalness.
3. State the recommended choice and the rejected ones with
   reasons.
4. Apply this comparison on the first proposal, not after
   rejection.
