CREATE TABLE Superstore (
Row_ID INT,
Order_ID VARCHAR(30),
Order_Date DATE,
Ship_Date DATE,
Ship_Mode VARCHAR(50),
Customer_ID VARCHAR(30),
Customer_Name VARCHAR(150),
Segment VARCHAR(50),
Country VARCHAR(100),
City VARCHAR(100),
State VARCHAR(100),
Postal_Code INT,
Region VARCHAR(50),
Product_ID VARCHAR(50),
Category VARCHAR(50),
Sub_Category VARCHAR(50),
Product_Name VARCHAR(255),
Sales DECIMAL(10,2),
Quantity INT,
Discount DECIMAL(5,2),
Profit DECIMAL(10,2)
);
select top 10 * from Superstore
DROP TABLE IF EXISTS Superstore;
EXEC sp_help Superstore;
USE SuperstoreDB;
GO

IF OBJECT_ID('dbo.Superstore', 'U') IS NOT NULL
    DROP TABLE dbo.Superstore;
GO
SELECT COUNT(*)

USE SuperstoreDB;
GO
SELECT name
FROM sys.tables;

EXEC sp_rename '[Sample - Superstore]', 'Superstore';
SELECT *
FROM Superstore;
SELECT COUNT(*)
FROM Superstore;
SELECT TOP 20 *
FROM Superstore;
EXEC sp_help 'Superstore';
SELECT
    COLUMN_NAME,
    DATA_TYPE,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Superstore';
SELECT COUNT(*) AS TotalOrders
FROM Superstore;
SELECT COUNT(DISTINCT Customer_ID) AS TotalCustomers
FROM Superstore;
SELECT COUNT(DISTINCT Product_ID) AS TotalProducts
FROM Superstore;
SELECT COUNT(DISTINCT Category) AS Categories
FROM Superstore;
SELECT COUNT(DISTINCT Sub_Category) AS SubCategories
FROM Superstore;
SELECT COUNT(DISTINCT Region) AS Regions
FROM Superstore;
SELECT COUNT(DISTINCT State) AS States
FROM Superstore;
SELECT COUNT(DISTINCT City) AS Cities
FROM Superstore;
SELECT DISTINCT Category
FROM Superstore
ORDER BY Category;
SELECT DISTINCT Sub_Category
FROM Superstore
ORDER BY Sub_Category;
SELECT DISTINCT Region
FROM Superstore
ORDER BY Region;
SELECT DISTINCT Segment
FROM Superstore
ORDER BY Segment;
SELECT DISTINCT Ship_Mode
FROM Superstore
ORDER BY Ship_Mode;
SELECT
    SUM(CASE WHEN Row_ID IS NULL THEN 1 ELSE 0 END) AS Missing_RowID,
    SUM(CASE WHEN Order_ID IS NULL THEN 1 ELSE 0 END) AS Missing_OrderID,
    SUM(CASE WHEN Order_Date IS NULL THEN 1 ELSE 0 END) AS Missing_OrderDate,
    SUM(CASE WHEN Ship_Date IS NULL THEN 1 ELSE 0 END) AS Missing_ShipDate,
    SUM(CASE WHEN Customer_ID IS NULL THEN 1 ELSE 0 END) AS Missing_CustomerID,
    SUM(CASE WHEN Customer_Name IS NULL THEN 1 ELSE 0 END) AS Missing_CustomerName,
    SUM(CASE WHEN Product_ID IS NULL THEN 1 ELSE 0 END) AS Missing_ProductID,
    SUM(CASE WHEN Product_Name IS NULL THEN 1 ELSE 0 END) AS Missing_ProductName,
    SUM(CASE WHEN Sales IS NULL THEN 1 ELSE 0 END) AS Missing_Sales,
    SUM(CASE WHEN Quantity IS NULL THEN 1 ELSE 0 END) AS Missing_Quantity,
    SUM(CASE WHEN Discount IS NULL THEN 1 ELSE 0 END) AS Missing_Discount,
    SUM(CASE WHEN Profit IS NULL THEN 1 ELSE 0 END) AS Missing_Profit
FROM Superstore;
SELECT
    Row_ID,
    COUNT(*) AS DuplicateCount
FROM Superstore
GROUP BY Row_ID
HAVING COUNT(*) > 1;
SELECT
    Order_ID,
    COUNT(*) AS LineItems
FROM Superstore
GROUP BY Order_ID
HAVING COUNT(*) > 1
ORDER BY LineItems DESC;
SELECT
    Product_ID,
    COUNT(*) AS TimesSold
FROM Superstore
GROUP BY Product_ID
ORDER BY TimesSold DESC;
SELECT *
FROM Superstore
WHERE Sales < 0;
SELECT *
FROM Superstore
WHERE Profit < 0;
SELECT *
FROM Superstore
WHERE Quantity <= 0;
SELECT *
FROM Superstore
WHERE Discount < 0
   OR Discount > 1;
   SELECT
    MIN(Order_Date) AS First_Order_Date,
    MAX(Order_Date) AS Last_Order_Date,
    MIN(Ship_Date) AS First_Ship_Date,
    MAX(Ship_Date) AS Last_Ship_Date
FROM Superstore;
SELECT
    SUM(Sales) AS TotalSales,
    AVG(Sales) AS AverageSales,
    MIN(Sales) AS MinimumSale,
    MAX(Sales) AS MaximumSale
FROM Superstore;
SELECT
    SUM(Profit) AS TotalProfit,
    AVG(Profit) AS AverageProfit,
    MIN(Profit) AS MinimumProfit,
    MAX(Profit) AS MaximumProfit
FROM Superstore;
SELECT
    SUM(Quantity) AS TotalQuantity,
    AVG(Quantity) AS AverageQuantity,
    MIN(Quantity) AS MinimumQuantity,
    MAX(Quantity) AS MaximumQuantity
FROM Superstore;
SELECT
    COUNT(*) AS TotalRows,
    COUNT(DISTINCT Order_ID) AS TotalOrders,
    COUNT(DISTINCT Customer_ID) AS TotalCustomers,
    COUNT(DISTINCT Product_ID) AS TotalProducts,
    COUNT(DISTINCT Category) AS Categories,
    COUNT(DISTINCT Sub_Category) AS SubCategories,
    COUNT(DISTINCT Region) AS Regions,
    COUNT(DISTINCT State) AS States,
    COUNT(DISTINCT City) AS Cities
FROM Superstore;