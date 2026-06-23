USE SuperstoreDB;
GO
SELECT *
FROM Superstore;
SELECT *
FROM Superstore
WHERE Region='West';
SELECT *
FROM Superstore
WHERE Region='East';
SELECT *
FROM Superstore
WHERE Region='South';
SELECT *
FROM Superstore
WHERE Region='Central';
SELECT *
FROM Superstore
WHERE Category='Technology';
SELECT *
FROM Superstore
WHERE Category='Furniture';
SELECT *
FROM Superstore
WHERE Category='Office Supplies';
SELECT *
FROM Superstore
WHERE Segment='Consumer';
SELECT *
FROM Superstore
WHERE Segment='Corporate';
SELECT *
FROM Superstore
WHERE Segment='Home Office';
SELECT *
FROM Superstore
WHERE Sales>100;
SELECT *
FROM Superstore
WHERE Sales>500;
SELECT *
FROM Superstore
WHERE Sales>1000;
SELECT *
FROM Superstore
WHERE Profit>0;
SELECT *
FROM Superstore
WHERE Profit<0;
SELECT *
FROM Superstore
WHERE Discount>0.20;
SELECT *
FROM Superstore
WHERE Quantity>5;
SELECT *
FROM Superstore
WHERE Sales BETWEEN 500 AND 1000;
SELECT *
FROM Superstore
WHERE Profit BETWEEN 100 AND 500;
SELECT *
FROM Superstore
WHERE Region IN ('East','West');
SELECT *
FROM Superstore
WHERE Category IN ('Technology','Furniture');
SELECT *
FROM Superstore
WHERE Category<>'Furniture';
SELECT *
FROM Superstore
WHERE Segment<>'Consumer';
SELECT *
FROM Superstore
WHERE Customer_Name LIKE 'A%';
SELECT *
FROM Superstore
WHERE Product_Name LIKE 'Canon%';
SELECT *
FROM Superstore
WHERE Product_Name LIKE '%Chair%';
SELECT *
FROM Superstore
WHERE Product_Name LIKE '%Set';
SELECT *
FROM Superstore
WHERE YEAR(Order_Date)=2017;
SELECT *
FROM Superstore
WHERE MONTH(Order_Date)=12;
SELECT *
FROM Superstore
WHERE MONTH(Order_Date)=1;
SELECT *
FROM Superstore
WHERE Order_Date BETWEEN '2016-01-01' AND '2016-12-31';
SELECT *
FROM Superstore
WHERE Category='Technology'
AND Sales>1000;
SELECT *
FROM Superstore
WHERE Category='Furniture'
AND Profit>200;
SELECT *
FROM Superstore
WHERE Region='West'
AND Profit<0;
SELECT *
FROM Superstore
WHERE Segment='Consumer'
AND Region='West';
SELECT *
FROM Superstore
WHERE Segment='Corporate'
AND Region='East';
SELECT *
FROM Superstore
WHERE Sales>1000
OR Profit>500;
SELECT *
FROM Superstore
WHERE Discount>0.30
OR Profit<0;
SELECT *
FROM Superstore
WHERE Customer_Name IS NULL;
SELECT *
FROM Superstore
WHERE Product_Name IS NULL;
SELECT *
FROM Superstore
WHERE Customer_Name IS NOT NULL;
SELECT *
FROM Superstore
WHERE Sales>5000;
SELECT *
FROM Superstore
WHERE Sales<10;
SELECT *
FROM Superstore
WHERE Profit=0;
SELECT *
FROM Superstore
WHERE Quantity=10;