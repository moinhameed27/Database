/* GROUP BY : Groups rows that have the same values into summary rows. */

select city from student group by city;

select city, count(rollno) from student group by city;

select city, avg(marks) from student group by city;

select city, grade from student group by city, grade;

select city, grade, count(grade) from student group by city, grade;

/* HAVING : Works same as WHERE clause but it's specifically for GROUP BY rows. */

/* It will show all rows even if only condition for only one is met. */
select city, count(marks) from student group by city having max(marks) > 90;
select city, count(marks) from student group by city having avg(marks) > 72;

/* 
--> GENERAL ORDER OF WRITING STATEMENT 
SELECT column(s)
FROM table_name
WHERE condition
GROUP BY column(s)
HAVING condition
ORDER BY column(s) ASC/DESC;
*/

select city, count(rollno)
from student
where grade = "B"
group by city
having avg(marks) > 72;

select city, name, count(rollno)
from student
where grade = "B"
group by city, name
having avg(marks) > 70;


select name, marks
from student
where grade = "B"
group by name, marks
having avg(marks) > 70
order by marks asc;