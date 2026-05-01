-- ===============================
-- Business KPIs
-- ===============================

-- Total Revenue
SELECT SUM(Revenue) AS Total_Revenue 
FROM Fact_Sales;

-- Total Profit
SELECT SUM(Profit) AS Total_Profit 
FROM Fact_Sales;

-- Total Orders (Total Units Sold)
SELECT SUM(Order_Quantity) AS Total_Orders 
FROM Fact_Sales;

-- Average Order Value (Revenue per Unit)
SELECT 
SUM(Revenue) * 1.0 / SUM(Order_Quantity) AS Average_Order_Value 
FROM Fact_Sales;

-- Total Customers
SELECT COUNT(CustomerID) AS Total_Customers 
FROM Customer;


-- ===============================
-- Time Analysis
-- ===============================

-- Monthly Revenue
SELECT 
d.Month,
SUM(f.Revenue) AS Total_Revenue
FROM Fact_Sales f
JOIN Date d ON f.DateID = d.DateID
GROUP BY d.Month
ORDER BY d.Month;

-- Monthly Profit
SELECT 
d.Month,
SUM(f.Profit) AS Total_Profit
FROM Fact_Sales f
JOIN Date d ON f.DateID = d.DateID
GROUP BY d.Month
ORDER BY d.Month;

-- Running Total Revenue
SELECT
d.Month,
SUM(f.Revenue) AS Monthly_Revenue,
SUM(SUM(f.Revenue)) OVER (ORDER BY d.Month) AS Running_Revenue
FROM Fact_Sales f
JOIN Date d ON f.DateID = d.DateID
GROUP BY d.Month
ORDER BY d.Month;

-- Best Performing Month
WITH mon_rev AS (
SELECT
d.Month,
SUM(f.Revenue) AS Monthly_Revenue
FROM Fact_Sales f
JOIN Date d ON f.DateID = d.DateID
GROUP BY d.Month
)
SELECT *,
DENSE_RANK() OVER (ORDER BY Monthly_Revenue DESC) AS Rank
FROM mon_rev;


-- ===============================
-- Product Analysis
-- ===============================

-- Top 10 Products by Revenue
SELECT TOP 10
p.Product,
SUM(f.Revenue) AS Total_Revenue
FROM Fact_Sales f
JOIN Product p ON p.ProductID = f.ProductID
GROUP BY p.Product
ORDER BY Total_Revenue DESC;

-- Most Profitable Products
SELECT TOP 10
p.Product,
SUM(f.Profit) AS Total_Profit
FROM Fact_Sales f
JOIN Product p ON p.ProductID = f.ProductID
GROUP BY p.Product
ORDER BY Total_Profit DESC;

-- Category-wise Revenue
SELECT 
p.Product_Category,
SUM(f.Revenue) AS Total_Revenue
FROM Fact_Sales f
JOIN Product p ON p.ProductID = f.ProductID
GROUP BY p.Product_Category
ORDER BY Total_Revenue DESC;

-- Category-wise Profit Margin
SELECT  
p.Product_Category,
SUM(f.Profit) * 100.0 / SUM(f.Revenue) AS Profit_Margin
FROM Fact_Sales f 
JOIN Product p ON p.ProductID = f.ProductID
GROUP BY p.Product_Category
ORDER BY Profit_Margin DESC;

-- Revenue Contribution %
SELECT
p.Product_Category,
SUM(f.Revenue) AS Category_Revenue,
SUM(f.Revenue) * 100.0 / SUM(SUM(f.Revenue)) OVER() AS Revenue_Percentage
FROM Fact_Sales f
JOIN Product p ON p.ProductID = f.ProductID
GROUP BY p.Product_Category
ORDER BY Category_Revenue DESC;

-- Top Product Per Category
WITH Product_Sales AS (
SELECT 
p.Product,
p.Product_Category,
SUM(f.Revenue) AS Total_Revenue
FROM Product p
JOIN Fact_Sales f ON f.ProductID = p.ProductID
GROUP BY p.Product_Category, p.Product
)
SELECT *
FROM (
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY Product_Category
ORDER BY Total_Revenue DESC
) AS Rank
FROM Product_Sales
) t
WHERE Rank = 1;


-- ===============================
-- Demographic Analysis
-- ===============================

-- Revenue by Age Group
SELECT 
c.Age_Group,
SUM(f.Revenue) AS Total_Revenue
FROM Fact_Sales f 
JOIN Customer c ON c.CustomerID = f.CustomerID
GROUP BY c.Age_Group
ORDER BY Total_Revenue DESC;

-- Revenue by Gender
SELECT 
c.Customer_Gender,
SUM(f.Revenue) AS Total_Revenue
FROM Fact_Sales f 
JOIN Customer c ON c.CustomerID = f.CustomerID
GROUP BY c.Customer_Gender
ORDER BY Total_Revenue DESC;

-- Most Profitable Age Group
SELECT 
c.Age_Group,
SUM(f.Profit) AS Total_Profit
FROM Fact_Sales f 
JOIN Customer c ON c.CustomerID = f.CustomerID
GROUP BY c.Age_Group
ORDER BY Total_Profit DESC;

-- Profit by Gender
SELECT 
c.Customer_Gender,
SUM(f.Profit) AS Total_Profit
FROM Fact_Sales f 
JOIN Customer c ON c.CustomerID = f.CustomerID
GROUP BY c.Customer_Gender
ORDER BY Total_Profit DESC;

-- Age Group Product Preference
WITH age_product_sales AS (
SELECT 
c.Age_Group,
p.Product,
SUM(f.Order_Quantity) AS Total_Orders
FROM Product p
JOIN Fact_Sales f ON p.ProductID = f.ProductID
JOIN Customer c ON f.CustomerID = c.CustomerID
GROUP BY c.Age_Group, p.Product
)
SELECT *
FROM (
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY Age_Group 
ORDER BY Total_Orders DESC
) AS Rank
FROM age_product_sales
) t
WHERE Rank = 1;

-- Customer Demographic Profitability
SELECT 
c.Age_Group,
c.Customer_Gender,
SUM(f.Profit) AS Total_Profit
FROM Customer c
JOIN Fact_Sales f ON f.CustomerID = c.CustomerID
GROUP BY c.Age_Group, c.Customer_Gender
ORDER BY Total_Profit DESC;


-- ===============================
-- Regional Analysis
-- ===============================

-- Top 5 States by Revenue
WITH state_sales AS (
SELECT
l.State,
SUM(f.Revenue) AS Total_Revenue
FROM Fact_Sales f
JOIN Location l ON f.LocationID = l.LocationID
GROUP BY l.State
)
SELECT *
FROM (
SELECT *,
RANK() OVER(ORDER BY Total_Revenue DESC) AS Rank
FROM state_sales
) t
WHERE Rank <= 5;

-- Revenue by Region
SELECT 
l.State,
SUM(f.Revenue) AS Total_Revenue
FROM Fact_Sales f
JOIN Location l ON l.LocationID = f.LocationID
GROUP BY l.State
ORDER BY Total_Revenue DESC;

-- Profit by Country
SELECT 
l.Country,
SUM(f.Profit) AS Total_Profit
FROM Fact_Sales f
JOIN Location l ON l.LocationID = f.LocationID
GROUP BY l.Country
ORDER BY Total_Profit DESC;