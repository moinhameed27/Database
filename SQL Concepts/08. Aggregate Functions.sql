use university;

/*
--> Aggregate Functions
COUNT : Count Number of rows in a table or data.
MAX : Returns the maximum in a column.
MIN : Returns the minimum in a column.
SUM : Returns the sum of column.
AVG : Returns the average of column.
One way to use these functions is with SELECT statement.
*/

select count(rollno) from student;
select max(marks) from student;
select min(marks) from student;
select sum(marks) from student;
select avg(marks) from student;
