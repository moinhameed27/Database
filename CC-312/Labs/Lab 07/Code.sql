----------------------------------- Task 1 -----------------------------------
/* 1. Maximum Salary Difference Between Employees in "Veteran" (Hired before 1985) and "Newcomer" 
   (Hired after 1985) Categories. */
select max(case when year(hiredate) < 1985 then sal else 0 end) -    
	   max(case when year(hiredate) > 1985 then sal else 0 end)
as salaryDifference from EMP;

/* 2. Average Length of Employee Names by Department. */
select deptno, avg(length(ename)) as average from EMP
group by deptno;

/* 3. Find the Employee with the Longest Name in Each Department. */
select deptno, max(length(ename)) as longest from EMP
group by deptno;

/* 4. Count of Employees with "High" Income (Salary > 2000) by Department and Format Employee Names in Uppercase. */
select D.dname, upper(E.ename) as name, count(case when E.sal > 2000 then 1 end) as count
from EMP as E join DEPT as D on E.deptno = D.deptno
group by D.dname, E.ename;

/* 5. Calculate Total Salary and Average Commission by Department for Employees with Commission. */
select deptno, sum(if (comm is null, 0, sal) ) as totalSal, avg(comm) as averageComm
from EMP group by deptno;

/* 6. Determine the Number of Characters in the Longest Job Title Across All Departments. */
select deptno, max(length(job)) as longest from EMP 
group by deptno;

/* 7. Calculate Average Salary by Department and Grade. */
select deptno, grade, avg(sal) as average from EMP as E
join SALGRADE as S on E.sal between S.losal and S.hisal
group by deptno, grade;

/* 8. List Departments with Total Salary Above 5000 and Average Grade Below 4. */
select deptno, sum(E.sal) as sum, avg(S.grade) from EMP as E
join SALGRADE as S on E.sal between S.losal and S.hisal
group by deptno having sum(E.sal) > 5000 and avg(S.grade) < 4;	

/* 9. List All Grades and Departments with No Employees in That Grade. */
select D.dname, S.grade
from DEPT as D
cross join SALGRADE as S
left join EMP as E
on E.deptno = D.deptno and E.sal between S.losal AND S.hisal
where E.empno is null;

/* 10. Show Departments Where at Least 50% of Employees Are in Grade 3 or Above. */
select D.dname from DEPT as D
join EMP as E on D.deptno = E.deptno
join SALGRADE as S on E.sal between S.losal and S.hisal
group by D.dname
having sum(case when S.grade >= 3 then 1 else 0 end) >= count(E.empno) / 2;

/* 11. Find the Average Salary Increase Needed for Employees to Reach the Next Grade. */
select S1.grade, avg(S2.losal - E.sal) as avgIncrease from EMP as E
join SALGRADE as S1 on E.sal between S1.losal and S1.hisal
join SALGRADE as S2 on S1.grade + 1 = S2.grade
where E.sal < S2.losal
group by S1.grade;

/* 12. Display each employee’s name, job title, and department name. If an employee is in department 10, 
   add "(Admin)" next to their job title. If the employee has no department, show "Not Assigned" in place 
   of the department name. */
select ename, 
concat(case 
			when E.deptno = 10 then concat(job, "(Admin)") 
            when E.deptno = 0 then concat(job, "(Not Assigned)") 
            else dname end) as jobtitle , dname 
from EMP as E join DEPT as D on E.deptno = D.deptno;
   
/* 13. Show the average salary by department for departments with an average salary above 2000. Include 
   departments with no employees, showing NULL as the average salary for them. */
select D.dname, avg(E.sal) as average from EMP as E
right join DEPT as D on E.deptno = D.deptno
group by D.dname
having avg(sal) > 2000 or avg(E.sal) is null;

/* 14. Fetch a list of unique job titles and their respective salary grades. If the salary grade is NULL, 
   mark it as "Not Graded". */
select job, if(grade is null, "Not Graded", grade) as grade from EMP as E
left join SALGRADE as S on E.sal between S.losal and S.hisal
group by job, grade;

/* 15. Get a distinct list of departments and the total number of employees in each, but only for departments 
   with more than two employees. */
select deptno, count(*) as count from EMP 
group by deptno having count(*) > 2;

/* 16. Show the number of employees hired each year. Include only years with more than three employees hired. */
select year(hiredate) as year, count(*) as count from EMP
group by year(hiredate) having count(*) > 3;

/* 17. For each department, count how many employees are categorized as "Senior" (salary above 2000) or 
   "Junior" (salary 2000 or below). */
select dname, sum( if(sal > 2000, 1, 0) ) as Senior, 
sum( if(sal < 2000, 1, 0) ) as Junior 
from EMP as E right join DEPT as D on E.deptno = D.deptno
group by dname;