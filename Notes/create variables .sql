--local variables for batch,function,stored procedure

declare @x int=100
select @x

use ITI
declare @x int= (select avg(st_age) from student)
select @x

declare @x int 
set @x=200
select @x

select @x=9
select @x

select @x int ,@name varchar(20)
select @x=st_age ,@name=st_fname from student 
where st_id=8
select @x,@y

declare @t table(x int , varchar(20))
insert into @t
select st_age , st_fname from student 
where st_address='alex'
select * from @t  --2D array

use ITI
declare @col varchar(20)='ins_name'
       ,@t varchar(30)='instructor'
execute('select '+@col+' from '+@t)

execute('select * from student')


-----------global variables

select @@SERVERNAME
select @@VERSION

update student
set st_age+=1
select @@ROWCOUNT --num of row effected

select * from tobic
go 
select @@error --return num of last error happend in server 

create table test9(
id int identity,
name varchar(20)
)
insert into test1 values('eman')
select * from test1

select @@IDENTITY