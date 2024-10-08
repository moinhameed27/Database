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

/*
UPPER() : The UPPER function converts all characters in a string to uppercase.
~ UPPER(string)
--> select upper('hello world') as result;
*/

select upper(ename) as upper_name from EMP;

/*
LOWER() : The LOWER function converts all characters in a string to lowercase.
~ LOWER(string)
--> select lower('hello world') as result;
*/

select lower(ename) as lower_name from EMP;

/*
LEFT() : The LEFT function returns a specified number of characters from the left side of a string.
~ LEFT(string, number_of_characters)
--> select left('Database', 4) as result; (Data)
*/

select left(ename, 5) as ans from EMP;

/*
RIGHT() : The RIGHT function returns a specified number of characters from the right side of a string.
~ RIGHT(string, number_of_characters)
--> select right('Database', 4) as result; (base)
*/

select right(ename, 5) as ans from EMP;

/*
LPAD() : The LPAD function pads a string on the left side with a specified character until it reaches a
		 desired length.
~ LPAD(string, padded_length, pad_string)
--> SELECT LPAD('123', 6, '0') AS padded_value; (000123)
*/

select lpad(ename, 8, "*") as ans from EMP;

/*
RPAD() : The RPAD function pads a string on the right side with a specified character until it reaches a
		 desired length.
~ RPAD(string, padded_length, pad_string)
--> SELECT RPAD('123', 6, '0') AS padded_value; (123000)
*/

select rpad(ename, 8, "*") as ans from EMP;

/*
TRIM() : The TRIM function removes leading, trailing, or both leading and trailing spaces (or other
		 specified characters) from a string.
~ TRIM([LEADING | TRAILING | BOTH] trim_character FROM string)
1. Removing Leading and Trailing Spaces
--> SELECT TRIM('    SQL Tutorial    ') AS trimmed_value; (SQL Tutorial)
2. Trimming Custom Characters
--> SELECT TRIM(BOTH 'x' FROM 'xxxSQLxxx') AS result; (SQL)
*/

select trim(ename) as ans from EMP;
select trim(both "T" from ename) as ans from EMP;

/*
LENGTH() : The LENGTH function returns the number of characters in a string.
~ LENGTH(string)
--> SELECT LENGTH('Database Management') AS string_length; (21)
*/

select length(ename) as len from EMP;

/*
REVERSE() : The REVERSE function reverses the characters in a string.
~ REVERSE(string)
--> SELECT REVERSE("SQL") AS string_length; (LQS)
*/

select reverse(ename) as rev from EMP;


/*
REPLACE() : The REPLACE function replaces occurrences of a substring within a string with another substring.
~ REPLACE(string, search_string, replace_string)
--> SELECT REPLACE('Learn SQL with tutorials', 'tutorials', 'examples') AS replaced_value; (Learn SQL with examples)
*/

select replace("I Love Country", "Country" , "Pakistan") as rep;