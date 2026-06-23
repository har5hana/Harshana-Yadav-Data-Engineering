create table SalesBackup
(
row_id int primary key,
sales decimal(18,2)
);

merge SalesBackup as t
using
(
select row_id,sales
from Superstore
)s
on t.row_id=s.row_id
when matched then
update set t.sales=s.sales
when not matched then
insert(row_id,sales)
values(s.row_id,s.sales);