#a
SELECT title 
FROM department NATURAL JOIN course 
WHERE dept_name = 'Comp. Sci.' AND credits = 3

#b
SELECT DISTINCT *
FROM (student NATURAL JOIN takes) JOIN (instructor NATURAL JOIN teaches) 
using (course_id, sec_id, semester, year)
WHERE instructor.name = 'Einstein'