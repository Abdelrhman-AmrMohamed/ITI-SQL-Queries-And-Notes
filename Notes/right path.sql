--DB Objects [view function table sp] it must be called by the right path 
--servername.dbname.schemaname.objectname
select * from student  --is equal to
select * from [DESKTOP-GFGVQ7U].ITI.dbo.student

--we can join between two tables from diff servers and diff db 
select * from [DESKTOP-GFGVQ7U].ITI.dbo.student join [DESKTOP-GFGVQ7U].Company_SD.dbo.Employee on --any 2 colmuns 