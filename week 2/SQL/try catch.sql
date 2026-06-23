begin try

select 10/0;

end try

begin catch

select
error_number() as error_number,
error_message() as error_message;

end catch;