--rollup , cube  , grouping sets,  pivot,  unpivot

use test

create table sales
(
ProductID int,
SalesmanName varchar(10),
Quantity int
)
truncate table sales

insert into sales
values  (1,'ahmed',10),
		(1,'khalid',20),
		(1,'ali',45),
		(2,'ahmed',15),
		(2,'khalid',30),
		(2,'ali',20),
		(3,'ahmed',30),
		(4,'ali',80),
		(1,'ahmed',25),
		(1,'khalid',10),
		(1,'ali',100),
		(2,'ahmed',55),
		(2,'khalid',40),
		(2,'ali',70),
		(3,'ahmed',30),
		(4,'ali',90),
		(3,'khalid',30),
		(4,'khalid',90)
		
select ProductID,SalesmanName,quantity
from sales

select SalesmanName as Name,sum(quantity) as Qty
from sales
group by SalesmanName

--rollup bta5od natg l query w tnfz 3leh nfs l function 3la natg l query (3la l column ele na 7ato fl aggregation function) ,, l rollup bt4t8l 3la awl column bs
union
select 'Total Values',sum(quantity)
from sales


Select isnull(Name,'Total'),Qty
from ( 
select SalesmanName as Name,sum(quantity) as Qty
from sales
group by rollup(SalesmanName)
) as t



use BikeStores 
select SalesmanName as Name,sum(quantity) as Qty
from sales
group by rollup(SalesmanName)
		

select SalesmanName as Name,Count(quantity) as Qty
from sales
group by rollup(SalesmanName)
		

--order by ProductID,SalesmanName
select ProductID,sum(quantity) as "Quantities"
from sales
group by rollup(ProductID)




select ProductID,SalesmanName,sum(quantity) as "Quantities"
from sales
group by ProductID,SalesmanName

select ProductID,SalesmanName,sum(quantity) as "Quantities"
from sales
group by rollup(ProductID,SalesmanName)


select SalesmanName,ProductID,sum(quantity) as "Quantities"
from sales
group by rollup(SalesmanName,ProductID)

select ProductID,SalesmanName,sum(quantity) as "Quantities"
from sales
group by Cube(ProductID,SalesmanName)
--l cube hygm3 kol 7aga ,, total l performance lkol product
-- w total l performance l kol salesman
--w total l performance asln 
--lma a3ml except b2a l natg dh ml group by l aslya hydene l 8 columns ele hwa total performance m3 kol product id w total performance m3 kol salesname deh asmha grouping sets
select ProductID,SalesmanName,sum(quantity) as "Quantities"
from sales
group by cube(ProductID,SalesmanName)

--order by ProductID,SalesmanName


select ProductID,SalesmanName,sum(quantity) as "Quantities"
from sales
group by cube(ProductID,SalesmanName)
--order by ProductID,SalesmanName

--grouping sets -- akne b3ml cupe except l group by l 3ady ydene l analysis bs y3ny ,, by3ml rollup 3la l columns ele  bt7otha
select ProductID,SalesmanName,sum(quantity) as "Quantities"x
from sales
group by grouping sets(ProductID,SalesmanName)


----Pivot and Unpivot OLAP
--if u have the result of the previouse query
select ProductID,SalesmanName,sum(quantity) as "Quantities"
from sales
group by SalesmanName,ProductID

SELECT * --l pivot group by w rotation lltable aknha matrix run it w n4of
FROM sales 
PIVOT (SUM(Quantity) FOR SalesmanName IN ([Ahmed],[Khalid],[ali])) as PVT
--l pivot bt3ml matrix 3la table mo3yn w nta bt7dd asame l columns
--3opata a3n x w y dimension
--group by and rotation for table
SELECT *
FROM sales 
PIVOT (SUM(Quantity) FOR SalesmanName IN ([Ahmed],[Khalid])) as PVT

SELECT *
FROM sales 
PIVOT (SUM(Quantity) FOR productid IN ([1],[2],[3],[4])) as PVT

Select * from newpivot


select * from newtable


--how to get the table
SELECT * FROM newtable 
UNPIVOT (qty FOR salesname IN ([Ahmed],[Khalid],[Ali])) UNPVT



execute('SELECT * FROM sales 
PIVOT(SUM(Quantity) FOR SalesmanName IN (p1))')

PVT


alter proc p1
as
select distinct(salesmanname)
from sales

p1

