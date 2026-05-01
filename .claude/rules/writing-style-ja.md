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
- OK: 「該当する項目を確認する」
- NG: 「該当 bullet を確認する」 (`bullet` は「項目」と書ける)
- OK: 「閾値との差」
- NG: 「閾値までの距離」

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
| 「クランプ」 | 「制限する」「収める」 (CSS `clamp()` 等の固有語を除き、抽象的な利用を避ける) |

Do not use Japanese words that are unnatural in technical context.
Heuristic: "would a native speaker find this natural?"

- OK: `新しい名前`
- NG: `新名` (reads as a surname or archaic in technical writing)
- OK: `生の値`
- NG: `素値` (coined contraction; not idiomatic Japanese)

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

### Question literal katakana

Words that are merely English transliterations into katakana
(「トリビアル」「ラッパー」「アグリゲーター」「クランプ」, etc.)
read as direct transcriptions rather than established technical
terms. Before writing such a word, check whether plain Japanese
conveys the same meaning.

- OK: 「単純な実装」「委譲を行うクラス」「集約処理」「値を範囲に収める」
- NG: 「トリビアルな実装」「ラッパークラス」「アグリゲーター処理」「値をクランプする」

Established technical proper nouns (`JSON`, `API`, `Pull Request`,
`HTTP`, CSS `clamp()`, etc.) remain in their original form. This
subsection applies only to words that have a plain Japanese
equivalent.

### Don't translate English syntax mechanically

Translating "X of Y" mechanically into 「Y の X」 can invert the
modifier-of relationship between X and Y. Before settling on the
Japanese order, determine which side contains the other and which
side is contained.

- OK: 「`FooClient` が公開する API」 (`FooClient` owns the API)
- NG: 「公開 API の `FooClient` ラッパークラス」 (inverts the
  relationship — reads as if the API owns `FooClient`)

Before stringing together English noun phrases in Japanese,
confirm you can state the relationship explicitly as either "X が
Y を 〜する" or "Y は X の一部である".

### Apply the same vocabulary check inside vocabulary discussions

In conversations where word choice itself is the topic (replies
to feedback about vocabulary, for example), it is easy to coin
fresh unnatural katakana or direct translations inside the very
reply that addresses the feedback. Apply this section's checks
and `writing-style.md` "Vocabulary Grounding" to those replies in
particular.

Before sending the reply, read it in isolation and confirm no new
katakana transliterations or direct translations have been
introduced. Do not let the surrounding feedback context lower the
vocabulary bar.

## Style Consistency

When editing existing Japanese text, match the established formality
(です/ます vs である/だ). Never mix within the same context.

## Scope

Do NOT modify: database values, API responses.
