#a
SELECT title 
FROM department NATURAL JOIN course 
WHERE dept_name = 'Comp. Sci.' AND credits = 3

#b
SELECT DISTINCT *
FROM (student NATURAL JOIN takes) JOIN (instructor NATURAL JOIN teaches) 
using (course_id, sec_id, semester, year)
WHERE instructor.name = 'Einstein'

#c
SELECT MAX(salary), name 
FROM instructor

#d
SELECT salary, name
FROM instructor
WHERE salary = ( SELECT MAX(salary) FROM instructor )

#e
SELECT course_id, sec_id , semester , year, count(ID) as enroll_count
FROM section NATURAL JOIN takes
WHERE semester = 'Spring' and year = 2017
group by sec_id, course_id

#f
SELECT *, max(enroll_count) as enroll_count
from (
SELECT course_id, sec_id , semester , year, count(ID) as enroll_count
FROM section NATURAL JOIN takes
WHERE semester = 'Spring' and year = 2017
group by sec_id, course_id
)

#g
with sec_enrollment as (
select
course_id, sec_id, count(ID) as enrollment
from
section natural join takes
where semester = 'Spring'
and
year = 2017
group by course_id, sec_id)
select course_id, sec_id
from sec_enrollment
where enrollment = (select max(enrollment) from sec_enrollment)