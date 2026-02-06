---
name: analysis-report
description: Create analysis reports to answer specific questions. Use when analyzing data, exploring BigQuery schemas, or building queries.
---

# Analysis Report

**Rules**: Follow [document-writing](../../rules/document-writing.md) and [text-formatting-ja](../../rules/text-formatting-ja.md) for Japanese documents.

## Workflow

Use [references/analysis-report-template.md](references/analysis-report-template.md) to document every analysis.

1. **Clarify Purpose** (Section 1): What do you want to know? Why is this analysis needed? Who will use it?

2. **Discover Data** (Section 2): Explore available datasets and understand schema.
   - Ask user for project/dataset context and business background
   - Use `/bq-query` skill for BigQuery schema exploration
   - `db/schema.rb` for Rails projects
   - API docs or sample data for external services
   - Document schema and table relationships in the report

3. **Build Query** (Section 3): Use `/bq-query` skill to design and execute queries.
   - Requirements and schema from Steps 1-2 provide context
   - Document query design and raw results

4. **Interpret Results** (Section 4): Analyze query results and draw insights.
   - Interpret results and explain findings
   - Visualize insights with tables and Mermaid diagrams where helpful

5. **Verify Style Compliance**: Use `/lint-doc <filename>` to check and fix style violations
