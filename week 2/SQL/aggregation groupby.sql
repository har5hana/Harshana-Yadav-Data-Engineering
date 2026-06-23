USE SuperstoreDB;
GO
SELECT
    Category,
    SUM(Sales) AS TotalSales
FROM Superstore
GROUP BY Category;
SELECT
    Category,
    SUM(Profit) AS TotalProfit
FROM Superstore
GROUP BY Category;
SELECT
    Category,
    AVG(Sales) AS AverageSales
FROM Superstore
GROUP BY Category;
SELECT
    Category,
    AVG(Profit) AS AverageProfit
FROM Superstore
GROUP BY Category;
SELECT
    Category,
    SUM(Quantity) AS TotalQuantity
FROM Superstore
GROUP BY Category;
SELECT
    Region,
    SUM(Sales) AS TotalSales
FROM Superstore
GROUP BY Region;
SELECT
    Region,
    SUM(Profit) AS TotalProfit
FROM Superstore
GROUP BY Region;
SELECT
    Region,
    AVG(Sales) AS AverageSales
FROM Superstore
GROUP BY Region;
SELECT
    Segment,
    SUM(Sales) AS TotalSales
FROM Superstore
GROUP BY Segment;
SELECT
    Segment,
    SUM(Profit) AS TotalProfit
FROM Superstore
GROUP BY Segment;
SELECT
    Ship_Mode,
    COUNT(*) AS TotalOrders
FROM Superstore
GROUP BY Ship_Mode;
SELECT
    State,
    SUM(Sales) AS TotalSales
FROM Superstore
GROUP BY State;
SELECT
    State,
    SUM(Profit) AS TotalProfit
FROM Superstore
GROUP BY State;
SELECT
    City,
    SUM(Sales) AS TotalSales
FROM Superstore
GROUP BY City;
SELECT
    Customer_Name,
    SUM(Sales) AS TotalSales
FROM Superstore
GROUP BY Customer_Name;
SELECT
    Customer_Name,
    SUM(Profit) AS TotalProfit
FROM Superstore
GROUP BY Customer_Name;
SELECT
    Product_Name,
    SUM(Sales) AS TotalSales
FROM Superstore
GROUP BY Product_Name;
SELECT
    Product_Name,
    SUM(Profit) AS TotalProfit
FROM Superstore
GROUP BY Product_Name;
SELECT
    Sub_Category,
    SUM(Sales) AS TotalSales
FROM Superstore
GROUP BY Sub_Category;
SELECT
    Sub_Category,
    SUM(Profit) AS TotalProfit
FROM Superstore
GROUP BY Sub_Category;
SELECT
    Category,
    Region,
    SUM(Sales) AS TotalSales
FROM Superstore
GROUP BY Category, Region;
SELECT
    Category,
    Segment,
    SUM(Sales) AS TotalSales
FROM Superstore
GROUP BY Category, Segment;
SELECT
    Region,
    Segment,
    SUM(Profit) AS TotalProfit
FROM Superstore
GROUP BY Region, Segment;
SELECT
    YEAR(Order_Date) AS OrderYear,
    SUM(Sales) AS TotalSales
FROM Superstore
GROUP BY YEAR(Order_Date)
ORDER BY OrderYear;
SELECT
    YEAR(Order_Date) AS OrderYear,
    SUM(Profit) AS TotalProfit
FROM Superstore
GROUP BY YEAR(Order_Date)
ORDER BY OrderYear;
SELECT
    MONTH(Order_Date) AS OrderMonth,
    SUM(Sales) AS TotalSales
FROM Superstore
GROUP BY MONTH(Order_Date)
ORDER BY OrderMonth;
SELECT
    YEAR(Order_Date) AS OrderYear,
    MONTH(Order_Date) AS OrderMonth,
    SUM(Sales) AS TotalSales
FROM Superstore
GROUP BY YEAR(Order_Date), MONTH(Order_Date)
ORDER BY OrderYear, OrderMonth;
SELECT
    Category,
    COUNT(*) AS TotalOrders
FROM Superstore
GROUP BY Category;
SELECT
    Region,
    COUNT(*) AS TotalOrders
FROM Superstore
GROUP BY Region;
SELECT
    Customer_Name,
    COUNT(*) AS OrdersPlaced
FROM Superstore
GROUP BY Customer_Name;
SELECT
    Product_Name,
    COUNT(*) AS TimesOrdered
FROM Superstore
GROUP BY Product_Name;
SELECT
    Category,
    MAX(Sales) AS HighestSale
FROM Superstore
GROUP BY Category;
SELECT
    Category,
    MIN(Sales) AS LowestSale
FROM Superstore
GROUP BY Category;
SELECT
    Region,
    MAX(Profit) AS HighestProfit
FROM Superstore
GROUP BY Region;
SELECT
    Region,
    MIN(Profit) AS LowestProfit
FROM Superstore
GROUP BY Region;
SELECT
    Category,
    SUM(Sales) AS TotalSales
FROM Superstore
GROUP BY Category
HAVING SUM(Sales) > 500000;
SELECT
    Region,
    SUM(Profit) AS TotalProfit
FROM Superstore
GROUP BY Region
HAVING SUM(Profit) > 50000;
SELECT
    Customer_Name,
    SUM(Sales) AS TotalSales
FROM Superstore
GROUP BY Customer_Name
HAVING SUM(Sales) > 10000;
SELECT
    Product_Name,
    SUM(Profit) AS TotalProfit
FROM Superstore
GROUP BY Product_Name
HAVING SUM(Profit) > 1000;
SELECT
    State,
    AVG(Sales) AS AverageSales
FROM Superstore
GROUP BY State
HAVING AVG(Sales) > 500;
SELECT
    Sub_Category,
    AVG(Profit) AS AverageProfit
FROM Superstore
GROUP BY Sub_Category
HAVING AVG(Profit) > 50;