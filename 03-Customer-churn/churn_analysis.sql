-- ============================================================
-- CUSTOMER CHURN ANALYSIS — SQL ANALYSIS
-- Dataset: 500 customers | Telecom subscription service
-- ============================================================


-- ============================================================
-- BUSINESS QUESTION 1: What is the overall churn rate?
-- ============================================================

SELECT
    COUNT(*)                                               AS TotalCustomers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)        AS ChurnedCustomers,
    SUM(CASE WHEN Churn = 'No'  THEN 1 ELSE 0 END)        AS RetainedCustomers,
    ROUND(
        100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*), 2
    )                                                      AS ChurnRatePct
FROM customers;


-- ============================================================
-- BUSINESS QUESTION 2: Churn rate by contract type
-- ============================================================

SELECT
    ContractType,
    COUNT(*)                                               AS TotalCustomers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)        AS Churned,
    ROUND(
        100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*), 2
    )                                                      AS ChurnRatePct
FROM customers
GROUP BY ContractType
ORDER BY ChurnRatePct DESC;


-- ============================================================
-- BUSINESS QUESTION 3: Churn rate by payment method
-- ============================================================

SELECT
    PaymentMethod,
    COUNT(*)                                               AS TotalCustomers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)        AS Churned,
    ROUND(
        100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*), 2
    )                                                      AS ChurnRatePct
FROM customers
GROUP BY PaymentMethod
ORDER BY ChurnRatePct DESC;


-- ============================================================
-- BUSINESS QUESTION 4: Churn rate by internet service type
-- ============================================================

SELECT
    InternetService,
    COUNT(*)                                               AS TotalCustomers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)        AS Churned,
    ROUND(
        100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*), 2
    )                                                      AS ChurnRatePct,
    ROUND(AVG(MonthlyCharges), 2)                          AS AvgMonthlyCharges
FROM customers
GROUP BY InternetService
ORDER BY ChurnRatePct DESC;


-- ============================================================
-- BUSINESS QUESTION 5: Identify high-risk customers (Subquery)
-- Criteria: Month-to-Month contract, tenure < 12 months,
--           no tech support, and monthly charges > $70
-- ============================================================

SELECT
    CustomerID,
    ContractType,
    Tenure,
    MonthlyCharges,
    PaymentMethod,
    TechSupport,
    Churn
FROM customers
WHERE CustomerID IN (
    SELECT CustomerID
    FROM customers
    WHERE ContractType   = 'Month-to-Month'
      AND Tenure         < 12
      AND TechSupport    = 'No'
      AND MonthlyCharges > 70
)
ORDER BY MonthlyCharges DESC;


-- ============================================================
-- BUSINESS QUESTION 6: Churn risk segments using CASE
-- ============================================================

SELECT
    CustomerID,
    Tenure,
    ContractType,
    MonthlyCharges,
    NumServices,
    Churn,
    CASE
        WHEN ContractType = 'Month-to-Month' AND Tenure < 12 AND MonthlyCharges > 70
            THEN 'High Risk'
        WHEN ContractType = 'Month-to-Month' AND Tenure BETWEEN 12 AND 24
            THEN 'Medium Risk'
        WHEN ContractType IN ('One Year', 'Two Year') AND NumServices >= 3
            THEN 'Low Risk'
        ELSE 'Standard'
    END                                                    AS ChurnRiskSegment
FROM customers
ORDER BY
    CASE
        WHEN ContractType = 'Month-to-Month' AND Tenure < 12 AND MonthlyCharges > 70
            THEN 1
        WHEN ContractType = 'Month-to-Month' AND Tenure BETWEEN 12 AND 24
            THEN 2
        ELSE 3
    END;


-- ============================================================
-- BUSINESS QUESTION 7: CTE — Monthly charge bands and churn
-- ============================================================

WITH charge_bands AS (
    SELECT
        CustomerID,
        Churn,
        CASE
            WHEN MonthlyCharges < 40              THEN 'Low (<$40)'
            WHEN MonthlyCharges BETWEEN 40 AND 70 THEN 'Mid ($40–$70)'
            WHEN MonthlyCharges > 70              THEN 'High (>$70)'
        END AS ChargeBand
    FROM customers
)
SELECT
    ChargeBand,
    COUNT(*)                                               AS TotalCustomers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)        AS Churned,
    ROUND(
        100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*), 2
    )                                                      AS ChurnRatePct
FROM charge_bands
GROUP BY ChargeBand
ORDER BY ChurnRatePct DESC;


-- ============================================================
-- BUSINESS QUESTION 8: CTE — Tenure cohorts and churn
-- ============================================================

WITH tenure_cohorts AS (
    SELECT
        CustomerID,
        Churn,
        MonthlyCharges,
        CASE
            WHEN Tenure BETWEEN 1  AND 12 THEN '0–12 months'
            WHEN Tenure BETWEEN 13 AND 24 THEN '13–24 months'
            WHEN Tenure BETWEEN 25 AND 48 THEN '25–48 months'
            ELSE '49+ months'
        END AS TenureCohort
    FROM customers
)
SELECT
    TenureCohort,
    COUNT(*)                                               AS TotalCustomers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)        AS Churned,
    ROUND(
        100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*), 2
    )                                                      AS ChurnRatePct,
    ROUND(AVG(MonthlyCharges), 2)                          AS AvgMonthlyCharges
FROM tenure_cohorts
GROUP BY TenureCohort
ORDER BY ChurnRatePct DESC;


-- ============================================================
-- BUSINESS QUESTION 9: CTE chain — High-risk profile summary
-- ============================================================

WITH flagged AS (
    SELECT
        *,
        CASE
            WHEN ContractType = 'Month-to-Month' AND Tenure < 12 AND MonthlyCharges > 70
                THEN 'High Risk'
            WHEN ContractType = 'Month-to-Month'
                THEN 'Medium Risk'
            ELSE 'Low Risk'
        END AS RiskLevel
    FROM customers
),
summary AS (
    SELECT
        RiskLevel,
        COUNT(*)                                           AS TotalCustomers,
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)    AS Churned,
        ROUND(AVG(MonthlyCharges), 2)                      AS AvgMonthlyCharges,
        ROUND(AVG(Tenure), 1)                              AS AvgTenureMonths
    FROM flagged
    GROUP BY RiskLevel
)
SELECT
    RiskLevel,
    TotalCustomers,
    Churned,
    ROUND(100.0 * Churned / TotalCustomers, 2)             AS ChurnRatePct,
    AvgMonthlyCharges,
    AvgTenureMonths
FROM summary
ORDER BY ChurnRatePct DESC;


-- ============================================================
-- BUSINESS QUESTION 10: Window Function — Rank customers
-- by monthly charges within each contract type
-- ============================================================

SELECT
    CustomerID,
    ContractType,
    MonthlyCharges,
    Churn,
    RANK() OVER (
        PARTITION BY ContractType
        ORDER BY MonthlyCharges DESC
    )                                                      AS ChargeRankInContract
FROM customers
ORDER BY ContractType, ChargeRankInContract;


-- ============================================================
-- BUSINESS QUESTION 11: Tech support vs churn (CASE + GROUP BY)
-- ============================================================

SELECT
    TechSupport,
    COUNT(*)                                               AS TotalCustomers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)        AS Churned,
    ROUND(
        100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*), 2
    )                                                      AS ChurnRatePct,
    ROUND(AVG(MonthlyCharges), 2)                          AS AvgMonthlyCharges
FROM customers
GROUP BY TechSupport
ORDER BY ChurnRatePct DESC;


-- ============================================================
-- BUSINESS QUESTION 12: Revenue at risk from likely churners
-- ============================================================

WITH at_risk AS (
    SELECT
        CustomerID,
        MonthlyCharges,
        ContractType,
        Churn
    FROM customers
    WHERE ContractType = 'Month-to-Month'
      AND Tenure < 12
)
SELECT
    COUNT(*)                                               AS AtRiskCustomers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)        AS AlreadyChurned,
    ROUND(SUM(MonthlyCharges), 2)                          AS TotalMonthlyRevenueAtRisk,
    ROUND(SUM(MonthlyCharges) * 12, 2)                     AS AnnualisedRevenueAtRisk
FROM at_risk;
