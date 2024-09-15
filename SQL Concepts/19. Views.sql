/* 
VIEW : It is a virtual table based on the result-set of an SQL statement
1. It is used to show a part of a complete table.
2. It always shows up-to-date data from the table.
*/

select * from student;

create view view1 as select name, marks, city from student;

drop view view1;

select * from view1;
select * from view1 where marks > 85;

update student set marks = 92 where marks = 91;