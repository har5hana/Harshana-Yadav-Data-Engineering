CREATE TABLE customers
(
    Customer_ID NVARCHAR(50) PRIMARY KEY,
    Customer_Name NVARCHAR(100),
    Segment NVARCHAR(50)
);

CREATE TABLE products
(
    Product_ID NVARCHAR(50) PRIMARY KEY,
    Category NVARCHAR(100),
    Sub_Category NVARCHAR(100),
    Product_Name NVARCHAR(300)
);

CREATE TABLE orders
(
    Row_ID SMALLINT PRIMARY KEY,
    Order_ID NVARCHAR(50),
    Order_Date DATE,
    Ship_Date DATE,
    Ship_Mode NVARCHAR(50),
    Customer_ID NVARCHAR(50),
    Country NVARCHAR(50),
    City NVARCHAR(50),
    State NVARCHAR(50),
    Postal_Code INT,
    Region NVARCHAR(50),
    Product_ID NVARCHAR(50),
    Sales FLOAT,
    Quantity TINYINT,
    Discount FLOAT,
    Profit FLOAT
);

INSERT INTO customers
SELECT
    Customer_ID,
    MAX(Customer_Name),
    MAX(Segment)
FROM superstore_raw
GROUP BY Customer_ID;

INSERT INTO products
SELECT
    Product_ID,
    MAX(Category),
    MAX(Sub_Category),
    MAX(Product_Name)
FROM superstore_raw
GROUP BY Product_ID;

INSERT INTO orders
SELECT
    Row_ID,
    Order_ID,
    Order_Date,
    Ship_Date,
    Ship_Mode,
    Customer_ID,
    Country,
    City,
    State,
    Postal_Code,
    Region,
    Product_ID,
    Sales,
    Quantity,
    Discount,
    Profit
FROM superstore_raw;

SELECT COUNT(*) AS RawRows
FROM superstore_raw;

SELECT COUNT(*) AS CustomerCount
FROM customers;

SELECT COUNT(*) AS ProductCount
FROM products;

SELECT COUNT(*) AS OrderCount
FROM orders;

SELECT *
FROM orders
WHERE Sales >
(
    SELECT AVG(Sales)
    FROM orders
);

SELECT
    c.Customer_Name,
    o.Order_ID,
    o.Sales
FROM orders o
JOIN customers c
    ON o.Customer_ID = c.Customer_ID
WHERE o.Sales =
(
    SELECT MAX(o2.Sales)
    FROM orders o2
    WHERE o2.Customer_ID = o.Customer_ID
)
ORDER BY c.Customer_Name;

WITH CustomerSales AS
(
    SELECT
        Customer_ID,
        SUM(Sales) AS Total_Sales
    FROM orders
    GROUP BY Customer_ID
)
SELECT *
FROM CustomerSales
ORDER BY Total_Sales DESC;

WITH CustomerSales AS
(
    SELECT
        Customer_ID,
        SUM(Sales) AS Total_Sales
    FROM orders
    GROUP BY Customer_ID
)

SELECT *
FROM CustomerSales
WHERE Total_Sales >
(
    SELECT AVG(Total_Sales)
    FROM CustomerSales
)
ORDER BY Total_Sales DESC;

WITH CustomerSales AS
(
    SELECT
        Customer_ID,
        SUM(Sales) AS Total_Sales
    FROM orders
    GROUP BY Customer_ID
)

SELECT
    Customer_ID,
    Total_Sales,
    RANK() OVER
    (
        ORDER BY Total_Sales DESC
    ) AS Sales_Rank
FROM CustomerSales;

SELECT
    Customer_ID,
    Order_ID,
    Sales,

    ROW_NUMBER() OVER
    (
        PARTITION BY Customer_ID
        ORDER BY Sales DESC
    ) AS Row_Num

FROM orders;

WITH CustomerSales AS
(
    SELECT
        Customer_ID,
        SUM(Sales) AS Total_Sales
    FROM orders
    GROUP BY Customer_ID
),

RankedCustomers AS
(
    SELECT
        Customer_ID,
        Total_Sales,

        RANK() OVER
        (
            ORDER BY Total_Sales DESC
        ) AS Sales_Rank

    FROM CustomerSales
)

SELECT *
FROM RankedCustomers
WHERE Sales_Rank <= 3;

WITH CustomerSales AS
(
    SELECT
        Customer_ID,
        SUM(Sales) AS Total_Sales
    FROM orders
    GROUP BY Customer_ID
)

SELECT
    c.Customer_Name,
    cs.Total_Sales,

    RANK() OVER
    (
        ORDER BY cs.Total_Sales DESC
    ) AS Customer_Rank

FROM CustomerSales cs
JOIN customers c
    ON cs.Customer_ID = c.Customer_ID

ORDER BY Customer_Rank;

WITH CustomerSales AS
(
    SELECT
        Customer_ID,
        SUM(Sales) AS Total_Sales
    FROM orders
    GROUP BY Customer_ID
)

SELECT TOP 5
    c.Customer_Name,
    cs.Total_Sales
FROM CustomerSales cs
JOIN customers c
    ON cs.Customer_ID = c.Customer_ID
ORDER BY cs.Total_Sales DESC;

WITH CustomerSales AS
(
    SELECT
        Customer_ID,
        SUM(Sales) AS Total_Sales
    FROM orders
    GROUP BY Customer_ID
)

SELECT TOP 5
    c.Customer_Name,
    cs.Total_Sales
FROM CustomerSales cs
JOIN customers c
    ON cs.Customer_ID = c.Customer_ID
ORDER BY cs.Total_Sales ASC;

SELECT
    c.Customer_Name,
    COUNT(DISTINCT o.Order_ID) AS Total_Orders
FROM customers c
JOIN orders o
    ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_Name
HAVING COUNT(DISTINCT o.Order_ID) = 1;

WITH CustomerSales AS
(
    SELECT
        Customer_ID,
        SUM(Sales) AS Total_Sales
    FROM orders
    GROUP BY Customer_ID
)

SELECT
    c.Customer_Name,
    cs.Total_Sales
FROM CustomerSales cs
JOIN customers c
    ON cs.Customer_ID = c.Customer_ID
WHERE cs.Total_Sales >
(
    SELECT AVG(Total_Sales)
    FROM CustomerSales
)
ORDER BY cs.Total_Sales DESC;

SELECT
    c.Customer_Name,
    MAX(o.Sales) AS Highest_Order_Value
FROM customers c
JOIN orders o
    ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_Name
ORDER BY Highest_Order_Value DESC;