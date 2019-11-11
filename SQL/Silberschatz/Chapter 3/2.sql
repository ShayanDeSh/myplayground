#a
select sum(points * credits) 
from (takes natural join course) natural join grade_points 
where ID = 12345

#b
select sum(points * credits) / sum(credits)
from (takes natural join course) natural join grade_points 
where ID = 12345

#c
select sum(points * credits) / sum(credits), ID
from (takes natural join course) natural join grade_points 
group by ID