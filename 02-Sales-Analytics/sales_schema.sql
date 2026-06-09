CREATE TABLE sales (
    OrderID          INT PRIMARY KEY,
    OrderDate        DATE,
    CustomerID       VARCHAR(20),
    CustomerSegment  VARCHAR(20),   -- Enterprise, SMB, Retail
    Product          VARCHAR(100),
    Category         VARCHAR(50),
    Region           VARCHAR(20),
    Quantity         INT,
    UnitPrice        DECIMAL(10,2),
    UnitCost         DECIMAL(10,2),
    Revenue          DECIMAL(10,2),
    Profit           DECIMAL(10,2)
);
