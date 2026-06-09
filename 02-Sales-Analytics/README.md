# Sales Analytics SQL Project

## Objective

Analyse 970 sales transactions across a full calendar year (2024) to uncover revenue trends, top-performing products, regional gaps, profit margins, and customer segment behaviour using SQL.

## Business Questions Answered

| # | Question | SQL Concept |
|---|----------|-------------|
| 1 | Overall sales performance summary | Aggregation |
| 2 | Monthly revenue trend | GROUP BY + DATE functions |
| 3 | Top products by revenue and profit | GROUP BY + ORDER BY |
| 4 | Best performing region | GROUP BY + AVG |
| 5 | Profit margin by category | Derived calculations |
| 6 | Customer segment comparison | GROUP BY + division |
| 7 | Top product per region | Window Function — RANK() PARTITION BY |
| 8 | Running total of monthly revenue | Window Function — SUM() ROWS UNBOUNDED |
| 9 | Month-over-month revenue growth | Window Function — LAG() |
| 10 | Top 15 customers by revenue | CTE + RANK() |
| 11 | Categories above revenue threshold | HAVING |

## SQL Concepts Demonstrated

- `GROUP BY` with multiple columns
- `HAVING` for post-aggregation filtering
- `DATE_FORMAT` / `STRFTIME` for time-series grouping
- `CASE` statements for conditional logic
- **CTEs** (`WITH` clause) for readable multi-step queries
- **Window Functions:** `RANK()`, `LAG()`, `SUM() OVER()`, `PARTITION BY`
- Running totals with `ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW`
- Subqueries as derived tables

## Files

| File | Description |
|------|-------------|
| `dataset.csv` | 970 sales orders — full year 2024 |
| `schema.sql` | Table definition |
| `analysis.sql` | 11 business questions with full SQL queries |
| `insights.md` | Business findings and recommendations |

## Key Findings Summary

- Total revenue: **$430,658** | Profit margin: **46.9%**
- **Laptop Pro** accounts for ~45% of total revenue
- **North** is the top region; **West** significantly underperforms
- **Q4 (November)** is peak season; **Q3 (June–July)** is the weakest period
- **Enterprise** customers generate the highest revenue per customer

## How to Run

Load the dataset into any SQL environment (MySQL, PostgreSQL, SQLite, DBeaver, or DB Browser for SQLite):

```sql
-- 1. Create the table
SOURCE schema.sql;

-- 2. Import dataset.csv into the sales table

-- 3. Run queries
SOURCE analysis.sql;
```
