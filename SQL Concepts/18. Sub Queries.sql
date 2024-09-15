/* 
SUB QUERIES : Queries are written inside queries. It is helpful to divide the bigger problem into small problems.
*/

/*
Example 1 : Find the students who scored more marks than average marks.
1. Average Marks
2. Students who scored more than average marks.
*/

select * from student;
select avg(marks) from student;

select name, marks from student where marks > ( select avg(marks) from student);

/*
Example 2 : Find the students who got even roll number
1. Even Roll No
2. Students with even roll no
*/

select name, rollno from student where rollno % 2 = 0;

/*
Example 3 : Find the max marks from students of Lahore
1. Max Marks from Lahore
2. Students with max marks
*/

select name, marks from student where marks = ( select max(marks) from student where city = "Lahore");

select max(marks) from ( select marks from student where city = "Lahore") as m;