create or alter function fn_totalprofit(@cat varchar(50))
returns decimal(18,2)
as
begin
declare @p decimal(18,2);

select @p=sum(profit)
from Superstore
where category=@cat;

return @p;
end;
go

select dbo.fn_totalprofit('Technology') as technology_profit;

create or alter function fn_regionorders(@region varchar(20))
returns table
as
return
(
select *
from Superstore
where region=@region
);
go

select *
from dbo.fn_regionorders('West');