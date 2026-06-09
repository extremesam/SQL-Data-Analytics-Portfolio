-- ============================================================
-- SALES ANALYTICS — SQL ANALYSIS
-- Dataset: 970 orders | Full Year 2024
-- ============================================================


-- ============================================================
-- BUSINESS QUESTION 1: What is the overall sales performance?
-- ============================================================

SELECT
    COUNT(DISTINCT OrderID)                        AS TotalOrders,
    COUNT(DISTINCT CustomerID)                     AS UniqueCustomers,
    ROUND(SUM(Revenue), 2)                         AS TotalRevenue,
    ROUND(SUM(Profit), 2)                          AS TotalProfit,
    ROUND(100.0 * SUM(Profit) / SUM(Revenue), 2)  AS ProfitMarginPct
FROM sales;


-- ============================================================
-- BUSINESS QUESTION 2: What is the monthly revenue trend?
-- ============================================================

SELECT
    DATE_FORMAT(OrderDate, '%Y-%m')               AS Month,
    COUNT(DISTINCT OrderID)                        AS Orders,
    ROUND(SUM(Revenue), 2)                         AS MonthlyRevenue,
    ROUND(SUM(Profit), 2)                          AS MonthlyProfit,
    ROUND(100.0 * SUM(Profit) / SUM(Revenue), 2)  AS MarginPct
FROM sales
GROUP BY DATE_FORMAT(OrderDate, '%Y-%m')
ORDER BY Month;

-- Note: Use STRFTIME('%Y-%m', OrderDate) in SQLite


-- ============================================================
-- BUSINESS QUESTION 3: Which products generate the most revenue?
-- ============================================================

SELECT
    Product,
    Category,
    COUNT(OrderID)                                 AS OrderCount,
    SUM(Quantity)                                  AS UnitsSold,
    ROUND(SUM(Revenue), 2)                         AS TotalRevenue,
    ROUND(SUM(Profit), 2)                          AS TotalProfit,
    ROUND(100.0 * SUM(Profit) / SUM(Revenue), 2)  AS MarginPct
FROM sales
GROUP BY Product, Category
ORDER BY TotalRevenue DESC;


-- ============================================================
-- BUSINESS QUESTION 4: Which region performs best?
-- ============================================================

SELECT
    Region,
    COUNT(DISTINCT CustomerID)                     AS Customers,
    COUNT(OrderID)                                 AS Orders,
    ROUND(SUM(Revenue), 2)                         AS TotalRevenue,
    ROUND(AVG(Revenue), 2)                         AS AvgOrderValue,
    ROUND(100.0 * SUM(Profit) / SUM(Revenue), 2)  AS MarginPct
FROM sales
GROUP BY Region
ORDER BY TotalRevenue DESC;


-- ============================================================
-- BUSINESS QUESTION 5: What is the profit margin by category?
-- ============================================================

SELECT
    Category,
    ROUND(SUM(Revenue), 2)                         AS TotalRevenue,
    ROUND(SUM(Profit), 2)                          AS TotalProfit,
    ROUND(100.0 * SUM(Profit) / SUM(Revenue), 2)  AS MarginPct,
    ROUND(AVG(UnitPrice), 2)                       AS AvgUnitPrice
FROM sales
GROUP BY Category
ORDER BY MarginPct DESC;


-- ============================================================
-- BUSINESS QUESTION 6: How do customer segments compare?
-- ============================================================

SELECT
    CustomerSegment,
    COUNT(DISTINCT CustomerID)                     AS Customers,
    COUNT(OrderID)                                 AS Orders,
    ROUND(SUM(Revenue), 2)                         AS TotalRevenue,
    ROUND(AVG(Revenue), 2)                         AS AvgOrderValue,
    ROUND(SUM(Revenue) / COUNT(DISTINCT CustomerID), 2) AS RevenuePerCustomer
FROM sales
GROUP BY CustomerSegment
ORDER BY TotalRevenue DESC;


-- ============================================================
-- BUSINESS QUESTION 7: Window Function — Revenue rank by region
-- ============================================================

SELECT
    Region,
    Product,
    ROUND(SUM(Revenue), 2)                         AS ProductRevenue,
    RANK() OVER (
        PARTITION BY Region
        ORDER BY SUM(Revenue) DESC
    )                                              AS RevenueRankInRegion
FROM sales
GROUP BY Region, Product
ORDER BY Region, RevenueRankInRegion;


-- ============================================================
-- BUSINESS QUESTION 8: Running total of monthly revenue (Window)
-- ============================================================

SELECT
    Month,
    MonthlyRevenue,
    ROUND(SUM(MonthlyRevenue) OVER (
        ORDER BY Month
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ), 2)                                          AS RunningTotal
FROM (
    SELECT
        DATE_FORMAT(OrderDate, '%Y-%m')            AS Month,
        ROUND(SUM(Revenue), 2)                     AS MonthlyRevenue
    FROM sales
    GROUP BY DATE_FORMAT(OrderDate, '%Y-%m')
) monthly_summary
ORDER BY Month;

-- Note: Use STRFTIME('%Y-%m', OrderDate) in SQLite


-- ============================================================
-- BUSINESS QUESTION 9: Month-over-Month revenue growth (LAG)
-- ============================================================

WITH monthly AS (
    SELECT
        DATE_FORMAT(OrderDate, '%Y-%m')            AS Month,
        ROUND(SUM(Revenue), 2)                     AS MonthlyRevenue
    FROM sales
    GROUP BY DATE_FORMAT(OrderDate, '%Y-%m')
)
SELECT
    Month,
    MonthlyRevenue,
    LAG(MonthlyRevenue) OVER (ORDER BY Month)      AS PrevMonthRevenue,
    ROUND(
        100.0 * (MonthlyRevenue - LAG(MonthlyRevenue) OVER (ORDER BY Month))
              / LAG(MonthlyRevenue) OVER (ORDER BY Month),
    2)                                             AS MoM_GrowthPct
FROM monthly
ORDER BY Month;

-- Note: Use STRFTIME('%Y-%m', OrderDate) in SQLite


-- ============================================================
-- BUSINESS QUESTION 10: Top customers by revenue (CTE)
-- ============================================================

WITH customer_summary AS (
    SELECT
        CustomerID,
        CustomerSegment,
        COUNT(OrderID)                             AS Orders,
        ROUND(SUM(Revenue), 2)                     AS TotalRevenue,
        ROUND(SUM(Profit), 2)                      AS TotalProfit,
        ROUND(AVG(Revenue), 2)                     AS AvgOrderValue
    FROM sales
    GROUP BY CustomerID, CustomerSegment
)
SELECT
    CustomerID,
    CustomerSegment,
    Orders,
    TotalRevenue,
    TotalProfit,
    AvgOrderValue,
    RANK() OVER (ORDER BY TotalRevenue DESC)       AS RevenueRank
FROM customer_summary
ORDER BY RevenueRank
LIMIT 15;


-- ============================================================
-- BUSINESS QUESTION 11: HAVING — Categories above revenue threshold
-- ============================================================

SELECT
    Category,
    COUNT(OrderID)                                 AS Orders,
    ROUND(SUM(Revenue), 2)                         AS TotalRevenue
FROM sales
GROUP BY Category
HAVING SUM(Revenue) > 50000
ORDER BY TotalRevenue DESC;
