---------------------------------------- Aggregate Functions ----------------------------------------
/*
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


---------------------------------------- Operators ----------------------------------------
/*
LIKE : The LIKE operator is used to search for a specified pattern in a column.
• % : Represents zero, one, or multiple characters.
• _ : Represents a single character.
--> select * from table_name where column_name like "pattern";
*/

select * from dept where dname like "A%";
select * from dept where dname like "%son%";
select * from dept where dname like "_____";


/*
IS NULL : The IS NULL operator is used to check for NULL values in a column.
--> select * from table_name where column_name is null;
*/

select * from emp where comm is null;


/* 
IN : It checks if a value is in a list of values.
--> select * from table_name where column_name in("value1", "value2", ...);
*/

select * from dept where dname in("sales", "accounting");


---------------------------------------- Single-Row Functions ----------------------------------------
/* 
DATE_FORMAT() : The DATE_FORMAT() function is used to format date values into a specified format.
~ DATE_FORMAT(date, format)
--> select date_format(now(), "%d-%m-%y") as formatted_date;
*/

select date_format(now(), "%y-%m-%d") as formatted_date;
select date_format(hiredate, "%d-%m-%y") as formatted_date from emp;


/* 
CAST() : The CAST() function is used to convert one data type to another.
~ CAST(expression AS data_type)
--> select cast(1234 as char) as number_as_string;
*/

select cast(hiredate as char) as number_string from emp;


/* 
CONCAT() : The CONCAT() function is used to join two or more strings together.
~ CONCAT(string1, string2, ...)
--> select cast(1234 as char) as number_as_string;  
*/

select concat(ename, " - " , job) as name_job from emp;


/* 
SUBSTR() : The SUBSTR() function extracts a part of a string.
~ SUBSTR(string, start_position, length)
~ SUBSTR(string, start_position) [If length is not specified, it returns the remaining characters from the start_position]
--> select substr(col_name, 1, 4) as short_name from table_name;  
*/

select substr(ename, 1, 4) as sub from emp;
select substr(ename, 2) as sub from emp;
select substr(ename, -4) as sub from emp;