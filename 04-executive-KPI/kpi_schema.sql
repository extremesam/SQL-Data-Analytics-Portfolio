CREATE TABLE kpi_monthly (
    Month               VARCHAR(7)    PRIMARY KEY,  -- e.g. '2024-03'
    Year                INT,
    MonthNum            INT,
    Revenue             DECIMAL(12,2),
    COGS                DECIMAL(12,2),   -- Cost of Goods Sold
    GrossProfit         DECIMAL(12,2),
    OperatingExpenses   DECIMAL(12,2),
    NetProfit           DECIMAL(12,2),
    NewCustomers        INT,
    ActiveCustomers     INT,
    ChurnedCustomers    INT,
    MarketingSpend      DECIMAL(10,2),
    SupportTickets      INT
);
