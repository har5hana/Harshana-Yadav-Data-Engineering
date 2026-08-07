SELECT
    p.category,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent / 100.0)),2) AS total_revenue
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;

SELECT
    o.customer_id,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent / 100.0)),2) AS total_order_value
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id
WHERE o.customer_id != 'UNKNOWN'
GROUP BY o.customer_id
ORDER BY total_order_value DESC
LIMIT 10;

SELECT
    strftime('%Y-%m', order_date) AS month,
    COUNT(*) AS total_orders
FROM orders
GROUP BY month
ORDER BY month DESC
LIMIT 12;

SELECT DISTINCT customer_id
FROM orders
WHERE customer_id NOT IN (
    SELECT customer_id
    FROM orders
    WHERE status='DELIVERED'
);

SELECT
    product_id,
    SUM(CASE WHEN quantity<0 THEN 1 ELSE 0 END) AS returns,
    SUM(CASE WHEN quantity>0 THEN 1 ELSE 0 END) AS purchases
FROM order_items
GROUP BY product_id
HAVING returns > purchases;

SELECT
    p.category,
    ROUND(
        SUM(CASE WHEN oi.quantity<0 THEN 1 ELSE 0 END)*100.0/
        COUNT(*),
        2
    ) AS return_rate
FROM order_items oi
JOIN products p
ON oi.product_id=p.product_id
GROUP BY p.category;

SELECT
    region_code,
    DATE(order_date) AS order_date,
    SUM(quantity*unit_price*(1-discount_percent/100.0)) AS daily_revenue,
    SUM(
        SUM(quantity*unit_price*(1-discount_percent/100.0))
    ) OVER(
        PARTITION BY region_code
        ORDER BY DATE(order_date)
    ) AS running_total
FROM orders o
JOIN order_items oi
ON o.order_id=oi.order_id
GROUP BY region_code,DATE(order_date);

SELECT
    category,
    product_name,
    total_revenue,
    DENSE_RANK() OVER(
        PARTITION BY category
        ORDER BY total_revenue DESC
    ) AS rank_in_category
FROM(
SELECT
    p.category,
    p.product_name,
    SUM(oi.quantity*oi.unit_price*(1-oi.discount_percent/100.0)) AS total_revenue
FROM products p
JOIN order_items oi
ON p.product_id=oi.product_id
GROUP BY p.product_id
);

SELECT
    customer_id,
    order_date,
    LAG(order_date)
    OVER(
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS previous_order_date,

    julianday(order_date)-julianday(
        LAG(order_date)
        OVER(
            PARTITION BY customer_id
            ORDER BY order_date
        )
    ) AS days_gap

FROM orders
WHERE customer_id!='UNKNOWN';

WITH monthly_revenue AS(
SELECT
customer_id,
strftime('%Y-%m',order_date) AS month,
SUM(quantity*unit_price*(1-discount_percent/100.0)) revenue
FROM orders o
JOIN order_items oi
ON o.order_id=oi.order_id
GROUP BY customer_id,month
)

SELECT
month,
CASE
WHEN revenue>10000 THEN 'High'
WHEN revenue BETWEEN 5000 AND 10000 THEN 'Medium'
ELSE 'Low'
END AS category,
COUNT(*) total_customers
FROM monthly_revenue
GROUP BY month,category;

SELECT
customer_id,
total_value,

NTILE(4)
OVER(
ORDER BY total_value DESC
) quartile

FROM(

SELECT
customer_id,
SUM(quantity*unit_price*(1-discount_percent/100.0))
AS total_value

FROM orders o
JOIN order_items oi

ON o.order_id=oi.order_id

GROUP BY customer_id

);

WITH revenue AS(

SELECT

strftime('%Y',order_date) year,
strftime('%m',order_date) month,

SUM(quantity*unit_price*(1-discount_percent/100.0))
revenue

FROM orders o

JOIN order_items oi

ON o.order_id=oi.order_id

GROUP BY year,month

)

SELECT *

FROM revenue;

SELECT
customer_id,
MIN(category) first_category,
MAX(category) last_category
FROM(

SELECT
o.customer_id,
p.category

FROM orders o

JOIN order_items oi

ON o.order_id=oi.order_id

JOIN products p

ON oi.product_id=p.product_id

)

GROUP BY customer_id;

SELECT
customer_id,
revenue,

SUM(revenue)
OVER(
ORDER BY revenue DESC
)
AS cumulative_revenue

FROM(

SELECT
customer_id,

SUM(quantity*unit_price*(1-discount_percent/100.0))
revenue

FROM orders o

JOIN order_items oi

ON o.order_id=oi.order_id

GROUP BY customer_id

);

SELECT
strftime('%Y-%m',registration_date)
AS cohort,

COUNT(*) total_customers

FROM customers

GROUP BY cohort;

SELECT

a.product_id AS product_a,

b.product_id AS product_b,

COUNT(*) AS times_bought_together

FROM order_items a

JOIN order_items b

ON a.order_id=b.order_id

AND a.product_id<b.product_id

GROUP BY
a.product_id,
b.product_id

ORDER BY
times_bought_together DESC;

