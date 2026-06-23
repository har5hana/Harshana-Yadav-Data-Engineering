create or alter procedure sp_topsalesbycategory
as
begin
select category,
sum(sales) as total_sales
from Superstore
group by category
order by total_sales desc;
end;
go

exec sp_topsalesbycategory;

create or alter procedure sp_salesbyregion
@region varchar(20)
as
begin
select *
from Superstore
where region=@region;
end;
go

exec sp_salesbyregion 'West';