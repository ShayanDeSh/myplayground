select student, sum(marks) as grade, rank() over (grade desc) as ranking
from S 
group by student
having ranking <= n