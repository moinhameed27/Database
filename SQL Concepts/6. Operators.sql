select * from student;

/* 
Arithmetic Operators : +, -, *, /, %
Comparison Operators : <, >, =, >=, <=
Logical Operators : AND, NOT, OR, IN, BETWEEN, ALL, LIKE, ANY
Bitwise Operators : &, |
*/

select * from student where marks + 10 > 90;

select * from student where marks >= 85 and rollno < 10;
select * from student where marks > 85 or rollno < 10;

/*
BETWEEN : Selects for a given range
IN : matches any value in the list
NOT : to negate the given condition
*/

select * from student where marks between 78 and 95;
select * from student where name in ("Moin", "Ahmad");
select * from student where grade not in ("B");