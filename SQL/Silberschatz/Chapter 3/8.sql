#a
select customer_name 
	from depositor 
		except
select customer_name
	from borrower
	
#b
select customer_name 
	from(
		select customer_street, customer_city
		from customer
		where customer_name = 'Smith'
		) as A
	where customer_street = A.customer_street and customer_city = A.customer_city
	
#alternative for b
select A.customer_name 
from customer as A join customer as B using(customer_city, customer_street)
where B.customer_name = 'smith'

#c
select distinct branch_name 
from customer natural join depositor natural join account
where customer_city = 'Harrison'