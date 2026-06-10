# HR Analytics SQL Project

## Objective

This project analyzes employee attrition, compensation, and workforce distribution using SQL to uncover key drivers of employee turnover and departmental performance differences.

---

## Business Problem

Organizations often struggle to understand why employees leave and how compensation, department structure, and performance ratings influence retention. This analysis aims to identify high-risk departments and provide data-driven insights for workforce planning.

---

## Dataset

The dataset contains 300 employee records with the following attributes:

* Employee demographics (Age, Gender)
* Department and Job Role
* Salary information
* Performance ratings
* Training hours
* Attrition status

---

## SQL Skills Demonstrated

* Aggregations (COUNT, SUM, AVG)
* CASE Statements for conditional logic
* GROUP BY and filtering
* Window Functions (RANK)
* Business KPI calculation (Attrition Rate)

---

## Key Insights

* Total employees analyzed: **300**

* Highest attrition observed in:

  * Sales (**25.45%**)
  * IT (**24.00%**)

* Lowest attrition observed in:

  * Finance (**10.87%**)
  * Marketing (**12.07%**)

* Finance recorded the **highest average salary (~117K)** and lowest attrition, indicating strong retention stability.

* IT shows **high salary (~112K) but still high attrition**, suggesting compensation alone is not sufficient for retention.

* Workforce distribution is relatively balanced across departments, with Operations having the largest headcount.

---

## Business Impact

* Identifies high-risk departments requiring HR intervention (Sales and IT)
* Highlights that salary is not the sole driver of retention
* Supports HR decision-making in workforce planning and retention strategy
* Enables data-driven evaluation of departmental performance

---

## Files in this Project

* dataset.csv → Raw HR dataset
* schema.sql → Table creation script
* analysis.sql → SQL queries for analysis
* insights.md → Detailed findings and recommendations

---

## Conclusion

This project demonstrates how SQL can transform raw HR data into actionable insights that support strategic workforce decisions and employee retention planning.
