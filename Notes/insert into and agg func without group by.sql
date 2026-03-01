select * into table2 from student --DDL created a copy from table
select * into table4 from student where 1=3 --created a table with only colmuns names //// with no values 
select * into newtable from student where St_Age > '15'

--insert data based on select statment
insert into table2
select st_id,st_fname from student 

select sum(salary)
from Instructor
having count(Ins_Id)<100 --having with no group by cuz there is a aggregate fun at select so its see it like the taable is a one group 

select sum(salary)
from Instructor
where count(Ins_Id)<100 --error

