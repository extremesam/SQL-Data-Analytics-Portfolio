# Sales Analytics SQL Project (2024)

## Overview

This project analyzes **970 sales transactions from 2024** to uncover key business insights across revenue performance, product contribution, regional sales distribution, customer segmentation, and seasonal trends.

The goal is to transform raw transactional data into **actionable business intelligence for strategic decision-making**.

---

## Business Objective

Organizations often struggle with understanding:

* Which products drive the most revenue and profit
* How sales vary across time (seasonality)
* Which regions are underperforming
* Which customer segments are most valuable
* How revenue concentration impacts business risk

This project uses SQL to answer these questions and support data-driven business strategy.

---

## Key Business Insights (Summary)

* Total Revenue: **$430,658**

* Total Profit: **$201,787**

* Profit Margin: **46.9%**

* **Laptop Pro** contributes ~45% of total revenue (key revenue driver)

* **North region** is the strongest market, while **West** underperforms significantly

* **SMB customers** generate the highest share of revenue

* Sales show strong **seasonality**, with peak performance in November and weaker mid-year months (June–July)

---

## Business Questions Answered

| #  | Question                   | SQL Techniques Used        |
| -- | -------------------------- | -------------------------- |
| 1  | Overall sales performance  | Aggregation                |
| 2  | Monthly revenue trend      | Date functions + GROUP BY  |
| 3  | Top products by revenue    | GROUP BY + ORDER BY        |
| 4  | Regional performance       | GROUP BY + aggregation     |
| 5  | Profit margin by category  | Derived calculations       |
| 6  | Customer segment analysis  | GROUP BY                   |
| 7  | Top product per region     | Window function (RANK)     |
| 8  | Running total revenue      | Window function (SUM OVER) |
| 9  | Month-over-month growth    | Window function (LAG)      |
| 10 | Top customers              | CTE + ranking              |
| 11 | Revenue threshold analysis | HAVING clause              |

---

## SQL Skills Demonstrated

* Aggregations (SUM, AVG, COUNT)
* GROUP BY and HAVING filters
* CASE statements for conditional logic
* Date/time analysis for trend detection
* Common Table Expressions (CTEs)
* Window Functions:

  * RANK()
  * LAG()
  * SUM() OVER (running totals)
* Subqueries and derived tables

---

## Project Structure

| File         | Description                           |
| ------------ | ------------------------------------- |
| dataset.csv  | 970 sales transactions (2024)         |
| schema.sql   | Table creation script                 |
| analysis.sql | SQL queries for business questions    |
| insights.md  | Business insights and recommendations |

---

## Business Impact

This analysis supports strategic decision-making in the following areas:

* **Product strategy:** Identify and scale high-performing products (e.g., Laptop Pro)
* **Regional strategy:** Address underperformance in the West region
* **Customer strategy:** Focus on high-value SMB and Enterprise customers
* **Revenue planning:** Optimize for seasonal demand patterns
* **Risk management:** Reduce dependency on a single product for revenue stability

---

## How to Run the Project

### Step 1: Create table

```sql
SOURCE schema.sql;
```

### Step 2: Load dataset

Import `dataset.csv` into the sales table using your SQL tool (PostgreSQL, MySQL, SQLite, or DBeaver).

### Step 3: Run analysis

```sql
SOURCE analysis.sql;
```

---

## Conclusion

This project demonstrates how SQL can be used to convert raw transactional data into **structured business intelligence insights**, enabling better decision-making across product, customer, regional, and time-based dimensions.
