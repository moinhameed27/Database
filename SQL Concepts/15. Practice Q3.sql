/*
1. Change the column "name" to "full_name"
2. Delete all students record who scored marks less than 80;
3. Delete the column for grades.
*/

create table student2 (
	rollno int primary key,
    name varchar(20) not null,
    marks int not null,
    grade varchar(1) not null,
    city varchar(20) not null
);

insert into student2 values
(2, "Ahmad", 92, "A", "Lahore"),
(6, "Bakar", 85, "A", "Lahore"),
(14, "Rafay", 78, "B", "Lahore"),
(23, "Moin", 88, "A", "Okara"),
(31, "Junaid", 78, "B", "Lahore"),
(43, "Subhan", 75, "B", "Lahore"),
(44, "Jafry", 72, "B", "Lahore"),
(46, "Sherry", 70, "B", "Lahore");

select * from student2;

alter table student2 change column name full_name varchar(20);

delete from student2 where marks < 80;

alter table student2 drop column grade;