# Customer Churn Analysis — SQL Project

## Objective

Analyse churn patterns across 500 telecom customers to identify high-risk segments, quantify revenue at risk, and generate actionable retention recommendations using SQL.

## Business Questions Answered

| # | Question | SQL Concept |
|---|----------|-------------|
| 1 | Overall churn rate | CASE + Aggregation |
| 2 | Churn by contract type | GROUP BY + CASE |
| 3 | Churn by payment method | GROUP BY + CASE |
| 4 | Churn by internet service | GROUP BY + AVG |
| 5 | Identify high-risk customers | Subquery |
| 6 | Risk segmentation labels | CASE statements |
| 7 | Churn rate by monthly charge band | CTE + CASE |
| 8 | Churn rate by tenure cohort | CTE + CASE |
| 9 | Full risk profile summary | Chained CTEs |
| 10 | Rank customers by charges within contract | Window Function — RANK() PARTITION BY |
| 11 | Tech support vs churn impact | CASE + GROUP BY |
| 12 | Annualised revenue at risk | CTE + derived calculation |

## SQL Concepts Demonstrated

- `CASE` statements for conditional classification and aggregation
- **Subqueries** for filtering based on derived conditions
- **CTEs** (`WITH` clause) — single and chained
- **Window Functions:** `RANK() OVER (PARTITION BY ... ORDER BY ...)`
- `GROUP BY` with multiple metrics
- Derived calculations (annualised revenue, churn rate percentages)
- Multi-condition `WHERE` filtering

## Files

| File | Description |
|------|-------------|
| `dataset.csv` | 500 customer records with churn labels |
| `schema.sql` | Table definition |
| `analysis.sql` | 12 business questions with full SQL queries |
| `insights.md` | Business findings and retention recommendations |

## Key Findings Summary

- Overall churn rate: **34.4%**
- **Month-to-Month** contracts churn at **50%** vs just **15.2%** for Two Year
- **Electronic Check** payment method has the highest churn (~48%)
- Customers in their **first 12 months** are the most at risk
- Customers **without tech support** churn at significantly higher rates

## How to Run

```sql
-- 1. Create the table
SOURCE schema.sql;

-- 2. Import dataset.csv into the customers table

-- 3. Run queries
SOURCE analysis.sql;
```
