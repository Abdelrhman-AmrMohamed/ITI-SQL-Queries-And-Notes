--drop-- delete metadate&date 
--delete--delete data + come withh it where condition and it take long time than {truncate} cuz its wrote in log files and delete don't rest identity i mean if u deleted 2000 row and insert again 
--next row wiill be 2001 
--truncate same delete with diff in no.2 

--examble to see how delete don't rest the id 

create table test1(
id int identity , 
name varchar(10)
)

insert into test1 values('asfdsa')

truncate table test1


select * from test1


delete from test1