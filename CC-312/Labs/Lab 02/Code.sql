----------------------------------- Task 1 -----------------------------------
/* 1. Retrive all Employees whose name starts with B (use of Like operator is not allowed) */
select * from emp where substr(ename, 1, 1) = "b";
select * from emp where ename like "b%";  /* (With LIKE) */


/* 2. Display Employee information whose NAME length is 5. (Use of Length function is not allowed). */
select * from emp where ename like "_____";
select * from emp where length(ename) = 5;  /* (With LENGTH) */


/* 3. Write an SQL query that contains Letter ‘L’ on second position and ends with ‘E’ in employees’ names. (Use Like operator only) */
select * from emp where ename like "_L%E";
select * from emp where substr(ename, 2, 1) = "l" and substr(ename, length(ename)) = "e";  /* (Without LIKE) */


/* 4. Adds three dollar signs ($$$) at the beginning and the end of a string.In the middle, includes the last three characters of the 
	  employee's name and their employee number. */
select concat("$$$", substr(ename, -3), substr(empno, -3), "$$$") as new_string from emp;


/* 5. Find the employees that are hired after the 1981 and before the 1987. */
select * from emp where cast(substr(hiredate, 1, 4) as char) > 1981 and cast(substr(hiredate, 1, 4) as char) < 1987;
select * from emp where hiredate >= "1982-01-01" and hiredate < "1987-01-01";
select * from emp where hiredate between '1982-01-01' and '1986-12-31';
select * from emp where year(hiredate) > 1981 and year(hiredate) < 1987;


/* 6. Retrieves the employee’s name along with the number of days, weeks, and years since they were hired. */
select ename, datediff(now(), hiredate) as days, datediff(now(), hiredate) / 7 as weeks, datediff(now(), hiredate) / 365 as years from emp;
select ename, days, days / 7 as weeks, days / 365 as years from (select ename, datediff(now(), hiredate) as days from emp) as calculate_days;


/* 7. Check if the salary is 0 and display ‘No Salary’ if it is, otherwise return the actual salary. (Don’t use IF) */
select ifnull(nullif(sal, 0), "No Salary") as salary from emp;
select if(sal = 0, "No Salary", sal) as salary from emp;  /* (With IF) */



----------------------------------- Task 2 -----------------------------------
/* 1. Write query to display names of students as given in the figure. Join first two letters of the middle name with the last 
   letter of the first name and * in between. */
select concat(substr(std_name, instr(std_name, " ") + 1, 2), "*", substr(std_name, instr(std_name, " ") - 1, 1)) as Result from pucit;


/* 2. Display Employees Who Have a Salary That Is a Multiple of 500 and their name starts with vowels. */
select * from emp where mod(sal, 500) = 0 and ( ename like("a%") or ename like("e%") or ename like("i%") or ename like("o%") or ename like("u%") );
select * from emp where sal % 500 = 0 and substr(ename, 1, 1) in ("a", "e", "i", "o", "u");


/* 3. Retrieves the employee's name and salary, and generates a "salary bar" using dollar signs ($). For every 500 units of salary, one 
   dollar sign is printed. For example, if an employee's salary is 500, one dollar sign is printed; if the salary is 1000, two dollar 
   signs are printed; and if the salary is 1500, three dollar signs are printed, and so on. This visually represents the salary in 
   increments of 500 using dollar signs. */
select ename, sal, substr("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$", 1, cast(sal / 500 as char)) as salary_bar from emp;

select ename, sal, repeat("$", floor(sal / 500)) as salary_bar from emp;

select ename, sal, case when sal < 500 then "" when sal < 1000 then '$' when sal < 1500 then '$$' when sal < 2000 then '$$$' when sal < 2500 then '$$$$' 
when sal < 3000 then '$$$$$' when sal < 3500 then '$$$$$$' when sal < 4000 then '$$$$$$$' when sal < 4500 then '$$$$$$$$' when sal < 5000 then '$$$$$$$$$' 
when sal < 5500 then "$$$$$$$$$$" else "Out of Bound" end as dollars from emp;


/* 4. Employees Who Have the Same Letter  “A”  Multiple Times in Their Job Title (Without using like operator). */
select * from emp where instr(job, "A") != instr(job, "%A%");
select * from emp where instr(job, "a") > 0 and instr(job, "a", instr(job, "a") + 1) > 0;
select * from emp where length(job) - length(replace(upper(job), "A", "")) > 1;


/* 5. Retrieve Students from Pucit table having exactly two a’s in theirs name. */
select * from pucit where std_name like "%a%a%" and std_name not like "%a%a%a%";
select * from pucit where length(std_name) - length(replace(upper(std_name), "A", "")) = 2;


/* 6. Display the employee code in the format XXX-YY-NN. The first 3 letters of the code are the last 3 letters of ENAME and YY is obtained 
   from the last 2 digits of year in the HIREDATE. NN is the DEPTNO of the employee. Restrict the output to the employees working in 
   DEPTNO 10 or 20 and their name starts with s. */
select ename, deptno, hiredate, concat(substr(ename, -3), "-", substr(hiredate, 3, 2), "-", deptno) as employee_code from emp where deptno in (20, 10);


/* 7. Display the employees that are hired in leap years and their experience (experience expressed in years). */
select ename, hiredate, datediff(now(), hiredate) / 365 as experience_in_years from emp where ( cast(substr(hiredate, 1, 4) as char) % 4 = 0
and cast(substr(hiredate, 1, 4) as char) % 100 != 0 ) or cast(substr(hiredate, 1, 4) as char) % 400 = 0;

select ename, hiredate, datediff(now(), hiredate) / 365 as experience_in_years from emp where ( year(hiredate) % 4 = 0
and year(hiredate) % 100 != 0 ) or year(hiredate) % 400 = 0;


/* 8. Find employees whose name contains 'L', extract the position of 'L' in their name, and concatenate the name with their job title. Format 
   the hire date and check if their salary is NULL. */ 
select ename, instr(ename, "l") as position_of_l, concat(ename, " - ", job) as name_and_job, date_format(hiredate, "%M %D %Y") as formatted_hire_date,
sal as salary_status from emp where ename is not null and ename like "%L%";



----------------------------------- Task 3 -----------------------------------
/* 1. Write a query to display introduction of each employee such as shown below. */
select concat(ename, " works as a ", job, " in department ", deptno, " since ", substr(hiredate, 1, 4), " and earning ", sal, " Rs per month")
as employee_introduction from emp; 

select concat_ws(' ', ename, 'works as a', job, 'in department', deptno, 'since', SUBSTR(hiredate, 1, 4), 'and earning', sal, 'Rs per month') 
as employee_introduction from emp; 


/* 2. Display employee names their original salary and comission. Increase their commission by 15% and 
   salary by 20%. Show the overall (final) salary, which is the sum of the updated salary and updated commission.  Filter the results 
   to show only those employees whose overall salary is between 2000 and 4000. */
select ename, sal, ifnull(comm, "No Comission") as comm, ifnull(comm, 0) * 0.15 as new_comm, sal * 0.20 as new_sal, 
ifnull(comm, 0) * 0.15 + sal * 0.20 + sal + ifnull(comm, 0)  as overall_salary from emp
where ifnull(comm, 0) * 0.15 + sal * 0.20 + sal + ifnull(comm, 0) between 2000 and 4000;

select ename, sal, ifnull(comm, "No Commission") as comm, ifnull(comm, 0) * 0.15 as new_comm, sal * 0.20 as new_sal, 
ifnull(comm, 0) * 0.15 + sal * 0.20 + sal + ifnull(comm, 0) as overall_salary 
from emp where ifnull(comm, 0) * 0.15 + sal * 0.20 + sal + ifnull(comm, 0) between 2000 and 4000;


/* 3. Removes the first character of the job title and appends it to the end. Appends -HIGH or -LOW based on the employee’s salary. Filters 
   employees whose job title contains the letter "C". Excludes employees whose job titles contain the letters "N" or "A" (without LIKE operator). */
select empno, ename, job, concat(concat(substr(job, 2), substr(job, 1, 1)), "-", if(sal < 2000, "LOW", "HIGH")) as modified_job from emp
where instr(job, 'C') > 0 and instr(job, 'N') = 0 and instr(job, 'A') = 0;

select empno, ename, job, concat(concat(substr(job, 2), substr(job, 1, 1)), "-", if(sal < 2000, "LOW", "HIGH")) as modified_job from emp
where job like '%C%' and job not like '%N%' and job not like '%A%';  /* with LIKE */