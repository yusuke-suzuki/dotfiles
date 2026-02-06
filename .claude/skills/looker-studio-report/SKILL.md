---
name: looker-studio-report
description: Design Looker Studio reports for ongoing monitoring. Use when creating reports to visualize operations, costs, or metrics.
---

# Looker Studio Report Design

**Rules**: Follow [document-writing](../../rules/document-writing.md) and [text-formatting-ja](../../rules/text-formatting-ja.md) for Japanese documents.

## Workflow

Use [references/looker-studio-template.md](references/looker-studio-template.md) to document the report design.

1. **Define Purpose**: What needs to be monitored? What decisions will users make based on this report?

2. **Discover Data**: Explore available datasets and understand schema.
   - Ask user for project/dataset context and business background
   - Use `/bq-query` skill for BigQuery schema exploration
   - If prior analysis exists, reference it and skip detailed exploration

3. **Design Report**:
   - Check existing resources: Similar reports or queries already exist?
   - Align time granularity with usage frequency (daily/weekly/monthly)
   - Design data sources, pages, and charts

4. **Verify Style Compliance**: Use `/lint-doc <filename>` to check and fix style violations

## Best Practices

### Reference Documentation

- [Data types](https://cloud.google.com/looker/docs/studio/data-types): Field data types (Number, Text, Date & Time, Currency, Percent, etc.)
- [Types of charts](https://cloud.google.com/looker/docs/studio/types-of-charts-in-looker-studio): Chart types (Time series, Combo chart, Table, etc.)

### Settings Documentation

- Verify setting names against actual Looker Studio UI before documenting
- Use exact terminology from the UI

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
