/* FOREIGN KEY : A primary key of a table used in any other table */

/* For Visualizing : Database -> Reverse Engineer -> Continue */

/* Parent */
create table course
(
	id int primary key,
    name varchar(25)
);

/* Child */
create table professor
(
	id int primary key,
    name varchar(25),
    dept_id int,
    foreign key (dept_id) references course(id)
);

