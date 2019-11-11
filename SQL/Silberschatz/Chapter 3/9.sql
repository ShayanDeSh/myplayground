#a
select employee_name, city
from employee natural join works
where company_name = 'First Bank Corporation'

#b
select *
from employee natural join works
where company_name = 'First Bank Corporation' and salary > 10000

#alternative for b
select *
from employee
where employee_name in 
		(select employee_name 
		from works
		where company_name = 'First Bank Corporation' and salary > 10000)
		
#c
select employee_name 
		from works
		where company_name <> 'First Bank Corporation'
		
#d
select employee_name
from works
where salary > all (
select salary from works where company_name = 'Small Back Corporation'

with emp_total_salary as (
	select employee_name, sum(salary) as total_salary
	from works
	group by employee_name
	)
	select employee_name
		from emp_total_salary
		where total_salary > all
		(select total_salary 
			from emp_total_salary, works
			where works.company_name = 'Small Back Corporation' and emp_total_salary.employee_name = works.employee_name)
			
#e
select company_name 
from company as A 
where (select city from company as B where B.company_name = A.company_name) contains (select city from company as C where C.company_name = Small Back Corporation)

select company 
from company as A
where not exists ((select city from company as B where B.company_name = 'Small Back Corporation') except (select city from company as C where C.company_name = A.company_name))

#f
select company_name
from works
group by company_name
having count(distinct employee_name) >= all (select count(distinct employee_name) from works group by company_name)

#g
select company_name
from works 
group by company_name
having avg(salary) > all (select avg(salary) from works where company_name = 'First Bank Corporation')


