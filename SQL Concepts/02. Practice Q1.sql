/*
--> Q1
1. Create a database xyz.
2. Creata a employee named table in it having columns id, name and salary.
3. Insert 3 rows into the table
*/

create database xyz;

use xyz;

create table employee
(
	id int primary key,
    name varchar(25),
    salary int unsigned not null
);

insert into employee values 
(1, "adam", 25000),
(2, "bob", 30000),
(3, "casey", 40000);

select * from employee;
