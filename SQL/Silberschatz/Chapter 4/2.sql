#a
select * 
from student natural join takes
union
select *, null, null, null, null, null 
from student 
where not exists (select * from takes where takes.ID = student.ID )
