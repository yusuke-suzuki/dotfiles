---
name: analytics-design
description: Design data analysis from purpose clarification to visualization. Use when analyzing data, exploring BigQuery schemas, building queries, or creating Looker Studio reports.
---

# Analytics Design

## Workflow

Use [references/analytics-design-template.md](references/analytics-design-template.md) to document every analysis.

1. **Clarify Purpose**: What do you want to know? Why is this analysis needed? Who will use it? One-time or ongoing monitoring?

2. **Discover Data**: Explore available datasets and understand schema.
   - Ask user for project/dataset context and business background
   - `bq ls`, `bq show --schema` for BigQuery tables
   - `db/schema.rb` for Rails projects
   - API docs or sample data for external services
   - Understand table relationships (ER diagrams help)

3. **Build Query**: Write SQL based on discovered schema.
   - Use CTEs for readability
   - Execute using BigQuery CLI (see [BigQuery Query Execution](#bigquery-query-execution) below)
   - Interpret results and document findings

4. **Create Dashboard** (if ongoing monitoring needed):
   - Use [references/looker-studio-template.md](references/looker-studio-template.md) to design
   - Define decisions: What actions will users take based on this dashboard?
   - Check existing resources: Similar dashboards or queries already exist?
   - Align time granularity with usage frequency (daily/weekly/monthly)
   - Design data sources, pages, and charts

## BigQuery Query Execution

### Prerequisites

Check gcloud configuration before running queries:

```bash
gcloud config get-value project
```

- If authentication error: prompt user to run `gcloud auth login`, then resume
- If project unset: prompt user to run `gcloud config set project <PROJECT_ID>`

### Execution Process

1. **Dry run**: Validate syntax and estimate cost

   ```bash
   bq query --use_legacy_sql=false --dry_run "SELECT * FROM \`project.dataset.table\`"
   ```

   Cost: ~$5/TB. <1GB is light, 2GB+ needs optimization.

2. **Execute**: Run and confirm results

   ```bash
   bq query --use_legacy_sql=false --format=csv "SELECT * FROM \`project.dataset.table\`"
   ```

Always use fully-qualified table names: `project.dataset.table`

### Query Design Tips

- Specify exact date ranges
- Filter partitioned tables by partition key
- Avoid correlated subqueries (use JOINs/CTEs)
- Filter early with CTEs before joining large tables

## Looker Studio Best Practices

### Data Source Design

- One data source per analytical purpose
- Pre-aggregate in SQL for performance
- Include bucket fields for distribution analysis
- Include sort-order fields for proper chart ordering
- Descriptive data source names

### Report Structure

- Separate pages by time granularity (daily/monthly)
- Group related metrics per page
- Consistent filter scopes within pages

### Chart Type Selection

| Purpose | Chart Type |
|---------|------------|
| KPI current value | Scorecard |
| Time series trend | Time series chart |
| Category breakdown over time | Stacked area / Stacked bar |
| Category comparison | Bar chart |
| Composition | Pie chart |
| Detailed data | Table |
| Distribution (percentile) | Time series (multiple metrics) |
