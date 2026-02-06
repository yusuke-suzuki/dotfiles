---
name: looker-studio-report
description: Design Looker Studio reports for ongoing monitoring. Use when creating reports to visualize operations, costs, or metrics.
---

# Looker Studio Report Design

## Workflow

Use [templates/looker-studio-template.md](templates/looker-studio-template.md) to document the report design.

1. **Define Purpose** (Section 1): What needs to be monitored? What decisions will users make based on this report?

2. **Discover Data** (Section 2): Explore available datasets and understand schema.
   - Ask user for project/dataset context and business background
   - Use `/bq-query` skill for BigQuery schema exploration
   - If prior analysis exists, reference it and skip detailed exploration

3. **Define Metrics** (Section 3): Define key metrics and dimensions to monitor.
   - Identify what needs to be measured
   - Define calculation methods and data sources

4. **Design Data Sources** (Section 4): Design BigQuery custom queries for Looker Studio.
   - Check existing resources: Similar reports or queries already exist?
   - Align time granularity with usage frequency (daily/weekly/monthly)
   - Pre-aggregate data in SQL for performance
   - Document query, field definitions, and parameters

5. **Design Pages** (Section 5): Design report pages, charts, and layout.
   - Design page structure and layout
   - Select appropriate chart types for each metric
   - Configure chart settings and filters

6. **Configure Sharing** (Section 6): Set up access permissions for the report.
   - Define who needs view/edit access
   - Document sharing settings

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
