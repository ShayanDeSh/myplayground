CREATE TRIGGER time_conflict after insert on section
REFERENCING new row as nrow 
for each row 
when (
	exists (
		select	* 
		from	section natural join teaches
		group by ID, semester, year, room_number, building, time_slot_id
		having count(*) > 1
	)
)
begin
	ROLLBACK
end