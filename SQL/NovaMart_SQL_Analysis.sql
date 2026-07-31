/*
====================================================
NovaMart Retail Analytics

Author      : Rathnaa K
Database    : NovaMart
Table       : dbo.novamart_sales_dataset

Description :
SQL Business Analysis Project
====================================================
*/

USE NovaMart;
GO

/*============================================================
                    BASIC SQL QUERIES
============================================================*/

-- Display all records

SELECT *
FROM dbo.novamart_sales_dataset;

-- Display first 10 records

SELECT TOP 10 *
FROM dbo.novamart_sales_dataset;

-- Total no of orders

SELECT COUNT(*) AS Total_Orders
FROM dbo.novamart_sales_dataset;

-- Electronics Orders

SELECT * 
FROM dbo.novamart_sales_dataset
WHERE category = 'Electronics';

-- Sales Greater Than ₹50,000

SELECT *
FROM dbo.novamart_sales_dataset
WHERE sales > 50000;

-- Electronics Orders with sales greater than ₹50,000

SELECT *
FROM dbo.novamart_sales_dataset
WHERE category = 'Electronics'
AND sales > 50000;

-- Orders paid using UPI

SELECT *
FROM dbo.novamart_sales_dataset
WHERE payment_method = 'UPI';

-- Orders from Chennai

SELECT *
FROM dbo.novamart_sales_dataset
WHERE city = 'Chennai';

-- Orders sorted by highest sales

SELECT *
FROM dbo.novamart_sales_dataset
ORDER BY sales DESC;

-- Top 10 Highest Sales

SELECT TOP 10 *
FROM dbo.novamart_sales_dataset
ORDER BY sales DESC;

/*============================================================
                 AGGREGATE FUNCTIONS
============================================================*/

-- Total Sales

SELECT SUM(sales) AS Total_Sales
FROM dbo.novamart_sales_dataset;

-- Total Profit

SELECT SUM(profit) AS Total_Profit
FROM dbo.novamart_sales_dataset;

-- Average Sales

SELECT AVG(sales) AS Average_Sales
FROM dbo.novamart_sales_dataset;

-- Highest and Lowest Sales

SELECT
     MAX(sales) AS Highest_Sale,
     MIN(sales) AS Lowest_Sale
FROM dbo.novamart_sales_dataset;

/*============================================================
                GROUP BY BUSINESS ANALYSIS
============================================================*/

-- Total Sales by Category

SELECT 
     category,
     SUM(sales) AS Total_Sales
FROM dbo.novamart_sales_dataset
GROUP BY category
ORDER BY Total_Sales DESC;

-- Total Profit by Category

SELECT 
     category,
     SUM(profit) AS Total_Profit
FROM dbo.novamart_sales_dataset
GROUP BY category
ORDER BY Total_Profit DESC;

-- Total Sales by City

SELECT 
     city,
     SUM(sales) AS Total_Sales
FROM dbo.novamart_sales_dataset
GROUP BY city
ORDER BY Total_Sales DESC;

-- Average Profit by City

SELECT 
     city,
     AVG(profit) AS Average_Profit
FROM dbo.novamart_sales_dataset
GROUP BY city
ORDER BY Average_Profit DESC;

-- Orders by Payment Method

SELECT 
     payment_method,
     COUNT(*) AS Total_Orders
FROM dbo.novamart_sales_dataset
GROUP BY payment_method
ORDER BY Total_Orders DESC;

-- Sales by Salesperson

SELECT 
     salesperson,
     SUM(sales) AS Total_Sales
FROM dbo.novamart_sales_dataset
GROUP BY salesperson
ORDER BY Total_Sales DESC;

/*============================================================
                HAVING CLAUSE & FILTERING
============================================================*/

-- Categories with Sales Above ₹5,000,000

SELECT 
     category,
     SUM(sales) AS Total_Sales
FROM dbo.novamart_sales_dataset
GROUP BY category
HAVING SUM(sales) > 5000000
ORDER BY Total_sales DESC;

-- Cities with More Than 300 Orders

SELECT 
     city,
     COUNT(*) AS Total_Orders
FROM dbo.novamart_sales_dataset
GROUP BY city
HAVING COUNT(*) > 300
ORDER BY Total_Orders DESC;

-- Salespersons with Profit Above ₹1,000,000

SELECT 
     salesperson,
     SUM(profit) AS Total_Profit
FROM dbo.novamart_sales_dataset
GROUP BY salesperson
HAVING SUM(profit) > 1000000
ORDER BY Total_Profit DESC;

-- Categories with Average Sales Above ₹25,000

SELECT 
     category,
     AVG(sales) AS Average_Sales
FROM dbo.novamart_sales_dataset
GROUP BY category
HAVING AVG(sales) > 25000
ORDER BY Average_Sales DESC;

-- States with Total Profit Above ₹500,000

SELECT 
     state,
     SUM(profit) AS Total_Profit
FROM dbo.novamart_sales_dataset
GROUP BY state
HAVING SUM(profit) > 500000
ORDER BY Total_Profit DESC;

/*============================================================
            CASE STATEMENTS & BUSINESS LOGIC
============================================================*/

-- Categorize Sales

SELECT
     order_id,
     sales,
     CASE 
         WHEN sales >= 50000 THEN 'High Sales'
         WHEN sales >= 25000 THEN 'Medium Sales'
         ELSE 'Low Sales'
    END AS Sales_Category
FROM dbo.novamart_sales_dataset;

-- Profit Status

SELECT 
     order_id,
     profit,
     CASE 
         WHEN profit >= 10000 THEN 'High Profit'
         WHEN profit >= 5000 THEN 'Medium Profit'
         ELSE 'Low Profit'
     END AS Profit_Status
FROM dbo.novamart_sales_dataset;

-- Count Orders by Sales Category

SELECT 
  CASE
      WHEN sales >= 50000 THEN 'High Sales'
        WHEN sales >= 25000 THEN 'Medium Sales'
        ELSE 'Low Sales'
    END AS Sales_Category,
    COUNT(*) AS Total_Orders
FROM dbo.novamart_sales_dataset
GROUP BY
    CASE
        WHEN sales >= 50000 THEN 'High Sales'
        WHEN sales >= 25000 THEN 'Medium Sales'
        ELSE 'Low Sales'
    END
ORDER BY Total_Orders DESC;

-- Average Sales by Sales Category

SELECT
      CASE
          WHEN sales >= 50000 THEN 'High Sales'
          WHEN sales >= 25000 THEN 'Medium Sales'
          ELSE 'Low Sales'
      END AS Sales_Category,
      AVG(sales) AS Average_Sales
FROM dbo.novamart_sales_dataset
GROUP BY 
        CASE
            WHEN sales >= 50000 THEN 'High Sales'
            WHEN sales >= 25000 THEN 'Medium Sales'
            ELSE 'Low Sales'
        END;

-- Category-wise High Sales

SELECT
    category,
    COUNT(*) AS High_Value_Orders
FROM dbo.novamart_sales_dataset
WHERE sales >= 50000
GROUP BY category
ORDER BY High_Value_Orders DESC;

/*============================================================
                        SUBQUERIES
============================================================*/

-- Orders Above Average Sales

SELECT *
FROM dbo.novamart_sales_dataset
WHERE sales >
(SELECT AVG(sales)
 FROM dbo.novamart_sales_dataset);

-- Orders Above Average Profit

SELECT *
FROM dbo.novamart_sales_dataset
WHERE profit >
(SELECT AVG(profit)
 FROM dbo.novamart_sales_dataset);

-- Highest Sales Order

SELECT *
FROM dbo.novamart_sales_dataset
WHERE sales =
(SELECT MAX(sales)
 FROM dbo.novamart_sales_dataset);

-- Highest Profit Order

SELECT *
FROM dbo.novamart_sales_dataset
WHERE profit=
(SELECT MAX(profit)
 FROM dbo.novamart_sales_dataset);

-- Salespersons Above Average Sales

SELECT 
      salesperson,
      SUM(sales) AS Total_Sales
FROM dbo.novamart_sales_dataset
GROUP BY salesperson
HAVING SUM(sales) >
(SELECT AVG(sales)
 FROM dbo.novamart_sales_dataset)
ORDER BY Total_Sales DESC;

/*============================================================
             COMMON TABLE EXPRESSIONS (CTEs)
============================================================*/

-- CTE - Total Sales by Category

WITH CategorySales AS
(
    SELECT
        category,
        SUM(sales) AS Total_Sales
 FROM dbo.novamart_sales_dataset
 GROUP BY category 
)

SELECT *
FROM CategorySales
ORDER BY Total_Sales DESC;

-- CTE - Profit by Salesperson

WITH SalespersonProfit AS
(
    SELECT
        salesperson,
        SUM(profit) AS Total_Profit
 FROM dbo.novamart_sales_dataset
 GROUP BY salesperson
 )

SELECT *
FROM SalespersonProfit
ORDER BY Total_Profit DESC;

-- CTE - High Revenue Cities

WITH CitySales AS
(
    SELECT
        city,
        SUM(sales) AS Total_Sales
 FROM dbo.novamart_sales_dataset
 GROUP BY city
 )

SELECT *
FROM CitySales
WHERE Total_Sales > 5000000
ORDER BY Total_Sales DESC;

-- CTE - Average Sales by Category

WITH CategoryAverage AS
(
    SELECT
        category,
        AVG(sales) AS Average_Sales
 FROM dbo.novamart_sales_dataset
 GROUP BY category
 )

SELECT *
FROM CategoryAverage
ORDER BY Average_Sales DESC;

-- CTE - Average Profit by State

WITH StateProfit AS
(
    SELECT
        state,
        AVG(profit) AS Average_Profit
 FROM dbo.novamart_sales_dataset
 GROUP BY state
 )

SELECT *
FROM StateProfit
ORDER BY Average_Profit DESC;

/*============================================================
                    WINDOW FUNCTIONS
============================================================*/

-- Rank Salespersons by Total Sales

SELECT 
    salesperson,
    SUM(sales) AS Total_Sales,
    RANK() OVER(ORDER BY SUM(sales) DESC) AS Sales_Rank
FROM dbo.novamart_sales_dataset
GROUP BY salesperson;

-- Dense Rank by Profit

SELECT
    salesperson,
    SUM(profit) AS Total_Profit,
    DENSE_RANK() OVER(ORDER BY SUM(profit) DESC) AS Profit_Rank
FROM dbo.novamart_sales_dataset
GROUP BY salesperson;

-- Row Number by Sales

SELECT
    order_id,
    customer_name,
    sales,
    ROW_NUMBER() OVER(ORDER BY sales DESC) AS Row_Num
FROM dbo.novamart_sales_dataset;

-- Running Total of Sales

SELECT
    order_date,
    sales,
    SUM(sales) OVER(ORDER BY order_date,order_id) AS Running_Total
FROM dbo.novamart_sales_dataset;

-- Average Sales using Window Function

SELECT
    order_id,
    sales,
    AVG(sales) OVER() AS Overall_Average
FROM dbo.novamart_sales_dataset;

/*============================================================
                   FINAL BUSINESS INSIGHTS
============================================================*/

-- Top 5 Products by Sales

SELECT TOP 5
    product_name,
    SUM(sales) AS Total_Sales
FROM dbo.novamart_sales_dataset
GROUP BY product_name
ORDER BY Total_Sales DESC;

-- Top 5 Cities by Profit

SELECT TOP 5
    city,
    SUM(profit) AS Total_profit
FROM dbo.novamart_sales_dataset
GROUP BY city
ORDER BY Total_Profit DESC;

-- Most Popular Payment Method

SELECT TOP 1
    payment_method,
    COUNT(*) AS Total_Orders
FROM dbo.novamart_sales_dataset
GROUP BY payment_method
ORDER BY Total_Orders DESC;

-- Best Performing Category

SELECT TOP 1
    category,
    SUM(profit) AS Total_Profit
FROM dbo.novamart_sales_dataset
GROUP BY category
ORDER BY Total_Profit DESC;

-- Top Salesperson

SELECT TOP 1
    salesperson,
    SUM(sales) AS Total_Sales
FROM dbo.novamart_sales_dataset
GROUP BY salesperson
ORDER BY Total_Sales DESC;

/*============================================================
                    PROJECT COMPLETED

Topics Covered

✔ SELECT
✔ WHERE
✔ ORDER BY
✔ TOP
✔ COUNT
✔ SUM
✔ AVG
✔ MIN
✔ MAX
✔ GROUP BY
✔ HAVING
✔ CASE
✔ SUBQUERIES
✔ CTE
✔ WINDOW FUNCTIONS

============================================================*/