select
order_date,
year(order_date),
month(order_date),
day(order_date),
datename(month,order_date),
datediff(day,order_date,ship_date) as shipping_days
from Superstore;