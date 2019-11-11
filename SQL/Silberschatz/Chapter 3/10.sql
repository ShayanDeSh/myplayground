#a
update employee
set city = 'Newton'
where person_name = 'Jones'

#b
update works as T
set salary = salary * (
	case
		when (T.salary * 1.1 > 100000) then 1.03
		else 1.1
	end
) where T.employee_name in (select manager_name from manages) and T.company_name = 'First Bank Corporation'