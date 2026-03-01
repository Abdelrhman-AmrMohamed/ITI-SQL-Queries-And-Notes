create schema HR
alter schema HR transfer student

create table student (
id int , name varchar(20))

select * from HR.student
select * from dbo.student

--logical grouping (hr msln 3ndo tables mo3yna 5las a5leha t7t l schema deh)
--w a22dr ade permission 3la schema kamla f mofeda gdn



--to make user that control schema and only can insert - delete 10 steps 
--1->make the server mixed mode 
--2->go to security and make a new login  (now he can login the server) let's make him a user on the db
--3->go to db and go to users and new user
--4->create schema
--5->transfer some objects on the scehma 
--6->sync user to schema (double click on schema and search for the user and grant and deny roles like insert - delete)
--7->connect the user and try ur roles

