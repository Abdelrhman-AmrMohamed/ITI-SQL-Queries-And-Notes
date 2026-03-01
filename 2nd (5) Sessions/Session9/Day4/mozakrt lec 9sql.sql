alter proc getst
as 
select * from Course

getst

create proc getnamebyid @id int
as 
select * from Course 
where Crs_Id=@id 

getnamebyid 100

create proc instcrs @id int , @coursename varchar(20)
as 
insert into Course(Crs_id , Crs_Name)
values(@id , @coursename)

instcrs 100,'html'

alter proc instcrs @id int,@coursename varchar(20)
as 
begin try
insert into Course(Crs_id,Crs_Name)
values(@id,@coursename)
end try
begin catch
select 'error dublicate value'
end catch

instcrs 100,'html'
instcrs 999,'database'

create proc sumdata @x int , @y int
as 
select @x + @y 


sumdata 7,3

sumdata @y=3,@x=7


alter proc sumdata @x int =100 , @y int =200
as 
select @x+@y 

sumdata @y = 23


create proc getcrsbyid @id int 
as 
select Crs_Name
FROM Course
where Crs_Id=@id

getcrsbyid 200

create table table3(coursename varchar(20))
insert into table3 
execute getcrsbyid 200
select * from table3


create table table0(coursename varchar(20))
insert into table0
execute getcrsbyid 200
return coursename
select * from table0


declare @t table (x varchar(20))
insert into @t 
execute getcrsbyid 100
select * from @t 


declare @x varchar(30)
set @x=execute getcrsbyid 999
select @x

create proc getdata2 @id int output , @name varchar(30) output
as 
select @id=Crs_Id , @name=Crs_Name
from Course
where Crs_Duration=@id 

declare @x int=100 , @y varchar(20)
execute getdata2 @x output , @y output
select @x,@y

use ITI
select * from Course
insert into Course 
values (900,'html',100,NULL)

alter proc getalldata @col varchar(20) , @tab varchar(20)
as
 execute ('select' + @col + 'from  ' +@tab)
 
 getalldata '*','Course'


 use ITI
 create trigger t1 
 on student
 after insert
 as 
 select 'inserted'
 insert into Student (id,name)
 values(77,'ali')

 create trigger t22
 on student
 for update
 as 
 select getdate()

update student 
set id+=1

create trigger t4 
on student
instead of delete 
as
select 'it cannot be deleted for user : ' + SUSER_NAME()

delete from student where id=1

create trigger readonlytrigg
on student
instead of insert

select 'read only'
as
delete from student where id=1
update student set id=4
insert into student (id,name) values (4,'abdo')

alter trigger t6 
on student
after update
as
	if update(id)
	select 'id updated'
update student 
set name='ali' where id =1
alter table student disable trigger t6
update student 
set id=5 where name='ali'

--with any fire for trigger there is 2 tables created auto
--inserted table,deleted table
--both created at tempdb and deleted 
create trigger t7 
on student
after update
as
select * from inserted
select * from deleted
--rg3 l updated value and deleted one
update student 
set name='muhammed'
where id=5

create trigger t8 
on student
after delete 
as
if format(getdate(),'ddd') = 'friday'
begin
select 'not deleted'
rollback
end


--xml for raw for simple query and group by 
--xml for auto for joins its the only one that understand the joins 
--xml for explict 
--xml for path when i need to mix between 1,2 ,, its the way that u read xml file
--@attrubute,"column" is a tag ,, column/column is a listed tag


use ITI 

from Course
for XML raw

select *
from Course
for XML raw('Courses')

select *
from Course
for XML raw('courses'),elements
select * from Course
for xml raw ('courses') , Elements ,root('ITI_COURSES')
