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

## Spacing

Add half-width spaces around alphanumeric/English and markdown links:

- OK: `追加された権限 (18 件)`
- NG: `追加された権限（18件）`
- OK: `詳しくは [ガイド](./guide.md) を参照`
- NG: `詳しくは[ガイド](./guide.md)を参照`

## Parentheses

Use half-width `()`:

- OK: `ユーザー (User) が追加されました`
- NG: `ユーザー（User）が追加されました`

## Sentence Completion

Complete sentences properly. Don't end with colons:

- OK: `テーブル間の関係をまとめると以下のようになります。`
- NG: `テーブル間の関係をまとめると:`

## Vocabulary

Prefer plain Japanese over katakana/English loanwords when natural
Japanese exists. Established technical terms (`JSON`, `API`, `Pull
Request`, etc.) are fine.

- OK: `事前に存在していたカバレッジの欠落を解消する`
- NG: `pre-existing なカバレッジの gap を close する`

Do not use Japanese words that are unnatural in technical context.
Heuristic: "would a native speaker find this natural?"

- OK: `新しい名前`
- NG: `新名` (reads as a surname or archaic in technical writing)

## Style Consistency

When editing existing Japanese text, match the established formality
(です/ます vs である/だ). Never mix within the same context.

## Scope

Do NOT modify: database values, API responses.
