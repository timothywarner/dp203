
-- Queries for Demonstrating Various T-SQL Features

-- Total sales amount by product
SELECT
    p.ProductName,
    SUM(s.Quantity * p.Price) AS TotalSales
FROM
    Sales s
JOIN
    Products p ON s.ProductID = p.ProductID
GROUP BY
    p.ProductName;

-- Running total of sales over time
SELECT
    SaleDate,
    ProductID,
    Quantity,
    SUM(Quantity) OVER (ORDER BY SaleDate) AS RunningTotal
FROM
    Sales;

-- CTE for customers in New York
WITH NewYorkCustomers AS (
    SELECT
        CustomerID,
        CustomerName
    FROM
        Customers
    WHERE
        Location = 'New York'
)
SELECT
    n.CustomerName,
    s.SaleDate,
    s.Quantity
FROM
    Sales s
JOIN
    NewYorkCustomers n ON s.CustomerID = n.CustomerID;

-- Products with sales above average price
SELECT
    ProductName
FROM
    Products
WHERE
    Price > (SELECT AVG(Price) FROM Products);

-- Sales details with customer and product information
SELECT
    s.SaleID,
    c.CustomerName,
    p.ProductName,
    s.Quantity,
    s.SaleDate
FROM
    Sales s
JOIN
    Customers c ON s.CustomerID = c.CustomerID
JOIN
    Products p ON s.ProductID = p.ProductID;

-- Pivot table showing quantity sold by product for each month
SELECT
    ProductName,
    [1] AS Jan,
    [2] AS Feb,
    [3] AS Mar
FROM
    (
        SELECT
            p.ProductName,
            MONTH(s.SaleDate) AS SaleMonth,
            s.Quantity
        FROM
            Sales s
        JOIN
            Products p ON s.ProductID = p.ProductID
    ) AS SourceTable
PIVOT
    (
        SUM(Quantity)
        FOR SaleMonth IN ([1], [2], [3])
    ) AS PivotTable;

-- Rank sales by quantity for each product
SELECT
    ProductID,
    SaleDate,
    Quantity,
    RANK() OVER (PARTITION BY ProductID ORDER BY Quantity DESC) AS SaleRank
FROM
    Sales;
