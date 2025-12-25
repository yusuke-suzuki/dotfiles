---
name: data-querying
description: Write and verify SQL queries with BigQuery. Use when executing bq commands, writing SQL queries, or including query results in documents.
---

# Data Querying

## Query Verification Requirements

All queries and data included in documentation MUST be executed with `bq` command and verified before inclusion. Never include unverified queries, made-up data, or untested results.

## Query Development Process

1. **Dry Run First**: Validate query syntax and check cost before execution
   ```bash
   bq query --project_id=<PROJECT_ID> --use_legacy_sql=false --dry_run "SELECT ..."
   ```
   - Cost guideline: <1GB is light, 2GB+ requires optimization
   - Cost: ~$5/TB ($0.005/GB)

2. **Execute and Verify**: Run query and confirm results are returned
   ```bash
   bq query --project_id=<PROJECT_ID> --use_legacy_sql=false --format=csv "SELECT ..."
   ```
   - Confirm the query completes and results are displayed
   - If results don't appear, check job status with `bq show -j <job_id>`

3. **Learn from Existing Queries**: Study queries already in project documentation for date range patterns, table selection, and JOIN patterns

## Query Design Principles

- **Specify exact date ranges**: Avoid unnecessary data scans
  ```sql
  WHERE created_at >= DATETIME('2025-10-01 00:00:00')
    AND created_at < DATETIME('2025-11-01 00:00:00')
  ```
- **Always filter partitioned tables by partition key**
- **Avoid correlated subqueries**: Use JOINs or CTEs with pre-aggregation
- **Filter target records early**: Create CTEs to narrow down targets before joining large tables

## Documentation Standards

When including queries in documentation:

1. Execute the exact query with `bq` command
2. Copy real output - never fabricate data
3. Explain what the query measures
4. State the time period analyzed
5. Document any performance optimizations applied
