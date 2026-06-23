select *
from
(
select region,category,sales
from Superstore
) s
pivot
(
sum(sales)
for category in
([Furniture],[Office Supplies],[Technology])
)p;