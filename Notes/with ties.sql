use ITI
select top (3) *
from course

select top(2) salary 
from Instructor 

select top(7) with ties *
from hr.student 
order by St_Age

--return when it have same age (don't ignore it)