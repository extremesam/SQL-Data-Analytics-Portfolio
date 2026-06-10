# Executive KPI Dashboard — SQL Project

---

## 1. Project Overview

This project analyzes **36 months of business performance data (2022–2024)** to generate executive-level KPIs typically used in **board reporting, financial reviews, and strategic decision-making**.

The analysis focuses on:

* Revenue and profitability trends
* Customer acquisition and churn dynamics
* Marketing efficiency
* Time-based performance patterns (YoY, MoM, rolling trends)

This represents a **full business intelligence dashboard built entirely in SQL**.

---

## 2. Business Objective

The goal of this project is to simulate real-world executive reporting by answering:

* Is the business growing sustainably?
* Are profits scaling with revenue?
* How efficient is customer acquisition?
* What seasonal patterns affect performance?
* Where are operational risks emerging?

---

## 3. Dataset Overview

* Time Period: **January 2022 – December 2024 (36 months)**
* Granularity: Monthly KPI reporting
* Domain: Subscription-based / SaaS-style business

---

## 4. Business Questions Answered

| #  | Question                               | SQL Concepts Used                    |
| -- | -------------------------------------- | ------------------------------------ |
| 1  | Annual executive performance summary   | Aggregation + CASE                   |
| 2  | Year-over-year revenue growth          | CTE + LAG()                          |
| 3  | Month-over-month revenue trends        | CTE + LAG() / LEAD()                 |
| 4  | Year-to-date running totals            | Window Functions (SUM OVER)          |
| 5  | Same-month YoY comparison              | CASE-based pivoting                  |
| 6  | Profitability trends + rolling margins | Rolling AVG (Window Functions)       |
| 7  | Customer growth and churn dynamics     | LAG() + derived metrics              |
| 8  | Marketing efficiency (CPA analysis)    | CTE + NULLIF + aggregation           |
| 9  | Quarterly performance breakdown        | CASE + GROUP BY                      |
| 10 | Best and worst performing months       | Subqueries + UNION ALL               |
| 11 | Rolling 3-month & 6-month trends       | Window Functions (ROWS BETWEEN)      |
| 12 | Executive KPI scorecard                | Chained CTEs + multi-metric analysis |

---

## 5. SQL Techniques Demonstrated

This project demonstrates advanced SQL capabilities including:

* **Window Functions**

  * `LAG()` for trend analysis
  * `LEAD()` for forward-looking insights
  * `SUM() OVER()` for running totals
  * Rolling averages using window frames

* **Common Table Expressions (CTEs)**

  * Multi-step KPI transformations
  * Executive scorecard construction

* **Time-Series Analysis**

  * Month-over-month growth
  * Year-over-year comparisons
  * Seasonal decomposition

* **Analytical SQL Patterns**

  * CASE-based pivoting
  * Safe division using NULLIF
  * UNION ALL for comparative reporting

---

## 6. Key Insights Summary

* Revenue increased consistently across all years:

  * **+14.2% in 2023**
  * **+23.4% in 2024 (accelerated growth)**

* Net profit margins remained stable at **33–35%**, indicating strong operational efficiency

* **Q4 consistently outperforms all other quarters**, confirming strong seasonal demand

* **Q1 remains the weakest period each year**, showing predictable seasonal slowdown

* Marketing efficiency improved overall but shows **high volatility in specific months**

* Every month in 2024 outperformed its 2023 equivalent in same-month comparisons

---

## 7. Business Impact

This analysis enables executive-level decision-making in:

* Revenue forecasting and planning
* Budget allocation across quarters
* Marketing spend optimization
* Performance benchmarking across years
* Early identification of business slowdowns

---

## 8. Files in This Project

| File           | Description                           |
| -------------- | ------------------------------------- |
| `dataset.csv`  | 36 months of KPI data (2022–2024)     |
| `schema.sql`   | Table structure definition            |
| `analysis.sql` | 12 executive-level SQL queries        |
| `insights.md`  | Business insights and recommendations |

---

## 9. How to Run

```sql
-- 1. Create table
SOURCE schema.sql;

-- 2. Load dataset into kpi_monthly table

-- 3. Run analysis
SOURCE analysis.sql;
```

---

## 10. Conclusion

This project demonstrates how SQL can be used to move beyond basic reporting into **executive-level business intelligence**, combining financial, customer, and operational KPIs into a unified analytical framework.

It reflects real-world analytics work used in **board reporting, SaaS performance tracking, and strategic decision support**.
