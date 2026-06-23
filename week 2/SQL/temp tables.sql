select customer_name,
sum(sales) as total_sales
into #customersales
from Superstore
group by customer_name;

select *
from #customersales
order by total_sales desc;

drop table #customersales;

