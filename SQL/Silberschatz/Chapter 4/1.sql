#a
select ID, name,
count(sec_id) as 'Number of sections'
from instructor natural left outer join teaches
group by ID, name

#b
select ID, name, (select count(*) from teaches where teaches.ID = instructor.ID)
from instructor

#c
select dept_name, count(ID)
from department left natural outer join instructor group by dept_name