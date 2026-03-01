SELECT Ins_Name , Salary ,
CASE 
WHEN Salary >= 3000 then 'high'
WHEN Salary <3000 then 'low'
else 'No Value'
END  as newsalary
from Instructor


select ins_name ,iif(salary >= 3000,'high' , 'low')
from Instructor
--this case if there is only if and else 

--we can use it at update too

update Instructor 
	set Salary=
		CASE 
		WHEN Salary	<= 3000 then Salary*1.20
		WHEN Salary >3000 then Salary*1.10
		END 
		--like when the salary increase