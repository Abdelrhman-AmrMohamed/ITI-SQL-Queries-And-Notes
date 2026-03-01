--local variables
DECLARE @x int
SET @x=100
SELECT @x

declare @x int=(select AVG(st_age) FROM student)

SELECT @x=9
SELECT @x

declare @y int,@name varchar(20)
select @y=st_age , @name=st_fname from student
where st_id=9
select @y,@name

declare @t table(x int,y varchar(20))
insert into @t 
select st_age , st_fname from student
where st_adress='alex'
select * from @t

declare @y int=2
select top(@y)* 
from student

declare @col varchar(20)='ins_name'
, @t varchar(20)='instructor'
execute('select' + @col + 'from'+@t)

execute('select * from student')


--GLOBAL 
select @@SERVERNAME , @@ERROR ,, @@ROWCOUNT ,, @@IDENTITY

-------------------------------------
--control of flow statments

declare @x int =10 
if @x > 0 
BEGIN 
	select('x>0')
END
else 
   select('x<0')

if exists (select name from sys.tables where name='students')--sys is a schema have all meta data of tables
	select * from students
else 
	select 'invaild table'

--to delete a column when need to ensure that the parent don't have a child 
use ITI
if not exists(select dept_id from student where dept_id=100)
	if not exists(select dept_id from Instructor where dept_id=100)
	 delete from Department
		where dept_id=100


begin try 
		delete from Department
		where dept_id=10
end try
begin catch 
	select'dept has a relationship'
	select error_line(),ERROR_MESSAGE(),ERROR_NUMBER()
end catch

declare @x int=10 
while @x<10 
	begin 
		select @x+=1
		if @x=14
		continue
		if @x=16 
		break
		select @x
end
select @x

select ins_name,
			case
			when salary>2000 then 'low sal'
			when salary<=2000 then 'high'
			when dept_id=10 then 'xxxxxxxxxx'
			else 'No Data'
			end
from instructor

select ins_name,
			case gender
				when 'm' then 'Male'
				when 'f' then 'female'	
			end
from Instructor

 --batch 
 insert
 delete 
 create 
 --script 
 create table 
 go
 drop table 
 go 
 create rule 
 go 
 sp_bindrule

 --transaction
 --set of queires executed m3 b3d (commit)aw t2of 5als (roll back)
 --check ss on the folder to see how to cycle going from query to ldf 

 create table parent (id int primary key)

 create table child (cid int foreign key references  parent(id))
 insert into parent values(1)
 insert into parent values(2)
 insert into parent values(3)

 begin try
	begin transaction
	insert into child values(1)
	insert into child values(5)
	insert into child values(3)
 commit
 end try
 begin catch
 rollback
 end catch

 --VERY IMPORTANT
 truncate table child
 select * from child



 --built in function m3rofa w hsearch lw a7tagt 7aga isa
 --user defiend function
--scalar -

create function getsname(@id int)
returns varchar(20)
begin
declare @name=st_fname
from student
where @id=st_id
return @name
end

select dbo.getsname(1)

create function getsid(@name varchar(20))
returns int 
begin 
declare @id=st_id
from student
where @name_st_fname
return @id
end

select dbo.getsid(abdo)

--inline 

create function getins(@did int)
returns table 
as return(
select ins_name,salary*45 as total
from Instructor
where Dept_Id=@did
)

select * from getins(10)


create function gettable(@did int)
returns table
as 
return
(	
	select * from Instructor
	where Dept_Id=@did
)

select * from gettable(20)



--multi statment using select statments

create function getstuds(@format varchar(20))
returns @t table(
id int,
name varchar(20)
)	
AS 
BEGIN 
if @format='first'
	insert into @t 
	select st_id,st_fname from student
else if @format='last'
	insert into @t 
	select st_id,st_lname from student
else if @format='full'
insert into @t 
	select st_id,st_fname+ ' '+st_lname from student
	return
END 

SELECT name AS TableName
FROM sys.tables
ORDER BY name;

select * from getstuds('full')


create function getsoldiers(@format varchar(20))
returns @t table (
	id int, name varchar(20)
)
as 
begin
if @format='firstname'
insert into @t 
select st_id,st_fname from soldiers
else if @format='lastname'
insert into @t 
select st_id,st_lname from soldiers
else if @format='fullname'
insert into @t 
select st_id,st_fname+''+st_lname from soldiers
return 
end

select * from getsoldiers('firstname')
select * from getsoldiers('lastname')
select * from getsoldiers('fulltname')

--windowing functions 

select sname, grade,
x=lag(sname) over(order by grade)
y=lead(sname) over(order by grade)
w=FIRST_VALUE(sname) over(order by grade)	
z=LAST_VALUE(sname) over(order by grade)	
x=lag(sname) over(partition by department order by grade)
y=lead(sname) over(partition by department order by grade)
w=FIRST_VALUE(sname) over(partition by department order by grade)	
z=LAST_VALUE(sname) over(partition by department order by grade)	

select * from(
		x=lag(sname) over(partition by department order by grade)
y=lead(sname) over(partition by department order by grade)
w=FIRST_VALUE(sname) over(partition by department order by grade)	
z=LAST_VALUE(sname) over(partition by department order by grade) as windowfunc
where sname='eman'

/*
 „—Ì‰ 1 (Scalar Function):
«⁄„· œ«·… Scalar Function  ” ﬁ»· @salary Ê —Ã⁄:

'Low' ·Ê √ﬁ· „‰ 2000

'Medium' „‰ 2000 ·Õœ 5000

'High' √ﬂ»— „‰ 5000*/

CREATE FUNCTION getsalary(@sal int)
RETURNS VARCHAR(20)
BEGIN
   DECLARE @CATEGORY VARCHAR(30)
   SET @CATEGORY =
				CASE 
				WHEN  @sal < 2000 THEN 'LOW'
				WHEN  @sal < 5000 AND @sal >2000 THEN 'MEDIUM' 
				WHEN  @sal > 5000 THEN 'HIGH'
				END   
 RETURN @CATEGORY
END



CREATE FUNCTION GetDeptEmployee(@DeptIt INT)
RETURNS table   --«·€·ÿ Â‰« ≈‰ﬂ ⁄«„· Table-Valued Function° Ê·«“„ ·„«  —Ã⁄ œ« «  ⁄„· RETURN ·Ã„·… «·‹ SELECT „»«‘—…° Ê„Ì‰›⁄‘  ÕÿÂ« ﬂœÂ ÃÊÂ «·‹ BEGIN Ê END.
	AS 

RETURN
(
	SELECT emp_name , dep_id 
	FROM employee
	WHERE @DeptIt=dep_id 
)

CREATE FUNCTION gettable(@empid int)
returns @t (dep_name int 
, emp_name varchar(20),
emp_id int ) 
as
Begin 
insert into @t 
	select dept_nae, emp_id , emp_name 
		from employee
	where empid=employee_id
return
end