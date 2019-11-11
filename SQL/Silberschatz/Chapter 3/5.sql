#a
select ID,
		case
			when score < 40 then 'F'
			when score < 60 then 'C'
			when score < 80	then 'D'
			else 'A'
		end
	from marks

#b
select ID, count(*) from (
	select ID,
		case
			when score < 40 then 'F'
			when score < 60 then 'C'
			when score < 80	then 'D'
			else 'A'
		end
	from marks
) group by grade