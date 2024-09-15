/* WHERE : Only selects those students with a specific condition met. */
select marks from student where marks >= 80;
select name, city from student where city = "Lahore";
select * from student where grade = "A";
select * from student where rollno > 10 and grade = "A";

/* LIMIT : Limits the number of rows to some given value */
select * from student limit 3;
select * from student where marks >= 75 limit 5;

/* ORDER BY : To sort the data in ascending or descending order */
select * from student order by city asc;
select * from student order by marks desc;
select * from student order by rollno desc limit 3;