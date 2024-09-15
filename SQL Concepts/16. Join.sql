/*
JOIN : It is used to join the rows of two tables with some related column(s).

--> INNER JOIN : Returns records that have matching values in both tables
SELECT column(s) 
FROM tableA
INNER JOIN tableB 
ON tableA.col_name = tableB.colname;

--> LEFT (OUTER) JOIN: Returns all records from the left table, and the matched records from the right table
SELECT column(s) 
FROM tableA
LEFT JOIN tableB 
ON tableA.col_name = tableB.colname;

--> RIGHT (OUTER) JOIN: Returns all records from the right table, and the matched records from the left table
SELECT column(s) 
FROM tableA
RIGHT JOIN tableB 
ON tableA.col_name = tableB.colname;

--> FULL (OUTER) JOIN: Returns all records when there is a match in either left or right table
SELECT column(s) 
FROM tableA
LEFT JOIN tableB 
ON tableA.col_name = tableB.colname;
UNION
SELECT column(s) 
FROM tableA
RIGHT JOIN tableB 
ON tableA.col_name = tableB.colname;

--> LEFT EXCLUSIVE JOIN : Returns all records exlusively from left table (excluding the overlapped as well)
SELECT column(s)
FROM tableA
LEFT JOIN tableB
ON tableA.id = tableB.id
WHERE tableB.id IS NULL;

--> RIGHT EXCLUSIVE JOIN : Returns all records exlusively from right table (excluding the overlapped as well)
SELECT column(s)
FROM tableA
RIGHT JOIN tableB
ON tableA.id = tableB.id
WHERE tableA.id IS NULL;

--> SELF JOIN : A self join is a regular join, but the table is joined with itself.
SELECT a.name, b.name
FROM employee as a
JOIN employee as b
ON a.id = b.manager_id;
*/


create table pupil (
	id int primary key,
	name varchar(20)
);

insert into pupil values
(101, "adam"),
(102, "bob"),
(103, "casey");

create table subject (
	id int primary key,
    name varchar(20)
);

insert into subject values
(102, "english"),
(105, "math"),
(103, "science"),
(107, "physics");

select * from pupil;
select * from subject;


/* INNER JOIN */
select * from pupil
inner join subject
on pupil.id = subject.id; 

select pupil.name, subject.name from pupil
inner join subject
on pupil.id = subject.id; 

/* LEFT JOIN */
select * from pupil
left join subject
on pupil.id = subject.id; 

/* RIGHT JOIN */
select * from pupil
right join subject
on pupil.id = subject.id; 

/* FULL JOIN */
select * from pupil
left join subject
on pupil.id = subject.id
UNION
select * from pupil
right join subject
on pupil.id = subject.id; 

/* LEFT EXCLUSIVE JOIN */
select * from pupil
left join subject
on pupil.id = subject.id
where subject.id is null;

/* RIGHT EXCLUSIVE JOIN */
select * from pupil
right join subject
on pupil.id = subject.id
where pupil.id is null;



/* SELF JOIN */

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

select * from employee;

select *
from employee as a join employee as b
on a.id = b.manager_id;

select a.name as manager_id, b.name as employee
from employee as a join employee as b
on a.id = b.manager_id;
