use university;

/* 
--> SQL Constraints
1. NOT NULL : can't be left empty
2. UNIQUE : must be a distinct column
3. PRIMARY KEY : not null and Unique
*/


create table temp 
(
	id int,
    name varchar(20),
    age int not null,
    city varchar(20),
    primary key (id, name)
    /* Another way of specifying primary key, but in this we're saying that individually id and names can have duplicate values but both combined
	   would have only unique values. */
);

/* FOREIGN KEY : Assign a foreign key in a table referencing from previous table */
create table temp2 (
	newId int,
    foreign key (newId) references temp(id)
);

/* DEFAULT :  Set a default value if not given for any specific column */

create table emp(
	id int,
    salary int default 23000
);

insert into emp (id) values (23);

select * from emp;

/* CHECK : to check for the validity of any condition */
create table city(
	id int primary key,
    name varchar(20),
    age int,
    constraint age_check check ( age >= 18 and name = "okara")
); 

insert into city values (1, "okara", 19);
insert into city values (2, "lahore", 20);
insert into city values (3, "okara", 15);

create table temp3 (
	age int check ( age >= 18)
);

insert into temp3 values (2);
