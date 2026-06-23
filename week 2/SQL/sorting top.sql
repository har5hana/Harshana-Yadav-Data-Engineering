use SuperstoreDB;
go

select top 10 *
from Superstore;

select top 10 *
from Superstore
order by sales desc;

select top 10 *
from Superstore
order by sales;

select top 10 *
from Superstore
order by profit desc;

select top 10 *
from Superstore
order by profit;

select top 10 *
from Superstore
order by quantity desc;

select top 10 *
from Superstore
order by discount desc;

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

select top 10 state,
sum(sales) as total_sales
from Superstore
group by state
order by total_sales desc;

select top 10 city,
sum(sales) as total_sales
from Superstore
group by city
order by total_sales desc;

select top 10 sub_category,
sum(sales) as total_sales
from Superstore
group by sub_category
order by total_sales desc;

select top 10 sub_category,
sum(profit) as total_profit
from Superstore
group by sub_category
order by total_profit desc;

select top 5 category,
sum(sales) as total_sales
from Superstore
group by category
order by total_sales desc;

select top 5 region,
sum(sales) as total_sales
from Superstore
group by region
order by total_sales desc;

select top 10 customer_name,
count(order_id) as total_orders
from Superstore
group by customer_name
order by total_orders desc;

select top 10 product_name,
count(order_id) as times_ordered
from Superstore
group by product_name
order by times_ordered desc;

select top 10 *
from Superstore
where profit<0
order by profit;

select top 10 *
from Superstore
where discount>0
order by discount desc;

select top 10 *
from Superstore
where sales>1000
order by profit desc;

select top 10 *
from Superstore
where category='Technology'
order by sales desc;

select top 10 *
from Superstore
where category='Furniture'
order by sales desc;

select top 10 *
from Superstore
where category='Office Supplies'
order by sales desc;

select top 10 *
from Superstore
order by order_date desc;

select top 10 *
from Superstore
order by ship_date desc;

select top 10 customer_name,
avg(sales) as avg_sales
from Superstore
group by customer_name
order by avg_sales desc;

select top 10 state,
avg(profit) as avg_profit
from Superstore
group by state
order by avg_profit desc;

select top 10 city,
avg(sales) as avg_sales
from Superstore
group by city
order by avg_sales desc;