# Executive KPI Dashboard — SQL Project

## Objective

Analyse 36 months of business performance data (2022–2024) to produce executive-level KPIs including year-over-year growth, profitability trends, customer metrics, and rolling averages — the kind of SQL that powers real board reporting.

## Business Questions Answered

| # | Question | SQL Concept |
|---|----------|-------------|
| 1 | Annual executive summary | Aggregation + CASE |
| 2 | Year-over-year revenue growth | CTE + LAG() |
| 3 | Monthly revenue with MoM growth | CTE + LAG() + LEAD() |
| 4 | Year-to-date running totals | Window — SUM() PARTITION BY YEAR |
| 5 | Same-month comparison across 3 years | Pivoting with CASE |
| 6 | Profitability trend + 3M rolling margin | CTE + Rolling AVG() |
| 7 | Customer growth and monthly churn rate | LAG() + derived metrics |
| 8 | Marketing efficiency and CPA | CTE + NULLIF + Window AVG |
| 9 | Quarterly rollup | CASE quarters + GROUP BY |
| 10 | Best and worst revenue months | Subquery + UNION ALL |
| 11 | 3-month and 6-month rolling revenue avg | Window — ROWS BETWEEN |
| 12 | Full executive scorecard | Chained CTEs + LAG() |

## SQL Concepts Demonstrated

- **LAG()** — month-over-month and year-over-year comparisons
- **LEAD()** — forward-looking next-month preview
- **Running totals** — `SUM() OVER (PARTITION BY Year ORDER BY Month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)`
- **Rolling averages** — 3-month and 6-month windows
- **Chained CTEs** — multi-step executive scorecard
- **CASE** — quarterly bucketing, conditional pivoting
- **UNION ALL** — combining best/worst month results
- **NULLIF** — safe division to avoid divide-by-zero
- **Pivoting** — same-month cross-year comparisons

## Files

| File | Description |
|------|-------------|
| `dataset.csv` | 36 months of monthly KPI data (2022–2024) |
| `schema.sql` | Table definition |
| `analysis.sql` | 12 executive business questions |
| `insights.md` | Business findings and strategic recommendations |

## Key Findings Summary

- Revenue grew **+14.2% in 2023** and **+23.4% in 2024** — accelerating growth
- Net profit margin held steady at **33–35%** across all three years
- **Q4 is the strongest quarter** every year; **Q1 is consistently softest**
- Marketing cost per acquisition improved year-on-year as scale increased
- Every month in 2024 outperformed its 2023 equivalent on a same-month basis

## How to Run

```sql
-- 1. Create the table
SOURCE schema.sql;

-- 2. Import dataset.csv into the kpi_monthly table

-- 3. Run queries
SOURCE analysis.sql;
```
