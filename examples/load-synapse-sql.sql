-- Drop existing tables if they exist
DROP TABLE IF EXISTS Sales;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Products;

-- Create Products Table with ROUND_ROBIN distribution
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(100),
    Price DECIMAL(10,2)
)
WITH
(
    DISTRIBUTION = ROUND_ROBIN
);

-- Create Customers Table with HASH distribution
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName NVARCHAR(100),
    Location NVARCHAR(100)
)
WITH
(
    DISTRIBUTION = HASH(CustomerID)
);

-- Create Sales Table with date partitioning
CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    CustomerID INT,
    Quantity INT,
    SaleDate DATE
)
WITH
(
    DISTRIBUTION = ROUND_ROBIN,
    PARTITION(SaleDate RANGE RIGHT FOR VALUES ('2024-01-01', '2024-02-01', '2024-03-01', '2024-04-01'))
);

-- Foreign key relationships can be created as needed

-- Insert more sample data into Products
INSERT INTO Products (ProductID, ProductName, Price) VALUES
(1, 'Laptop', 1200.00),
(2, 'Phone', 800.00),
(3, 'Tablet', 600.00),
(4, 'Monitor', 300.00),
(5, 'Keyboard', 100.00);

-- Insert more sample data into Customers
INSERT INTO Customers (CustomerID, CustomerName, Location) VALUES
(1, 'Alice', 'New York'),
(2, 'Bob', 'Los Angeles'),
(3, 'Charlie', 'Chicago'),
(4, 'David', 'Miami'),
(5, 'Eve', 'Seattle');

-- Insert more sample data into Sales
INSERT INTO Sales (SaleID, ProductID, CustomerID, Quantity, SaleDate) VALUES
(1, 1, 1, 2, '2024-01-10'),
(2, 2, 2, 1, '2024-01-11'),
(3, 3, 3, 1, '2024-01-12'),
(4, 4, 4, 3, '2024-01-13'),
(5, 5, 5, 2, '2024-01-14'),
(6, 1, 2, 1, '2024-02-05'),
(7, 2, 3, 2, '2024-02-06'),
(8, 3, 4, 1, '2024-03-07'),
(9, 4, 5, 3, '2024-03-08'),
(10, 5, 1, 2, '2024-04-09');
