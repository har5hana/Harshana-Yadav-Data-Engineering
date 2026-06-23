use SuperstoreDB;
go

create view vw_totalsalesbycategory as
select category,
sum(sales) as total_sales
from Superstore
group by category;
go

select *
from vw_totalsalesbycategory;

create view vw_totalprofitbyregion as
select region,
sum(profit) as total_profit
from Superstore
group by region;
go

select *
from vw_totalprofitbyregion;

create view vw_topcustomers as
select customer_name,
sum(sales) as total_sales,
sum(profit) as total_profit
from Superstore
group by customer_name;
go

select top 10 *
from vw_topcustomers
order by total_sales desc;

create view vw_topproducts as
select product_name,
sum(sales) as total_sales,
sum(quantity) as total_quantity
from Superstore
group by product_name;
go

select top 10 *
from vw_topproducts
order by total_sales desc;

create view vw_monthlysales as
select
year(order_date) as order_year,
month(order_date) as order_month,
sum(sales) as total_sales,
sum(profit) as total_profit
from Superstore
group by year(order_date),month(order_date);
go

select *
from vw_monthlysales
order by order_year,order_month;

create view vw_statesales as
select state,
sum(sales) as total_sales,
sum(profit) as total_profit
from Superstore
group by state;
go

select *
from vw_statesales
order by total_sales desc;

create view vw_citysales as
select city,
sum(sales) as total_sales
from Superstore
group by city;
go

select *
from vw_citysales
order by total_sales desc;

create view vw_categoryprofit as
select category,
sum(profit) as total_profit
from Superstore
group by category;
go

select *
from vw_categoryprofit
order by total_profit desc;

create view vw_subcategorysales as
select sub_category,
sum(sales) as total_sales
from Superstore
group by sub_category;
go

select *
from vw_subcategorysales
order by total_sales desc;

create nonclustered index idx_orderdate
on Superstore(order_date);

create nonclustered index idx_customerid
on Superstore(customer_id);

create nonclustered index idx_productid
on Superstore(product_id);

create nonclustered index idx_category
on Superstore(category);

create nonclustered index idx_region
on Superstore(region);

create nonclustered index idx_state
on Superstore(state);

create nonclustered index idx_sales
on Superstore(sales);

create nonclustered index idx_profit
on Superstore(profit);

exec sp_helpindex 'Superstore';