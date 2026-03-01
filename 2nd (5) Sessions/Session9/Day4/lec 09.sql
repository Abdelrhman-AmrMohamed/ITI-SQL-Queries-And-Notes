--lec 09
--there are 3 types of stored procedures 
--built in sp, user defined sp, triggers
--l sp mofed fl security 34an lw na 3aml button bgep be msln select * from student hyzhr llhack anma lma a3ml sp fe l query dh l hacker
--m4 hy4of l query just asm l procedure w kmaan l veriables m4 zahra	
--l sp mohm 34an lma age ados 3la l button dh myro74 kol 4wya y3ml nfs l flow fl ss ele hwa querry , parsing ele hwa syntax
--optimize ele hwa yklm schema l sys w y4of l metadata , query tree ele hwa l path l s7 , execution plan ele hwa memory 
-- f bdl ma y3ml kol dh kol mydos 3la button y7oto f sp w yt5zn fl engine
--l sp 3ks l function wl view a22dr aktp gwaha kol 7aga w 5sosn dml
--benefits of sp
--1- as asecurity bt5fe asam3e l objects zy ma kant view w function by3mlo
--2 bta5od parametere zy l function
--3 m4 goz2 ml query b3mlha call bs w dh byzwd l security
--4 l query tree bytsave gwa l server m4 m7tag am4e fl flow parsing w optimize .. etc
--5 3dd l char 3la lnetwork traffic 2olyla f performance a7la hwa asm l sp wl variables bs 
--6 a22dr amn3 l errors
--7 a22dr aktp kol 7aga a5tha gwa l sp
--8 a22dr a5fe l business rules .. a22dr a5fe l logic bta3 mortp mo3yn msln 3n l user w na bs a5od mno l id


--3 types of sp 
 
--1 built in  ai 7agabtbd2 b sp
sp_bindrule --btbind l rule ele hya rule baseta bt2ole msln @x<20 msln f deh btbind l rule deh m3 l column
sp_unbindrule -- bt4el l rule deh
sp_helpconstraint --hwrek kol l constraints 3la table mo3yn 
sp_rename --b8yr beha asm ay object
sp_addtype -- create new datatype manual wdeh 2adema l gdeda ahe CREATE TYPE PhoneNumber FROM VARCHAR(15) NOT NULL;


---2) user defined

create proc getst
as
	select*
	from student 

--to call it 
getst
--or 
execute getst --optional bs fe 7alat mo3yna hkon mogbr 3leha 

--22dr ab3tlha parameter w ast5dmo 
create proc getstbyaddress @add varchar(20)
as
	select st_id, St_Fname, St_Address
	from Student
	where St_Address = @add

getstbyaddress 'alex'

--mmkn aktb gwaha dml 
-- w mmkn ytl3 m3aha error tabe3y 
insert into Student(St_Id,St_Fname)
values (663,'ali') --kan mmkn ytl3 error lw fe student id bnfs el id da 
--zy brdo lw get 3mlt delte wna 3ndy constraints hytl3 error 
delete from Student where St_Id =2

--7aga exculsive lel sp 3ks el view w el function 
--ene aktb code kamel ahndel beh ai error lel dml

create proc instst @id int, @name varchar(20)
as
	insert into Student(St_Id,St_Fname)
	values (@id,@name) --dynamic insert


	instst 10,'ali' --error due to pk constraint
	--el error hna feh m3lomat 3n el db w da security wise msh s7

--hna akbr momyzat el sp ene 22dr aktb code yhandelel error 
--msln lw f dublicate w na bselect w insert id w name 3la web site msln f a7otha f try catch 
alter proc instst @id int, @name varchar(20)
as
	begin try
	insert into Student(St_Id,St_Fname)
	values (@id,@name) --dynamic insert
	end try
	begin catch
		select 'error'
	end catch
	--keda lw fe error hytb3 klmt error bs 

	--sp calling 
	create proc sumdata @x int, @y int 
	as
		select @x+@y

sumdata 3,9			--call by parameter position 
sumdata @y=9, @x=3  --call by parameter name

--sp paraemeters can have default value
alter proc sumdata @x int = 100, @y int =200
	as
		select @x+@y


sumdata 3,9 --12
sumdata 3	--203
sumdata		--300
sumdata @y=3	--103	

--lw 3ayz ast2bl el nateg bta3 el sp fe table w at3aml m3ah 

create proc getstbyage @age1 int, @age2 int
as
	select St_Id, St_Fname
	from Student
	where St_Age between @age1 and @age2

getstbyage 23,28 --table result

--insert based on execute  zy l insert based on select bs l select hna fl sp 34an kda lazm hna nktp execute

create table tab4 (id int primary key, firstname varchar(20))

insert into  tab4 (id, firstname)
execute getstbyage 23,28

select* from tab4

--lw 3ayz arg3o fe variable mn no3 table 
declare @t table (x int , y varchar(20))
insert into @t
execute getstbyage 23,28
select COUNT(*) from @t
---------------------------------
--lw kan el rag3 mn el sp execute hwa one value bs?
--mmkjn ttktb shbah el scalar function 


create proc getdata @id int 
as
	declare @age int 
	select @age =St_Age
	from Student
	where St_Id = @id
	return @age	


--h3ml variable a5od feh el sp execute return 
declare @x int
set @x = execute getdata 3 
select @x

--el sp return lazm ykonm one value w lazm ykon int bs 3ks el function
--bnst5dmo 3lshan n return value y3br 3n behaviour mo3yn ll sp ,, y3ny na wl application developer h2olo lw tl3tlk 100 dh kda pk error w etc
--el fr2 ben el return value of fun( btrg3 rkm mn el function ) + a22dr arg3 ay data type ml function
--el return value of sp (by3br 3n behaviour el sp)

--lw 3ayz a rg3 7aga mn el sp a7ot feha output parameter zy el call by reference ,, hdehomlk null aw 0 w trg3hom b values a22dr ast5dmha f ay 7aga
alter proc getdata @id int, @age int output, @name varchar(20) output
as
	select @age =St_Age, @name =St_Fname
	from Student
	where St_Id = @id


declare @x int,@y varchar(20)
execute getdata 3, @x output, @y output
--select @x,@y
--w mmkn @x,@y dol mmkn ast5dmhom ka input parameter le sp tanya bt insert msln 
--execute instst @x, @y
execute instst @x, @y


---------------------------------------
--fe 4 anwa3 mn el sp parameters (return, input, output, input-output)
/*el input output da ana bst3;l el output parameter ene ab3t m3ah value ast5dmha fel sp 2bl ma el parameter da el value bta3to tt3;y mn el query 
fa bma en el where btsht3'l 2bl el select fana mmkn ab3t m3ah value ll where w tst5dmha 2bl me el select t3'yro, w keda yb2a esmo input oupt parameter*/
--34an l where bt4t3'l 2bl l select f ana adetha value rkm 3 fl where w tl3t at8yrt fl select fo2 3la 7sp l id rkm 3
create proc getdata2  @age int output, @name varchar(20) output
as
	select @age =St_Age, @name =St_Fname
	from Student
	where St_Id = @age


declare @x int = 3,@y varchar(20)
execute getdata2 @x output, @y output
select @x,@y
------------------------------------------------------

--22dr a3ml dynamic query bel sp w lkn da msh kwis 3la el security wise 3lshan bb3t asamy el objects 
alter proc getalldata @col varchar(20), @tab varchar(20)
as
	execute ('select '+@col+'from '+@tab)

getalldata '*','student'
--dh kda by5lene a5od ay column w table w atl3holo r8m ano 8lt aw m4 hytda yt3mlo run m 8er klmt execute
-------------------------------------
--momyzat el stored procedure 
--bktb feha kol el querries dml w kolo
--security wise a7sn msh hyshof asamy el objects
--y3ny la shayf el metadata wla shayf ana b3ml a
--performance on network wise a7sn less charchters 
--performance on server wise a7sn l2ne mshmodtr a3ml kol mara7el el process el awlya zy el parsing w el optimize wel query tree
--flexability ene mmkn adelo parameter w arg3 mno outtput parameters 
--felexability ene a try catch el errors 3la el data base 
--22dr a handel el business rules b3ed 3n el application 
--mezet el function enha mmkn tb2a goz2 mn el query bkolsohola w fe ai 7eta fel query 
-----------------------------------------------
--                      TRIGGER
--trigger is special type of sp 
--m2drsh a3mlha call wla 22dr ab3tlha parameter
--hwa 3obara 3n implicit code by listen actions elle bt7sl fel server 
--fe triggers 3la mostawa el table 
--implicit code bysht3'l lma action mo3yn y7sl 
--elle 3la mostawa el table by7sl m3 el insert, update , delete w msh el truncate l2no msh dayman bytktb fel log file 
--3ndy 2 types of table triggers (after(for), instead of)
--note kda mohma an kol object bytcreate 3la asas 7aga y3ny l constraint bytcreate 3la column wl column 3la table w table 3la schema w schema 3la db w db 3la server w users w login 3la servers
insert into Student (St_Id, St_Fname)
values (77,'ali')

create trigger t1
on student
after insert
as
	select 'inserted'

t1 --can't call triggers just htzhr after insert 

create trigger t2
on student
for update --mmkn aktb for bdl after
as 
	select GETDATE()

update Student
set St_Age +=1


--mmkn ast5dm el trigger insted of permission ene amn3 el en 7aga mo3yna t7sl 3la el table
create trigger t3
on student 
instead of delete
as 
	select 'not allowed for user: '+ suser_name()

delete from student where st_id= 1



--ele gaya deh mmkn ast5dmha ene msh 3ayz 7d y3dl ai 7aga (read only table)

create trigger t4 
on department
instead of delete, update, insert
as
	select 'Read Only'

delete from Department where Dept_Id=10
update Department set Dept_Name = 'ali'
insert into Department (Dept_Id, Dept_Name)
values (1000,'lol')

-------------------------------
-- note :
--lw el query 3'lt fa msh hyl72 ywsl ll trigger asln fa 3ady
--tyb lw el query didn't affect any rows in table?? TRIGGER will be triggered also y3ny na 7attlo id 8lt 3ady l trigger hy4t8l

--el trigger bya5od el schema bta3t el table elle et3mnl 3lih automatically 

alter trigger itistud.t5 
on itistud.course 
instead of delete 
as 
	select 'noooo'

--el update mtlwna a7mr y3ny hya function 
--mmkn ast5dmha ka function gwa el sp 

--y3ny msln lw 3ayz ash3'l el trigger lma y7sl update le col mo3yn bs gwa el table, w mysht3'lsh lw 7sl ai update le ai col 3'ero, use UPDATE as FUNCTION

create trigger t6 
on student
after update
as 
	if UPDATE(st_age)
	select'age updated'

update Student 
set St_Age+=1  --triggered

update student 
set St_Fname = 'muhammad'
where St_Id = 10 --not triggered hytupdate 3ady bs m4 hytl3lk statment zy l age updated 34an 
--na 2ayl an l trigger ytl3 lma a3ml update 3la l age bs 
--lw 3ayz a22f el trigger 
--mmkn a3mlo drop 
drop trigger t1
--aw mmkn aw2f sho3'lo bs lkn hwa yfdl mwgod (disable)
alter table student disable trigger t2

alter table student enable trigger t2

----------------------------------
--ahm meza fel trigger hya el audioting 
--ene b3ml tracing lel db , men 7awl y3ml a fel query 
--kol fire lel trigger byt created m3ah 2 tables : inserted table, deleted table 
--bykono shabah el table elle et3ml 3lih el trigger (nfs el metadata)
--lw b3ml update : inserted feh el data el gdeda, deleted feh el data elle etms7t w etbdlt 
--tb3n dol bytcreato gwa el tempdb w bytms7o tany  

create trigger t7 
on student
after update
as 
	select * from inserted
	select * from deleted

	
	--rg3 l updated value and deleted one
update Student 
	set St_Fname = 'muhammad'
	where St_Id = 5

--trae2a tanya ene arg3 el dleted valuefrom update 

declare @x varchar(20)
update Student 
set St_Fname = 'Lolo', @x =st_fname
where st_id= 4
select @x
------------------------------------
--lw 3ayz amn3 en el user yms7 ai course byta5d yom el gom3a 

--1
create trigger t8
on itistud.course 
after delete 
as
	if FORMAT(getdate(),'ddd') = 'friday'
	begin
	select 'not deleted'
	--rollback 
	--wl tre2a l tanya 
	insert into Course 
	select *from deleted
	end
	
--2
create trigger t9
on itistud.course
instead of delete
as
	if FORMAT(getdate(),'ddd')!='friday'
	begin
		delete from itistud.course where Crs_Id = (select Crs_Id from deleted)
	end 
	else 
		select 'not to delete fridays courses'
		--l insteadof aw after l atnen l data btro7 fl tables l instered wl deleted 
----------------------------
--el inserted w el deleted bytms7o m3 el query lma y5ls 
--3ayz acreate table ysgl feh el history bta3hom msln lw 7d 7awl y3ml update 3la id fe gdwl el topic ymn3o w ysgl el m3lomat bta3t el query da fe gdwl 
--tp msln lw 3mlt update llname bos kda kda instead of htmn3 kol l updates 3la l table wlakn na hsgl amta l values deh lw 3ml update 3la l topic id
create table history
(
_user varchar(20),
_date date,
_oldid int,
_newid int
)

alter trigger t11
on Topic
instead of update
as
	if update(Top_Id)
	begin
	declare @old int, @new int
	select @old =Top_Id from deleted
	select @new =Top_Id from inserted
	insert into history
	values (suser_name(),getdate(),@old,@new)
	end


select * from history --deosn't work

---------------------------------------------
--runtime trigger 
--Output Keyword, make a runtime trigger exclusive only to the trigger and ends by the end of it
--mmkn ast5dm m3aha inserted w deleted 3ady 34an dol tables sapten
--mmkn a7ot el natg bta3hom fe coloumn 3ady 
alter table student disable trigger t2,t3,t6,t7,ti

delete from Student
output getdate(), deleted.St_Id --dh hytl3 l tare5 wl id ele kont 3awz t3mlo delete
where St_Id = 777

delete from Student
output getdate(), deleted.St_Id into history (_date, _oldid)
where St_Id = 77

	
select * from history
--------------------------------------------
--                      XML

--xml 3opara 3n waset ma ben l diff server
--y3ny 3awz a3ml join ma ben orcale w microsoft sql
--f h3ml xml w abd2 ane a7wl b2a l xml l orcale aw l microsoft sql
--4 types of xml 
--1 , for xml raw --using for query only or group by
--2 , for xml auto -- when there is a join its the only one who understand the join
--3 , for xml explict --search ,,its for when u need to mix between 1st and 2nd
--4 , for xml path ,, its the way to how read xml file  ,, its for when u need to mix between 1st and 2nd
-- @ is for attribuite ,, "column" is a tag ,, column / column is a listed tag its the xpath expreission (brsm l xml)

/*
The first index on an XML column is the 
"primary XML index". Using it, three types of 
secondary XML indexes can be created on the 
XML column to speed up common classes of queries
*/
--CREATE PRIMARY XML INDEX idx_xCol 
--on docs (xCol)

----------------------------------------------------------
SELECT pk, xCol
FROM   docs
WHERE  xCol.exist ('/book[@genre = "security"]') = 1
/*
secondary XML index of type PATH is helpful for this workload
*/
------------------------------------------------------------
CREATE XML INDEX idx_xCol_Path 
on docs (xCol)
USING XML INDEX idx_xCol 
FOR PATH
--------------------------------------------------------------------
CREATE XML INDEX idx_xCol_Property 
on docs (xCol)
USING XML INDEX idx_xCol 
FOR PROPERTY
--------------------------------------------------------------------
SELECT xCol
FROM   docs
WHERE  
xCol.exist ('//book/@ISBN[. = "0-7356-1588-2"]') = 1
/*
a partial path is specified using //, so that the lookup based 
on the value of ISBN could use the VALUE index
*/
-------------------------------------------------------------------
CREATE XML INDEX idx_xCol_Value 
on docs (xCol)
USING XML INDEX idx_xCol 
FOR VALUE
-----------------------------------------------------------------------
CREATE FUNCTION udf_get_book_ISBN (@xData xml)
RETURNS varchar(20)
WITH SCHEMABINDING
BEGIN
   DECLARE @ISBN  varchar(20)
   SELECT @ISBN 
		 = @xData.value('/book[1]/@ISBN', 'varchar(20)')
   RETURN @ISBN 
END
----------------------------------------------------------------------
ALTER TABLE docs
ADD   ISBN --calculated column name
AS dbo.udf_get_book_ISBN(xCol)
----------------------------------------------------------------------
select * from docs
----------------------------------------------------------------------
SELECT pk, xCol
FROM   docs
WHERE  xCol.exist ('/book[@ISBN = "0-7356-1588-2"]') = 1


SELECT pk, xCol
FROM   docs
WHERE  ISBN = '0-7356-1588-2'
--using the new column
----------------------------------------------------------------------
INSERT INTO docs 
VALUES 
(2,'<book genre="testing" publicationdate="2002" ISBN="0-7356-1588-1">
   <title>Writing  Code</title>
   <author>
      <first-name>M</first-name>
      <last-name>H</last-name>
   </author>
   <author>
      <first-name>A</first-name>
      <last-name>B</last-name>
   </author>
   <price>40.99</price>
</book>')
-----------------------------------------------------------------------
select * from docs

--now lets transfer from xml to db
--5 steps 
/* 
1st -- make a variable his type is xml and save the xml in that variable 
2nd -- make an variable his type is int 
3rd -- path this 2 variables to sp_xml_preparedocument this is draw the tree(create memory tree)
the variable is a handler or a pointer that point on the root w ynd2 ynzl 3la l tree to make sure an l xml s7
4th -- select * from xml file using the handler

*/
declare @docs xml = --xml path
declare @hdocs int 
Exec sp_xml_preparedocument @hdocs output , @docs
select * into itistuds
	from openxml (@hdocs, '//Student') --select all data which has a tag named student
	WITH(id int '@studentid', /* w a7ot l columns bta3ty bl tre2a ele hya m7tota fl xml*/
	(/*asm l collumn */)address varchar(20) 'Adress',
	stufirst varchar(30) 'studentname/first' /* tl3 student name l first b2a */,
	stusec varchar(20) 'studentname/last'  /* tl3 student name l second b2a */
	)
	-- w aktp fo2 b2a insert into iti kda ana 7atet l xml into table
	select * from itistuds

--5th step ane ams7 l tree ele atrsmt fl memory
exec sp_xml_removedocument @hdocs

	


