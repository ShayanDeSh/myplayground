#1
SELECT * FROM drivers where first_name = "Parham";

#2
SELECT * FROM rides INNER JOIN drivers ON drivers.id = rides.driver GROUP BY drivers.id 
HAVING COUNT(drivers.id) > 20;

#2 without group by
SELECT * from 
( SELECT DISTINCT rides.driver as driver_id, 
(SELECT COUNT(rides.driver) FROM rides, drivers WHERE driver = drivers.id and rides.driver = driver_id)
 AS number_of_travel FROM rides) as x WHERE number_of_travel > 20;

#3
SELECT * FROM (SELECT DISTINCT rides.driver as driver_id, 
(SELECT COUNT(*) FROM rides ,
 drivers WHERE driver = drivers.id and rides.passanger = 5 and rides.driver = driver_id)
 as number_of_travel FROM rides) AS x WHERE number_of_travel >= 2;

#4
SELECT * FROM 
(SELECT DISTINCT rides.passanger as pass_id, (SELECT COUNT(*) FROM rides , passengers 
WHERE passanger = passengers.id and driver = 1 and rides.passanger = pass_id) as number_of_travel FROM rides)
 as x WHERE number_of_travel > 1

#5
DELETE FROM discounts WHERE availables <= 0;

#6
SELECT AVG(score) FROM rides WHERE rides.driver = 1

#7
SELECT driver_id, max(avg_score) FROM (SELECT DISTINCT rides.driver as driver_id, 
(SELECT AVG(rides.score) FROM rides , drivers WHERE rides.driver = driver_id) as avg_score
 FROM rides) as x;

#8
SELECT * FROM rides 
INNER JOIN  discounts ON discounts.passenger = rides.passanger and discounts.code = rides.discount 
WHERE discounts.code = 'xmas' and discounts.passenger= 5;

#9
SELECT * FROM rides WHERE rides.source_lat = 45 and rides.source_lng = 22

#10
SELECT * FROM `rides` WHERE start_time = '1975-03-10 10:12:01'

#11
SELECT * FROM `rides` WHERE finish_time = '1970-01-02 00:00:01'

#12
UPDATE discounts d set d.availables = d.availables - 1 WHERE d.passenger = 5 and d.code = 'xmas'

#13
SELECT * FROM rides WHERE 
start_time LIKE "%1975-03-10%" AND rides.final_price >= (SELECT AVG(final_price)
 FROM rides WHERE start_time LIKE "%1975-03-10%")

#14
SELECT * FROM (SELECT DISTINCT rides.driver as driver_id, 
(SELECT AVG(rides.score) FROM rides , drivers WHERE rides.driver = driver_id 
and rides.start_time LIKE '%1975-03-10%') as avg_score FROM rides) 
as x WHERE avg_score > 4

#---------------------------------------------------------------------------------------------------------

#1
SELECT id, source_lat, source_lng, destination_lat, destination_lng FROM 
rides WHERE ST_Within(ST_GeomFromWKB(Point(source_lat, source_lng)),
 ST_GEOMFROMTEXT('POLYGON ((-100 -130, -100 30, 100 30, 100 -130 , -100 -130))'))
 and ST_Within(ST_GeomFromWKB(Point(destination_lat, destination_lng)),
 ST_GEOMFROMTEXT('POLYGON ((-100 -130, -100 30, 100 30, 100 -130 , -100 -130))'))
 
#2
SELECT AVG((TIMESTAMPDIFF(MINUTE, start_time, finish_time))) 
as length FROM `rides` WHERE start_time LIKE '1975-03-10%'

#3
SELECT DISTINCT T.driver FROM rides as T ,
 rides as E WHERE T.passanger = E.passanger
 AND T.driver = E.driver AND T.id <> E.id

#4
SELECT DISTINCT T.passanger FROM rides as T , 
rides as E WHERE T.passanger = E.passanger 
AND T.driver = E.driver AND T.id <> E.id


