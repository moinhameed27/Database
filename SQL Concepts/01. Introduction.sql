create database university;
/* After making a database, we need to put it to use by use command. */
use university;

/* 
Create a table with following columns and constraints. 
1. not null : can't be left empty
2. unique : must be a distinct column
3. Primary Key : not null and Unique
*/
create table student(
	id int primary key,
    name varchar(50),
    age int not null
);

/* Inserting rows into tables according to their sequence of creation. */
insert into student values(1, "Moin", 20);
insert into student values(2, "Jonnaiddd", 21);
insert into student values(3, "Nigga", 21);

/* Print the table. */
select * from student;

/* if not exists : good practice, as it will give only warning if the database is already present, otherwise a proper error will be given */
create database university;
create database if not exists university;

/* if exists : good practice, as it will give only warning if the database is already present, otherwise a proper error will be given */
drop database college;
drop database if exists student;

/* Show all the Databases */
show databases;
/* Show all the tables */
show tables;

/* Remove any table */
drop table student;

/* Inserting to any self choice columns  */
insert into student
(id, name, age)
values
(4, "Maulana", 21),
(5, "Nibba", 21),
(6, "Jaafry", 21);

insert into student values
(7, "Bakar", 21),
(8, "Rafay", 21);
