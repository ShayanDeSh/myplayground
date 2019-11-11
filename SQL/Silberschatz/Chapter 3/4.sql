#a
select count(distinct name) 
from person, car, participated 
where date like "2009%"

#b

#c
delete car
where model = 'mazda' and licence in (
	select licence from person as p, owns as o where p.name = 'John Smith' and p.driver_id = o.driver_id
)