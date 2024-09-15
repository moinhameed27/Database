/* 
UNION : It is used to combine the result-set of two or more select statements and gives Unique records
To use it:
1. every SELECT statement should have same no of column(s).
2. columns must have similar data types.
3. columns in every select should be in same order.

SELECT column(s) from tableA
UNION
SELECT column(s) from tableB

UNION ALL : Same as UNION but it also allows the duplicate records.
*/

create table employee (
	id int primary key,
    name varchar(20),
    manager_id int
);


insert into employee values
(101, "adam", 103),
(102, "bob", 104),
(103, "casey", null),
(104, "donald", 103);

select name from employee
union
select name from employee;

select name from employee
union all
select name from employee;