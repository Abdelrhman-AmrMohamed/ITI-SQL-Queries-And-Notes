--Row_Number() -->
SELECT *,Row_Number() over (order by St_Age desc) as RN 
FROM Student 
--order by age and give it a sequtional number (ex. biggest age at dep )
-------------------------------------------------------------------------------
--Dense_rank() -->
SELECT * , DENSE_RANK() over (order by St_Age desc) as DN
FROM Student
--order by age and give it a sequtional number but equalized values get same num (ex. who has 30 yo)
--NTILE(num of groups) -->
SELECT * , NTILE(3) over (order by St_Age desc) as N
FROM Student
--order by age and group it into 3 groups and last group only have -1 diff compare to other groups
--Rank() --> 
SELECT *, Rank() over (order by St_Age desc) as R 
FROM Student 
--order by age and give it a sequtional number but equalized values get same num and its skip the next num 

--#its the ranking functions 
--ican use partition by with all functions 
USE ITI;
go
SELECT * FROM (
SELECT * , Row_Number() over (partition by Dept_Location order by Dept_id desc) as rn
FROM Department ) as newtable
WHERE rn=1

SELECT Dept_Name FROM (
SELECT *, DENSE_RANK() over (partition by Dept_Location order by Dept_id) as dr
FROM Department
) as newtable 
WHERE dr=1 

SELECT * FROM (
SELECT *, ROW_NUMBER() over (partition by dept_id order by St_Age desc) as rn FROM Student)as newone
WHERE rn=1
--akpr wa7d f kol department
select * from student
SELECT * FROM (
SELECT *, DENSE_RANK() over (partition by dept_id order by St_Age desc) as DR FROM Student)as newone
WHERE DR=1
--akpr wa7d f kol department with repeat