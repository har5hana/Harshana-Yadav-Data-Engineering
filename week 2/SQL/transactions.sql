begin transaction;

update Superstore
set discount=discount
where row_id=1;

rollback;

begin transaction;

update Superstore
set discount=discount
where row_id=1;

commit;