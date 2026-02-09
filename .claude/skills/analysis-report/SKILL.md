---
name: analysis-report
description: Create analysis reports to answer specific questions. Use when analyzing data, exploring BigQuery schemas, or building queries.
---

# Analysis Report

## Workflow

Use [templates/analysis-report-template.md](templates/analysis-report-template.md) to document every analysis.

1. **Clarify Purpose** (Section 1): What do you want to know? Why is this analysis needed? Who will use it?

   **Domain knowledge confirmation:**
   - Confirm factual background with the user — do not assume or speculate on business context (e.g. "cost is high" vs "volume is high")
   - If analyzing a feature/initiative, confirm its exact specifications and parameters (thresholds, targets, display conditions, etc.) before designing queries

   **Questions to answer when comparing pre/post periods:**
   - How will you ensure comparison periods are unified across all metrics?
   - Are the thresholds appropriate for business reality (weekday/weekend patterns, seasonality)?
   - Do any metrics depend on events that haven't occurred yet in the analysis period?
   - What normalization method is appropriate for volume or seasonal variation?
   - How will you account for lead time lag at period boundaries?

2. **Discover Data** (Section 2): Explore available datasets and understand schema.
   - Ask user for project/dataset context and business background
   - Use `/bq-studio` skill for BigQuery schema exploration
   - `db/schema.rb` for Rails projects
   - API docs or sample data for external services
   - Document schema and table relationships in the report

3. **Build Query** (Section 3): Use `/bq-studio` skill to design and execute queries.
   - Requirements and schema from Steps 1-2 provide context
   - Document query design and raw results in each subsection (SQL and results together)

   **Query-result consistency rules:**
   - The SQL written in the report MUST be the exact SQL that was executed — no post-hoc edits to SQL without re-execution
   - When any shared parameter changes (period, filter, threshold), identify ALL queries using that parameter and re-execute all of them
   - After transcribing results to report tables, verify: bucket sums match totals, percentages match counts/totals, and no stale data from previous executions remains

4. **Interpret Results** (Section 4): Analyze query results and draw insights.
   - Interpret results and explain findings
   - Visualize insights with tables and Mermaid diagrams where helpful
