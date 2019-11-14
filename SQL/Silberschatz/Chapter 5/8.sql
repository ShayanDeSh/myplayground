create trigger delete_depositor after delete on account
REFERENCING old row as orow
for each row 
delete from depositor
where depositor.name in (
	select name from depositor where depositor.name = orow.name
)