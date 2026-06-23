use SuperstoreDB;
go

select year(order_date) as order_year,
sum(sales) as total_sales
from Superstore
group by year(order_date)
order by order_year;

select month(order_date) as order_month,
sum(sales) as total_sales
from Superstore
group by month(order_date)
order by order_month;

select year(order_date) as order_year,
month(order_date) as order_month,
sum(sales) as total_sales
from Superstore
group by year(order_date),month(order_date)
order by order_year,order_month;

select top 10 customer_name,
sum(sales) as total_sales
from Superstore
group by customer_name
order by total_sales desc;

select top 10 customer_name,
sum(profit) as total_profit
from Superstore
group by customer_name
order by total_profit desc;

select top 10 customer_name,
count(distinct order_id) as total_orders
from Superstore
group by customer_name
order by total_orders desc;

select top 10 product_name,
sum(sales) as total_sales
from Superstore
group by product_name
order by total_sales desc;

select top 10 product_name,
sum(profit) as total_profit
from Superstore
group by product_name
order by total_profit desc;

select top 10 product_name,
sum(quantity) as total_quantity
from Superstore
group by product_name
order by total_quantity desc;

select category,
sum(sales) as total_sales
from Superstore
group by category
order by total_sales desc;

select category,
sum(profit) as total_profit
from Superstore
group by category
order by total_profit desc;

select sub_category,
sum(sales) as total_sales
from Superstore
group by sub_category
order by total_sales desc;

select sub_category,
sum(profit) as total_profit
from Superstore
group by sub_category
order by total_profit desc;

select region,
sum(sales) as total_sales
from Superstore
group by region
order by total_sales desc;

select region,
sum(profit) as total_profit
from Superstore
group by region
order by total_profit desc;

select state,
sum(sales) as total_sales
from Superstore
group by state
order by total_sales desc;

select state,
sum(profit) as total_profit
from Superstore
group by state
order by total_profit desc;

select city,
sum(sales) as total_sales
from Superstore
group by city
order by total_sales desc;

select city,
sum(profit) as total_profit
from Superstore
group by city
order by total_profit desc;

select segment,
sum(sales) as total_sales
from Superstore
group by segment
order by total_sales desc;

select segment,
sum(profit) as total_profit
from Superstore
group by segment
order by total_profit desc;

select ship_mode,
count(*) as total_orders
from Superstore
group by ship_mode
order by total_orders desc;

select ship_mode,
sum(sales) as total_sales
from Superstore
group by ship_mode
order by total_sales desc;

select ship_mode,
avg(profit) as avg_profit
from Superstore
group by ship_mode
order by avg_profit desc;

select region,
avg(discount) as avg_discount
from Superstore
group by region
order by avg_discount desc;

select category,
avg(discount) as avg_discount
from Superstore
group by category
order by avg_discount desc;

select customer_name,
sum(profit) as total_profit
from Superstore
group by customer_name
having sum(profit)<0
order by total_profit;

select product_name,
sum(profit) as total_profit
from Superstore
group by product_name
having sum(profit)<0
order by total_profit;

select order_id,
count(*) as duplicate_rows
from Superstore
group by order_id
having count(*)>1
order by duplicate_rows desc;

select customer_id,
count(*) as total_records
from Superstore
group by customer_id
order by total_records desc;

select product_id,
count(*) as total_records
from Superstore
group by product_id
order by total_records desc;

select top 5 state,
sum(sales) as total_sales
from Superstore
group by state
order by total_sales desc;

select top 5 state,
sum(profit) as total_profit
from Superstore
group by state
order by total_profit desc;

select top 5 city,
sum(sales) as total_sales
from Superstore
group by city
order by total_sales desc;

select top 5 city,
sum(profit) as total_profit
from Superstore
group by city
order by total_profit desc;

select category,
sum(quantity) as total_quantity
from Superstore
group by category
order by total_quantity desc;

select sub_category,
sum(quantity) as total_quantity
from Superstore
group by sub_category
order by total_quantity desc;

select year(order_date) as order_year,
count(distinct order_id) as total_orders
from Superstore
group by year(order_date)
order by order_year;

select month(order_date) as order_month,
count(distinct order_id) as total_orders
from Superstore
group by month(order_date)
order by order_month;