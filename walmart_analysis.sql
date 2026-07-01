CREATE DATABASE walmart_db;
use walmart_db;
select * from walmart;

select
	payment_method,
    count(*)
FROM walmart
group by payment_method;


select
	count(distinct branch)
from walmart;

select max(quantity) from walmart;

#Questions

#1. Total Revenue Generated

SELECT
    ROUND(SUM(unit_price * quantity), 2) AS total_revenue
FROM walmart;
# 209726.38

#2. Total Sales by City

SELECT
    City,
    ROUND(SUM(unit_price * quantity), 2) AS revenue
FROM walmart
GROUP BY City
ORDER BY revenue DESC;

# 3. Best Selling Product Category

SELECT
    category,
    SUM(quantity) AS total_quantity_sold
FROM walmart
GROUP BY category
ORDER BY total_quantity_sold DESC;

#'Fashion accessories','9653'
#'Home and lifestyle','9610'
#'Electronic accessories','1494'
#''Sports and travel','920'
#''Health and beauty','854'

#4. Average Rating by Category
SELECT
    category,
    ROUND(AVG(rating), 2) AS avg_rating
FROM walmart
GROUP BY category
ORDER BY avg_rating DESC;

# 5. Most Preferred Payment Method
SELECT
    payment_method,
    COUNT(*) AS total_transactions
FROM walmart
GROUP BY payment_method
ORDER BY total_transactions DESC;

#6. Branch with Highest Revenue
SELECT
    Branch,
    ROUND(SUM(unit_price * quantity), 2) AS revenue
FROM walmart
GROUP BY Branch
ORDER BY revenue DESC
LIMIT 1;

#7. Monthly Revenue Analysis
SELECT
    MONTH(date) AS month_no,
    MONTHNAME(date) AS month_name,
    ROUND(SUM(unit_price * quantity), 2) AS revenue
FROM walmart
GROUP BY month_no, month_name
ORDER BY month_no;

#8. Top 5 Highest Value Transactions
SELECT
    invoice_id,
    City,
    category,
    quantity,
    unit_price,
    (quantity * unit_price) AS total_bill
FROM walmart
ORDER BY total_bill DESC
LIMIT 5;

#9. Average Profit Margin by Category
SELECT
    category,
    ROUND(AVG(profit_margin), 2) AS avg_profit_margin
FROM walmart
GROUP BY category
ORDER BY avg_profit_margin DESC;

#10. Most Profitable Category
SELECT
    category,
    ROUND(SUM(unit_price * quantity * profit_margin), 2) AS profit
FROM walmart
GROUP BY category
ORDER BY profit DESC;

#11. Peak Shopping Hours
SELECT
    HOUR(time) AS hour_of_day,
    COUNT(*) AS transactions
FROM walmart
GROUP BY hour_of_day
ORDER BY transactions DESC;

#12. Revenue by Payment Method
SELECT
    payment_method,
    ROUND(SUM(unit_price * quantity), 2) AS revenue
FROM walmart
GROUP BY payment_method
ORDER BY revenue DESC;

#13. Which City Gives the Highest Average Rating?
SELECT
    City,
    ROUND(AVG(rating), 2) AS avg_rating
FROM walmart
GROUP BY City
ORDER BY avg_rating DESC;

#14. Categories with Above-Average Revenue
SELECT
    category,
    SUM(unit_price * quantity) AS revenue
FROM walmart
GROUP BY category
HAVING revenue >
(
    SELECT AVG(category_revenue)
    FROM
    (
        SELECT SUM(unit_price * quantity) AS category_revenue
        FROM walmart
        GROUP BY category
    )x
);

#15. Rank Cities by Revenue (Window Function)
SELECT
    City,
    revenue,
    RANK() OVER (ORDER BY revenue DESC) AS city_rank
FROM
(
    SELECT
        City,
        SUM(unit_price * quantity) AS revenue
    FROM walmart
    GROUP BY City
) t;

#16. Find the Most Popular Category in Each City
WITH category_sales AS (
    SELECT
        City,
        category,
        SUM(quantity) AS total_qty,
        RANK() OVER (
            PARTITION BY City
            ORDER BY SUM(quantity) DESC
        ) AS rnk
    FROM walmart
    GROUP BY City, category
)

SELECT
    City,
    category,
    total_qty
FROM category_sales
WHERE rnk = 1;



