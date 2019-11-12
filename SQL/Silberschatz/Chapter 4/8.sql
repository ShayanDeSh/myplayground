#a
select *
from ((instructor natural join teaches) natural join section ) as X , ((instructor natural join teaches) natural join section )as T
where X.ID = T.ID and X.semester = T.semester and X.year = T.year and X.sec_id = T.sec_id and X.time_slot_id = T.time_slot_id and (X.building <> T.building or X.room_number <> T.room_number)

#b
create assertion check not exists (
select *
from ((instructor natural join teaches) natural join section ) as X , ((instructor natural join teaches) natural join section )as T
where X.ID = T.ID and X.semester = T.semester and X.year = T.year and X.sec_id = T.sec_id and X.time_slot_id = T.time_slot_id and (X.building <> T.building or X.room_number <> T.room_number)
)