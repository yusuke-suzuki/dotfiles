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
Japanese exists. Acceptable katakana and English terms are
restricted to established technical proper nouns (`JSON`, `API`,
`Pull Request`, etc.). Abstract concepts written in katakana should
be replaced with plain Japanese.

- OK: `事前に存在していたカバレッジの欠落を解消する`
- NG: `pre-existing なカバレッジの gap を close する`

Common abstract loanwords and their Japanese equivalents:

| 避ける表現 | 置き換え候補 |
| --- | --- |
| 「シンプル」 | 「単純」「簡潔」 |
| 「クリア」 | 「明確」「明瞭」 |
| 「アプローチ」 | 「方針」「方法」 |
| 「コンテキスト」 | 「文脈」 |
| 「ニュアンス」 | 「意味合い」「微妙な違い」 |
| 「フィット」 | 「合う」「適する」 |
| 「レイヤ」 | 「層」 |
| 「メリット」「デメリット」 | 「利点」「欠点」 |
| 「カテゴリー」 | 「分類」「区分」 |
| 「マッピング」 | 「対応付け」 (コード内のマップデータ構造を指す場合は除く) |
| 「ロジック」 | 「処理」「論理」 (技術文脈の固有語を除き、抽象的な利用を避ける) |

Do not use Japanese words that are unnatural in technical context.
Heuristic: "would a native speaker find this natural?"

- OK: `新しい名前`
- NG: `新名` (reads as a surname or archaic in technical writing)

### Mixed-construct rules

When embedding English nouns in Japanese sentences, supply the
required particles and do not end the sentence on a noun
(体言止め). Missing particles and 体言止め read as note fragments
rather than complete sentences.

- NG: 「`Foo` だけ root namespace 直接」
- OK: 「`Foo` だけ root の namespace を直接参照する」
- NG: 「内部用 wrapper 削除」
- OK: 「内部用の wrapper を削除する」
- NG: 「`Bar` wrapper だけ」
- OK: 「`Bar` 用の wrapper だけ」

## Style Consistency

When editing existing Japanese text, match the established formality
(です/ます vs である/だ). Never mix within the same context.

## Scope

Do NOT modify: database values, API responses.
