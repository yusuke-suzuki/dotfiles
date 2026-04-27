# Writing Style (Japanese)

Apply to all Japanese prose text (documents, comments, descriptions).

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
