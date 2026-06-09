CREATE TABLE customers (
    CustomerID       VARCHAR(20) PRIMARY KEY,
    Gender           VARCHAR(10),
    Age              INT,
    Tenure           INT,            -- months with the company
    ContractType     VARCHAR(20),    -- Month-to-Month, One Year, Two Year
    PaymentMethod    VARCHAR(30),    -- Credit Card, Bank Transfer, Electronic Check, Mailed Check
    InternetService  VARCHAR(20),    -- Fiber Optic, DSL, No Internet
    MonthlyCharges   DECIMAL(8,2),
    TotalCharges     DECIMAL(10,2),
    NumServices      INT,            -- number of add-on services subscribed
    TechSupport      VARCHAR(5),     -- Yes / No
    OnlineBackup     VARCHAR(5),     -- Yes / No
    Churn            VARCHAR(5)      -- Yes / No
);
