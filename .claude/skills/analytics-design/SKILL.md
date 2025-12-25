---
name: analytics-design
description: Design analytics infrastructure including KPI definitions and dashboards. Use when creating Looker Studio reports, defining KPIs, or designing monitoring dashboards.
---

# Analytics Design

## Design Process

1. **Define KPIs** - What metrics matter and what are the targets
2. **Design data sources** - Which tables, how to join, what calculations
3. **Design report structure** - Page layout, filter scopes, time granularity
4. **Design visualizations** - Chart types, field mappings, drill-down paths

## KPI Definition

When defining KPIs:

- State the metric name clearly
- Define the calculation method precisely
- Set baseline (current state) and target values
- Identify the data source and measurement query
- Consider leading vs lagging indicators

## Report Structure

### Page Organization

- Separate pages by time granularity (daily vs monthly) to avoid filter confusion
- Group related metrics on the same page
- Use consistent filter scopes within each page

### Data Source Design

- One data source per analytical purpose
- Pre-aggregate where possible for performance
- Include sort-order fields for proper chart ordering
- Add bucket fields for distribution analysis

## Looker Studio Best Practices

### Data Sources

- Name data sources descriptively (e.g., `fix_payment_request_base`)
- Document each field with type and description
- Include calculated fields in the query rather than Looker Studio when possible

### Visualizations

- Use time series for trend analysis
- Use scorecards for current KPI values
- Use tables for detailed breakdowns
- Add comparison periods (previous month, previous year) where relevant
