--view
--IS A select statment
--ï	Simplify construction of complex queries
--ï	Specify user view
--ï	Limit access to data [grant revoke]
--ï	Hide names of database objects [table name and columns]
--ï	increase performance

--types of views
--Standard view ,, bde name ll query bta3e 34an lw 7sl hack w 7d 2al msln drop Vcairo m4 ht7sl 7aga asln 34an mfe4 table asmo Vcairo
--kman a22dr ade msln l users l cairo data l cairo bs 
create view vCairo
select * from student where address='cairo'
--create view vAlex
select * from student where address = 'alex'

--join between views
create view vall 
as 
select * from vCairo
union all
select * from vAlex
-- f kda adet l kol user ldata ele hy4t8l 3leha bs 
--partitioned view -- hya hya bs m 2 servers mo5tlfa 
--indexed views -- by5zn l view as a real table in db w dh by7sn l performance dh lw7ed f type l views 
CREATE VIEW SalesSummaryIndexed
WITH SCHEMABINDING
AS
SELECT Region, SUM(Amount) AS TotalAmount, COUNT_BIG(*) as cnt
FROM dbo.Sales
GROUP BY Region;
GO

-- Â‰« »ﬁÏ ‰⁄„· Index
CREATE UNIQUE CLUSTERED INDEX IDX_SalesSummary
ON SalesSummaryIndexed(Region);
--Indexed View = View + Clustered Index = View „ Œ“‰ “Ì ÃœÊ·.

create view v2(studept_name,dept_name) -- alias name ll columns 34an l security b2a kda agmd f3ln  --na la 3nde studept name wla v2 7agat deh kolah virutal
as
	select st_fname,dept_name
	from student s,department d
	where	s.dept_id=d.dept_id
	and s.st_address='cairo'
	--3mlt join w 7atteha gwa view w adet allias name llcolumns bta3ty
select * from v2
select studept_name from v2

drop view v1
create view v3 --f user byt3aml m3 2 tables a3mlo union all w  a7othom f view
as 
	select st_fname from student
	union
	select dept_name from department
--a22dr a3ml join ma ben l view wl table 3ade 
create view jointableview 
as
select * from vall v inner join course c
on v.id=c.id

--ele gy dh v4 paritioned view
create view v4 as 
select * from mans_server .iti.dbo.students 
union all 
select * from sohag_server.iti2.hr.students

--insert through a view if:
----All the affected columns belong to one table
----All the columns not named in the view either allow NULLs
----or have default clauses, or IDENTITY or calculated 
--ml a5r a22dr a3ml dml 3la l view 3la l columns ele 2odame bzbt 
--5sosn l insert lazm lw hinsert columns kol ele fl table bs lw f 7aga m7ttha4 lazm tkon identity aw default value aw driven fahm 34an mtkon4 7aga bnull

--update if:
----All the affected columns belong to one table

--delete if:
----The view is based on only one table so i can't delete when view have a inside it join
--m2dr4 adelete view f join 
-- insert w update m4 hy4t8lo 3la multi table brdo ele hya join lazm a3dl f table wa7d bs
sp_depends v2
sp_help v2
sp_helptext v2
sp_rename v2,v10
select * from v10

--LIMITATIONS
--CANT USE AGGREGATE FUNCTION ON VIEWS
--CAN USE COMPUTE OR COMPUTE BY
--CANT USE ORDER BY eXCEPT IF U USE IT WITH tOP



--ENCRYPTED VIEW --34an lw 3mlt sp_helptext hy3rdly l code ele at3mlt beha l view
CREATE VIEW V1
WITH ENCRYPTION
AS
SELECT * FROM Student

SP_HELPTEXT V1

--INDEXED VIEWS
--U CAN CREATE INDEX ON VIEW AS ON TABLES
-- 3 cases we call table by its schema when i created scalary function and index view and lw bread table m server aw db tanya 
--U CAN CREATE PARTITIONED VIEWS
--PARTITIONED VIEWS COMBINE DATA FROM DIFFERENT SOURCES --bgeb data m 2 diff servers
--with check option
----working with inset update only
alter view v13
as
	select st_id,st_fname,st_age
	from student
	where st_age=20
	with check option --y3ny lma tege tinsert ay 7aga lazm tinsert zy ele fl where condition

select * from v13

insert into v13 
values(111,'ali',33)

update v13
set st_age=30
where st_age=20
--------------------------------
---------------------------------
--CTE
with cte (did,cnt)as
(
select dept_id,COUNT(dept_id)
from Student
group by Dept_Id
)
select *,(select COUNT(*) from cte) from  cte
