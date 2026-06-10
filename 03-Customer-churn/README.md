# Customer Churn Analysis — SQL Project

## Overview

This project analyzes **500 telecom customers** to understand churn behavior, identify high-risk customer segments, and quantify key drivers of customer attrition using SQL.

The objective is to translate raw customer data into **actionable retention insights that reduce revenue loss and improve customer lifetime value**.

---

## Business Objective

Customer churn is one of the most critical challenges in subscription-based businesses.

This project focuses on answering:

* Who is likely to leave the service?
* Why are customers churning?
* Which customer segments are most at risk?
* What strategies can reduce churn?

---

## Dataset Overview

The dataset contains **500 customer records** with behavioral, financial, and subscription attributes:

* Customer demographics (Age, Gender)
* Subscription details (Contract Type, Internet Service, Payment Method)
* Usage behavior (Tech Support, Online Backup, Number of Services)
* Financial metrics (Monthly Charges, Total Charges)
* Target variable: **Churn (Yes/No)**

---

## Key Business Metrics

* Total Customers: **500**
* Churned Customers: **172**
* Overall Churn Rate: **34.4%**

---

## SQL Techniques Used

This project demonstrates intermediate to advanced SQL techniques:

* Aggregations (COUNT, SUM, AVG)
* CASE statements for segmentation and risk scoring
* GROUP BY with multiple dimensions
* Subqueries for filtered analysis
* Common Table Expressions (CTEs)
* Window Functions:

  * RANK() for customer ranking
* Derived metrics (churn rate, revenue risk, segmentation logic)

---

## Business Questions Answered

| #  | Question                                                | SQL Techniques Used   |
| -- | ------------------------------------------------------- | --------------------- |
| 1  | What is the overall churn rate?                         | CASE + Aggregation    |
| 2  | How does churn vary by contract type?                   | GROUP BY + CASE       |
| 3  | What is the impact of payment method on churn?          | GROUP BY              |
| 4  | How does internet service type affect churn?            | GROUP BY              |
| 5  | Who are the high-risk customers?                        | Subqueries            |
| 6  | How can customers be segmented by risk level?           | CASE statements       |
| 7  | What is churn rate by monthly charge band?              | CTE + CASE            |
| 8  | How does tenure affect churn behavior?                  | CTE + cohort analysis |
| 9  | What does a full churn risk profile look like?          | Chained CTEs          |
| 10 | Which customers are highest spenders per contract type? | Window Functions      |
| 11 | How does tech support affect churn?                     | GROUP BY              |
| 12 | What is the revenue at risk from churn?                 | Derived calculations  |

---

## Key Findings

### 1. High Overall Churn

The churn rate is **34.4%**, meaning more than 1 in 3 customers are leaving the service.

---

### 2. Contract Type is the Strongest Driver

* Month-to-month customers have significantly higher churn rates (~50%)
* Two-year contracts show the lowest churn (~15%)

**Insight:** Contract commitment strongly influences retention.

---

### 3. Payment Method Matters

Electronic Check users show the highest churn rates (~48%), indicating potential trust or convenience issues.

---

### 4. Early Lifecycle Risk

Customers within their first 12 months are the most vulnerable to churn.

**Insight:** Onboarding experience is a critical retention window.

---

### 5. Service Engagement Reduces Churn

Customers without Tech Support or Online Backup services are significantly more likely to churn.

**Insight:** Engagement and service adoption improve retention.

---

## Business Impact

This analysis supports strategic decisions in:

* Reducing early-stage customer churn
* Promoting long-term contracts
* Improving onboarding experience
* Encouraging adoption of support services
* Identifying and prioritizing high-risk customers

---

## Key Risks Identified

* High dependency on month-to-month contracts
* Weak early-stage customer retention
* Low engagement among unsupported users
* Payment method-related churn concentration

---

## Conclusion

This project demonstrates how SQL can be used to analyze customer churn behavior and uncover actionable retention strategies. The findings highlight that churn is primarily driven by **contract structure, customer engagement, and early lifecycle experience rather than pricing alone**.
