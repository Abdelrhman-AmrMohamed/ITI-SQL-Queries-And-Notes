declare @x int=(select avg(st_age) from student)
set @x=100
select @x=8
select @x

declare @y int,@name varchar(20)
select @y=st_age,@name=st_fname from Student
where st_id=8
select @y,@name


declare @y int=100
select @y=st_age from Student
where st_address='alex'
select @y


declare @t table(x int,y varchar(20))
insert into @t
select st_age,st_fname from Student
where st_address='alex'
select * from @t

declare @y int=2
select top(@y)*
from student


declare @col varchar(20)='ins_name'
       ,@t varchar(30)='instructor'
execute('select '+@col+' from '+@t)


execute( 'select * from Student')

--Global
select @@SERVERNAME


update student
set st_age+=1
select @@rowcount

select * from topic
select @@ROWCOUNT
select @@ROWCOUNT

select * from topic
go
select @@error

create table test1
(
id int identity,
name varchar(20)
)

insert into test1 values('eman')
select * from test1

select @@identity

---Control of flow statments
--if
declare @x int=10
if @x>0
	begin --bdl l {} fl if else y3ny
	select 'x>0'
	end
else
	select 'x<0'

--if exists

if exists(select name from sys.tables where name='student') --sys deh schema feha l meta data 
	select * from student
else
	select 'invalid table'

if not exists(select dept_id from student where dept_id=100)
	if not exists(select dept_id from instructor where dept_id=100)
		delete from Department
		where dept_id=100

begin try
		delete from Department
		where dept_id=10
end try --try catch na m4 3arf l error blzbt mmkn ygele mnen 
begin catch
	select 'Dept has relationship'
	select ERROR_LINE(),ERROR_MESSAGE(),ERROR_NUMBER()
end catch


declare @x int=10
while @x<20
	begin
		select @x+=1
		if @x=14  --htl3 11 12 13 15 34an 3nd 14 htl3 fo2 tany w 3nd 16 htbreak nl loop
			continue
		if @x=16
			break
			select @x
	end




--begin
--end
--while
--continue
--break
--case
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



update Instructor

	set salary =
			case 
			when salary>=3000 then salary*1.30
			else salary*1.20
			end
where salary is not null

--iif
--choose
--waitfor

--diff between batch script transaction l batch 4wyt code sql ynf3 yrun m3 b3do anma l script sql mynf34 ytrun m3 b3do 1.13 4of l vid 34an t3rf t3nl script
--4of l vid 34an mohm gdn ltransaction w 7lwa gdn
--Built in functions
select Coalesce(st_fname,st_lname,'Nodate')
from student

isnull
nullif----

select db_name()
select suser_name()


select st_fname+convert(varchar(20),st_age)
from student

select st_fname+cast(st_age as varchar(20))
from student

select convert(varchar(30),getdate(),101)
select convert(varchar(30),getdate(),102)
select convert(varchar(30),getdate(),104)

select dept_name,format(Manager_hiredate,'yyyy')
from Department

select format(getdate(),'MM')

select month(getdate())
 
 select concat(st_fname,' ',st_age,NULL)
 from Student

 select max(st_age)
 from Student

 select count(st_id),count(st_lname)
 from Student

 select power(salary,2)
 from Instructor

 select len(st_fname)
 from Student

 select substring(st_fname,1,3)
 from Student

 --scalar
 --string getsname(int id)
 create function getsname/*name of function*/(@id int) /*l variable ele hta5do*/
 returns varchar(30) --type of return value
 begin
	declare @name varchar(30)
	select @name=st_fname
	from Student
	where st_id=@id
	return @name
 end

 select dbo.getsname(1) --call the function ,, u must write the name of schema cuz its a scalar function cuz its return a one value like the v=
 --built in function so from now we must call the function using schema name

 alter schema hr transfer dbo.getsname

 select *
 from Instructor
 where ins_name=dbo.getsname(1)



 select *
 from company.dbo.project

 --inline
 create function getins(@did int)
 returns table
 as
 return
 (
  select ins_name,salary*12 as total
  from Instructor
  where dept_id=@did
 )

 select ins_name from getins(10)--select * from cuz its return a table 
where total>9000
 --multi ,, 3awz a3ml function lw ktptlha f name yrg3le kol l f name l kol l students ktptlo age arg3lo kol l ages ll students
 create function getstuds(@format varchar(10))
 returns @t table
			(
			 id int,
			 name varchar(30)
			)
AS
BEGIN
	if @format='first'
		insert into @t
		select st_id,st_fname from Student
	else if @format='last'
		insert into @t
		select st_id,st_lname from Student
	else if @format='full'
		insert into @t
		select st_id,st_fname+' '+st_lname from Student
return 
END

select * from getstuds('FULL')

--l windowing function mohma gdn (lag , lead ) ele 2ble wle b3de depend on order mo3yn 2:45 vid 34an t4of l syntax 
select sname , grade ,
	x= LAG(sname) OVER(ORDER BY grade),
	y= LEAD(sname) OVER(ORDER BY grade)
FROM grades 
--btt3aml mo3mlt l ranking function 
select * from (
				select sname , grade ,
	x= LAG(sname) OVER(ORDER BY grade),
	y= LEAD(sname) OVER(ORDER BY grade)
FROM grades ) as t 
where sname='eman'
--w a22dr kman ast5dm parition by 
x= LAG(sname) OVER(PARTITION BY Department ORDER BY grade),
	y= LEAD(sname) OVER(PARTITION BY Department ORDER BY grade)
	--hypartition by l depatment w yorder by l grade b2a
		select sname , grade ,
	FIRST= FIRST_VALUE(sname) OVER(ORDER BY grade),
	LAST= LAST_VALUE(sname) OVER(ORDER BY grade)

	FIRST= FIRST_VALUE(sname) OVER(PARTITION BY Department ORDER BY grade),
	LAST= LAST_VALUE(sname) OVER(PARTITION BY Department ORDER BY grade)