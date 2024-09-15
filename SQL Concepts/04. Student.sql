use university;

create table student (
	rollno int primary key,
    name varchar(20) not null,
    marks int not null,
    grade varchar(1) not null,
    city varchar(20) not null
);

insert into student values
(2, "Ahmad", 92, "A", "Lahore"),
(6, "Bakar", 85, "A", "Lahore"),
(14, "Rafay", 78, "B", "Lahore"),
(23, "Moin", 88, "A", "Okara"),
(31, "Junaid", 78, "B", "Lahore"),
(43, "Subhan", 75, "B", "Lahore"),
(44, "Jafry", 72, "B", "Lahore"),
(46, "Sherry", 70, "B", "Lahore");


