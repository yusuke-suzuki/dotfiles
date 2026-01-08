---
name: data-querying
description: Write and verify SQL queries with BigQuery. Use when executing bq commands, writing SQL queries, or including query results in documents. Trigger on "bq", "BigQuery", "query".
---

# Data Querying

## Query Process

1. **Dry run**: Validate syntax and check cost

   ```bash
   bq query --project_id=<PROJECT_ID> --use_legacy_sql=false --dry_run "SELECT ..."
   ```

   Cost: ~$5/TB. <1GB is light, 2GB+ needs optimization.

2. **Execute**: Run and confirm results

   ```bash
   bq query --project_id=<PROJECT_ID> --use_legacy_sql=false --format=csv "SELECT ..."
   ```

3. **Learn**: Study existing queries in project docs for patterns.

## Query Design

- Specify exact date ranges
- Filter partitioned tables by partition key
- Avoid correlated subqueries (use JOINs/CTEs)
- Filter early with CTEs before joining large tables

## Authentication

If `bq query` fails with authentication error, prompt user to run `gcloud auth login` and resume after login.
