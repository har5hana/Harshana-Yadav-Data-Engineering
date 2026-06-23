use SuperstoreDB;
go

select *,
row_number() over(order by sales desc) as sales_rank
from Superstore;

select *,
row_number() over(partition by category order by sales desc) as sales_rank
from Superstore;

select *,
rank() over(order by profit desc) as profit_rank
from Superstore;

select *,
rank() over(partition by category order by profit desc) as profit_rank
from Superstore;

select *,
dense_rank() over(order by sales desc) as sales_rank
from Superstore;

select *,
dense_rank() over(partition by region order by sales desc) as sales_rank
from Superstore;

select *,
ntile(4) over(order by sales desc) as sales_quartile
from Superstore;

select customer_name,
sum(sales) as total_sales,
rank() over(order by sum(sales) desc) as customer_rank
from Superstore
group by customer_name;

select customer_name,
sum(profit) as total_profit,
dense_rank() over(order by sum(profit) desc) as profit_rank
from Superstore
group by customer_name;

select product_name,
sum(sales) as total_sales,
rank() over(order by sum(sales) desc) as sales_rank
from Superstore
group by product_name;

select category,
sum(sales) as total_sales,
rank() over(order by sum(sales) desc) as sales_rank
from Superstore
group by category;

select region,
sum(sales) as total_sales,
rank() over(order by sum(sales) desc) as sales_rank
from Superstore
group by region;

select year(order_date) as order_year,
month(order_date) as order_month,
sum(sales) as total_sales,
lag(sum(sales),1) over(order by year(order_date),month(order_date)) as previous_month_sales
from Superstore
group by year(order_date),month(order_date);

select year(order_date) as order_year,
month(order_date) as order_month,
sum(sales) as total_sales,
lead(sum(sales),1) over(order by year(order_date),month(order_date)) as next_month_sales
from Superstore
group by year(order_date),month(order_date);

select year(order_date) as order_year,
month(order_date) as order_month,
sum(sales) as total_sales,
sum(sum(sales)) over(order by year(order_date),month(order_date)) as running_sales
from Superstore
group by year(order_date),month(order_date);

select year(order_date) as order_year,
month(order_date) as order_month,
sum(profit) as total_profit,
sum(sum(profit)) over(order by year(order_date),month(order_date)) as running_profit
from Superstore
group by year(order_date),month(order_date);

select customer_name,
sum(sales) as total_sales,
avg(sum(sales)) over() as overall_avg_sales
from Superstore
group by customer_name;

select state,
sum(sales) as total_sales,
rank() over(order by sum(sales) desc) as state_rank
from Superstore
group by state;

select city,
sum(profit) as total_profit,
dense_rank() over(order by sum(profit) desc) as city_rank
from Superstore
group by city;

select sub_category,
sum(sales) as total_sales,
rank() over(order by sum(sales) desc) as subcategory_rank
from Superstore
group by sub_category;

select segment,
sum(profit) as total_profit,
rank() over(order by sum(profit) desc) as segment_rank
from Superstore
group by segment;

select ship_mode,
count(*) as total_orders,
rank() over(order by count(*) desc) as shipmode_rank
from Superstore
group by ship_mode;