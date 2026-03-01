use ITI  
create table emp(
eid int identity (1,1) ,
ename varchar(20),
eadd varchar(20) default 'alex',
hiredate date default getdate(),
sal int,
overtime int,
netsal as (isnull(sal,0) + isnull(overtime,0)) persisted,
bd date,
age as (year(getdate())-year(bd)),
gender varchar(1),
hour_rate int not null,
did int,
constraint c1 primary key (eid,ename),
constraint c2 unique (sal),
constraint c3 unique(overtime),
constraint c4 check(sal>1000),
constraint c5 check(eadd in ('alex','cairo','mansoura')),
constraint c6 check(gender='f' or gender='m'),
constraint c7 check(overtime between 100 and 500),
constraint c8 foreign key (did) references Department(dept_id)
		on delete set null on update cascade  
)

alter table emp add constraint c232 check(hour_rate >100)



alter table emp drop constraint c3 





--add constraint apply only on new data 34an lw get 3mlt constaint 3la data mwgoda hyrfod yt3ml f b3ml rule tapply l constraint 3la data l gdeda
--add constraint shared on 2 tables
--add data type with default and constraint
--all of it applied by rule 


create rule r1 as @x>2999
sp_bindrule r1, 'emp.sal'
sp_bindrule r1, 'Instructor.salary'

drop rule r1
sp_unbindrule r1, 'emp.sal'
sp_unbindrule r1, 'Instructor.salary'

create default d1 as 4999
sp_bindefault d1 , 'emp.sal'

sp_unbindefault d1 , 'emp.sal'
drop default d1


--to create complex data type (its int and <1000 and default = 5000)

create rule r2 as @>1000
create default d2 as 4000
sp_addtype complexDB, 'int'
sp_bindrule r2 , complexDB
sp_bindefault d2,complexDB



create table testbind(
id int,
salary complexDB --ican use this data type in diff tables ,, column take only one rule if u make another rule it will get overwrite ,, column can take constraint and rule but constraint applied first then rule
) --rule is alternative for check constraint 



