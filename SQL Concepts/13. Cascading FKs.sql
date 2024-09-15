/*
CASCADING : It means that if two table are connected by FKs, then after doing changes in the FK table, all changes should also reflect on the child table.
It includes update and delete cascading.
ON UPDATE CASCADE
ON DELETE CASCADE
*/

/* Parent */
create table course
(
	id int primary key,
    name varchar(25)
);

insert into course values
(101, "english"),
(102, "maths");

select * from course;

update course set id = 120 where id = 102;
update course set id = 110 where id = 101;

/* Child */
create table professor
(
	id int primary key,
    name varchar(25),
    dept_id int,
    foreign key (dept_id) references course(id)
    on update cascade
    on delete cascade
);

insert into professor values
(1, "Anzar", 102),
(2, "Nazar", 101);

select * from professor;

