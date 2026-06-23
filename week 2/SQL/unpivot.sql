select *
from
(
select
region,
sum(case when category='Furniture' then sales end) as Furniture,
sum(case when category='Office Supplies' then sales end) as OfficeSupplies,
sum(case when category='Technology' then sales end) as Technology
from Superstore
group by region
)t
unpivot
(
sales
for category in
(Furniture,OfficeSupplies,Technology)
)u;