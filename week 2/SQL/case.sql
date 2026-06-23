select
order_id,
sales,
case
when sales<100 then 'Low'
when sales<500 then 'Medium'
when sales<1000 then 'High'
else 'Very High'
end as sales_level
from Superstore;