-- ============================================================
-- EXECUTIVE KPI DASHBOARD — SQL ANALYSIS
-- Dataset: 36 months of business metrics | 2022–2024
-- ============================================================


-- ============================================================
-- BUSINESS QUESTION 1: Full executive summary by year
-- ============================================================

SELECT
    Year,
    ROUND(SUM(Revenue), 2)                                   AS TotalRevenue,
    ROUND(SUM(GrossProfit), 2)                               AS TotalGrossProfit,
    ROUND(SUM(NetProfit), 2)                                 AS TotalNetProfit,
    ROUND(100.0 * SUM(GrossProfit) / SUM(Revenue), 2)        AS GrossMarginPct,
    ROUND(100.0 * SUM(NetProfit) / SUM(Revenue), 2)          AS NetMarginPct,
    SUM(NewCustomers)                                        AS NewCustomers,
    ROUND(AVG(ActiveCustomers), 0)                           AS AvgActiveCustomers,
    ROUND(SUM(MarketingSpend), 2)                            AS TotalMarketingSpend
FROM kpi_monthly
GROUP BY Year
ORDER BY Year;


-- ============================================================
-- BUSINESS QUESTION 2: Year-over-Year revenue growth (LAG)
-- ============================================================

WITH yearly AS (
    SELECT
        Year,
        ROUND(SUM(Revenue), 2) AS AnnualRevenue
    FROM kpi_monthly
    GROUP BY Year
)
SELECT
    Year,
    AnnualRevenue,
    LAG(AnnualRevenue) OVER (ORDER BY Year)                  AS PrevYearRevenue,
    ROUND(
        100.0 * (AnnualRevenue - LAG(AnnualRevenue) OVER (ORDER BY Year))
              / LAG(AnnualRevenue) OVER (ORDER BY Year),
    2)                                                       AS YoY_GrowthPct
FROM yearly
ORDER BY Year;


-- ============================================================
-- BUSINESS QUESTION 3: Monthly revenue trend with MoM growth
-- ============================================================

WITH monthly_rev AS (
    SELECT
        Month,
        Year,
        MonthNum,
        Revenue
    FROM kpi_monthly
)
SELECT
    Month,
    Revenue,
    LAG(Revenue) OVER (ORDER BY Month)                       AS PrevMonthRevenue,
    ROUND(
        100.0 * (Revenue - LAG(Revenue) OVER (ORDER BY Month))
              / LAG(Revenue) OVER (ORDER BY Month),
    2)                                                       AS MoM_GrowthPct,
    LEAD(Revenue) OVER (ORDER BY Month)                      AS NextMonthRevenue
FROM monthly_rev
ORDER BY Month;


-- ============================================================
-- BUSINESS QUESTION 4: Running total revenue by year
-- ============================================================

SELECT
    Month,
    Year,
    Revenue,
    ROUND(SUM(Revenue) OVER (
        PARTITION BY Year
        ORDER BY Month
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ), 2)                                                    AS YTD_Revenue,
    ROUND(SUM(NetProfit) OVER (
        PARTITION BY Year
        ORDER BY Month
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ), 2)                                                    AS YTD_NetProfit
FROM kpi_monthly
ORDER BY Month;


-- ============================================================
-- BUSINESS QUESTION 5: Same-month comparison across years
-- (Jan 2022 vs Jan 2023 vs Jan 2024, etc.)
-- ============================================================

SELECT
    MonthNum,
    MAX(CASE WHEN Year = 2022 THEN Revenue END)              AS Revenue_2022,
    MAX(CASE WHEN Year = 2023 THEN Revenue END)              AS Revenue_2023,
    MAX(CASE WHEN Year = 2024 THEN Revenue END)              AS Revenue_2024,
    ROUND(
        100.0 * (MAX(CASE WHEN Year = 2024 THEN Revenue END)
               - MAX(CASE WHEN Year = 2023 THEN Revenue END))
              / MAX(CASE WHEN Year = 2023 THEN Revenue END),
    2)                                                       AS YoY_2024_vs_2023_Pct
FROM kpi_monthly
GROUP BY MonthNum
ORDER BY MonthNum;


-- ============================================================
-- BUSINESS QUESTION 6: Profitability trend (CTE)
-- ============================================================

WITH profitability AS (
    SELECT
        Month,
        Year,
        Revenue,
        GrossProfit,
        NetProfit,
        ROUND(100.0 * GrossProfit / Revenue, 2)              AS GrossMarginPct,
        ROUND(100.0 * NetProfit   / Revenue, 2)              AS NetMarginPct
    FROM kpi_monthly
)
SELECT
    Month,
    Year,
    Revenue,
    GrossMarginPct,
    NetMarginPct,
    AVG(NetMarginPct) OVER (
        ORDER BY Month
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    )                                                        AS RollingAvg3M_NetMargin
FROM profitability
ORDER BY Month;


-- ============================================================
-- BUSINESS QUESTION 7: Customer growth KPIs with LAG
-- ============================================================

SELECT
    Month,
    Year,
    NewCustomers,
    ActiveCustomers,
    ChurnedCustomers,
    LAG(ActiveCustomers) OVER (ORDER BY Month)               AS PrevMonthActive,
    ActiveCustomers - LAG(ActiveCustomers) OVER (ORDER BY Month)
                                                             AS NetCustomerGrowth,
    ROUND(
        100.0 * ChurnedCustomers / ActiveCustomers,
    2)                                                       AS MonthlyChurnRatePct
FROM kpi_monthly
ORDER BY Month;


-- ============================================================
-- BUSINESS QUESTION 8: Marketing efficiency (CTE + derived)
-- ============================================================

WITH marketing_kpi AS (
    SELECT
        Month,
        Year,
        Revenue,
        NewCustomers,
        MarketingSpend,
        ROUND(MarketingSpend / NULLIF(NewCustomers, 0), 2)   AS CostPerAcquisition,
        ROUND(100.0 * MarketingSpend / Revenue, 2)           AS MarketingAsPctRevenue
    FROM kpi_monthly
)
SELECT
    Month,
    Year,
    NewCustomers,
    MarketingSpend,
    CostPerAcquisition,
    MarketingAsPctRevenue,
    AVG(CostPerAcquisition) OVER (
        PARTITION BY Year
    )                                                        AS YearlyAvgCPA
FROM marketing_kpi
ORDER BY Month;


-- ============================================================
-- BUSINESS QUESTION 9: Quarterly rollup with CASE
-- ============================================================

SELECT
    Year,
    CASE
        WHEN MonthNum BETWEEN 1 AND 3  THEN 'Q1'
        WHEN MonthNum BETWEEN 4 AND 6  THEN 'Q2'
        WHEN MonthNum BETWEEN 7 AND 9  THEN 'Q3'
        ELSE                                'Q4'
    END                                                      AS Quarter,
    ROUND(SUM(Revenue), 2)                                   AS Revenue,
    ROUND(SUM(NetProfit), 2)                                 AS NetProfit,
    ROUND(100.0 * SUM(NetProfit) / SUM(Revenue), 2)          AS NetMarginPct,
    SUM(NewCustomers)                                        AS NewCustomers
FROM kpi_monthly
GROUP BY Year,
    CASE
        WHEN MonthNum BETWEEN 1 AND 3  THEN 'Q1'
        WHEN MonthNum BETWEEN 4 AND 6  THEN 'Q2'
        WHEN MonthNum BETWEEN 7 AND 9  THEN 'Q3'
        ELSE                                'Q4'
    END
ORDER BY Year, Quarter;


-- ============================================================
-- BUSINESS QUESTION 10: Best and worst months (Subquery)
-- ============================================================

SELECT
    'Best Month'                                             AS Label,
    Month, Year, Revenue
FROM kpi_monthly
WHERE Revenue = (SELECT MAX(Revenue) FROM kpi_monthly)

UNION ALL

SELECT
    'Worst Month',
    Month, Year, Revenue
FROM kpi_monthly
WHERE Revenue = (SELECT MIN(Revenue) FROM kpi_monthly);


-- ============================================================
-- BUSINESS QUESTION 11: 3-month rolling average revenue
-- (smooths seasonality for the board)
-- ============================================================

SELECT
    Month,
    Year,
    Revenue,
    ROUND(AVG(Revenue) OVER (
        ORDER BY Month
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ), 2)                                                    AS RollingAvg3M_Revenue,
    ROUND(AVG(Revenue) OVER (
        ORDER BY Month
        ROWS BETWEEN 5 PRECEDING AND CURRENT ROW
    ), 2)                                                    AS RollingAvg6M_Revenue
FROM kpi_monthly
ORDER BY Month;


-- ============================================================
-- BUSINESS QUESTION 12: Chained CTEs — Full executive scorecard
-- ============================================================

WITH revenue_base AS (
    SELECT
        Year,
        ROUND(SUM(Revenue), 2)          AS AnnualRevenue,
        ROUND(SUM(NetProfit), 2)        AS AnnualNetProfit,
        SUM(NewCustomers)               AS TotalNewCustomers,
        ROUND(AVG(ActiveCustomers), 0)  AS AvgActiveCustomers,
        ROUND(SUM(MarketingSpend), 2)   AS TotalMarketingSpend
    FROM kpi_monthly
    GROUP BY Year
),
growth_calc AS (
    SELECT
        Year,
        AnnualRevenue,
        AnnualNetProfit,
        TotalNewCustomers,
        AvgActiveCustomers,
        TotalMarketingSpend,
        LAG(AnnualRevenue)    OVER (ORDER BY Year) AS PrevRevenue,
        LAG(AnnualNetProfit)  OVER (ORDER BY Year) AS PrevNetProfit
    FROM revenue_base
)
SELECT
    Year,
    AnnualRevenue,
    AnnualNetProfit,
    ROUND(100.0 * AnnualNetProfit / AnnualRevenue, 2)        AS NetMarginPct,
    ROUND(
        100.0 * (AnnualRevenue - PrevRevenue) / PrevRevenue,
    2)                                                       AS RevenueGrowthYoY_Pct,
    ROUND(
        100.0 * (AnnualNetProfit - PrevNetProfit) / PrevNetProfit,
    2)                                                       AS ProfitGrowthYoY_Pct,
    TotalNewCustomers,
    AvgActiveCustomers,
    ROUND(TotalMarketingSpend / NULLIF(TotalNewCustomers, 0), 2) AS CostPerAcquisition
FROM growth_calc
ORDER BY Year;
