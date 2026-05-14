# Writing Style (Japanese)

Apply to all Japanese prose text (documents, comments, descriptions).

## Tone

Avoid Japanese-specific exaggerated expressions. They overstate the
change and weaken precise technical claims. This is the Japanese
counterpart to `writing-style.md` "Tone".

Avoid:

- 「完全に〜する」「徹底的に〜する」「全く〜ない」「絶対に〜」
- 「断ち切る」「一掃する」「根絶する」

Use specific, quantitative wording instead:

- OK: `フォールバックを 2 箇所削除した`
- NG: `フォールバックを完全に断ち切った`

## Relative References

Replace relative pointers with concrete references (class name, method
name, PR number, commit id). Time-relative references rot when the
document is read later, since "現在" and "今後" lose their anchor as
time passes.

Avoid:

- 時間的相対参照: 「以前」「現在」「今後」「経過措置として残置」
- 新旧の相対参照: 「旧」「新」「新旧」
- 方向的な相対参照: 「〜側」「〜方向の挙動」

時間的相対参照:

- OK: `この処理は issue #123 の解消後に削除する`
- NG: `この処理は今後削除する`

新旧の相対参照:

- OK: `PR #100 で導入された FooClient の delegate を BarClient に切り替える`
- NG: `旧 client から新 client に切り替える`

方向的な相対参照:

- OK: `Foo#bar の戻り値が変わる`
- NG: `Foo 側の挙動が変わる`

## Vocabulary

Prefer plain Japanese over katakana / English loanwords when
natural Japanese exists. Acceptable katakana and English terms
are restricted to established technical proper nouns (`JSON`,
`API`, `Pull Request`, etc.). Abstract concepts written in
katakana should be replaced with plain Japanese.

The `copyeditor` agent runs the detailed checks (literal
katakana replacement, English-to-Japanese syntax inversion,
mixed-construct particle correctness, coined Japanese
compounds, half-width spacing and parentheses, sentence
completion). The intent at the authoring stage is to catch
the obvious cases before invoking it.

## Style Consistency

When editing existing Japanese text, match the established formality
(です/ます vs である/だ). Never mix within the same context.

## Scope

Do NOT modify: database values, API responses.
