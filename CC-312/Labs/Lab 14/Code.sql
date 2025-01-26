----------------------------------- Task 1 -----------------------------------
/* 1. Find employees who earn a salary between 1200 and 3000 (inclusive) and have a commission 
   greater than 500 or no commission at all. */
select ename, sal, comm from EMP
where sal between 1200 and 3000 
and ( comm > 500 or comm = 0 or comm is null );

/* 2. List Employees Who Have Never Managed Anyone. */
select empno, ename from EMP
where empno not in 
(select distinct mgr from EMP
where mgr is not null);

/* 3. Find department names that have more than 2 employees. */
select dname from DEPT as D
join EMP as E
on D.deptno = E.deptno
group by dname
having count(*) > 2;

/* 4. Display the employee name in uppercase, the first 3 letters of their job title, and the length of their name. */
select upper(ename), left(job, 3) as job, length(ename) from EMP;

/* 5. Find the department with the highest total salary and also print Total salary with dept no. */
select deptno, sum(sal) as totalSal from EMP group by deptno 
having sum(sal) = ( select max(totalSal)
from ( select sum(sal) as totalSal from EMP group by deptno )
as deptSal );


----------------------------------- Task 2 -----------------------------------
/* 1. List employees with their department name, location, salary grade, and indicate with (Above Average 
   and Below Average ) if their salary is above the average salary of their department. */
select E.ename, E.deptno, loc, grade, 
case when E.sal > (select avg(E2.sal) from EMP as E2 
where E.deptno = E2.deptno group by deptno)
then "Above Average"
else "Below Average" end as Level
from EMP as E join DEPT as D
on E.deptno = D.deptno
join SALGRADE as S
on E.sal between S.losal and S.hisal;

/* 2. List all employees who earn a salary above the average salary of their department, along with 
   their department name, total employees in the department, and the percentage of department salary a 
   listed employee contribute. */
select E.ename, E.sal, dname, E.deptno,
(select count(*) from EMP as E3 where E.deptno = E3.deptno group by E3.deptno) as Count,
E.sal * 100 / (select sum(E4.sal) from EMP as E4 where E.deptno = E4.deptno group by E4.deptno) as "%age"
from EMP as E join DEPT as D on E.deptno = D.deptno
where E.sal > (select avg(E2.sal) as avg from EMP as E2 
where E.deptno = E2.deptno group by E2.deptno);

/* 3. Find employees whose salaries are higher than all the managers in their department, along with 
   their department name. */
select E.ename, E.sal, D.dname from EMP as E
join DEPT as D on E.deptno = D.deptno
where E.sal > all (
	select sal from EMP
    where job = "MANAGER" and deptno = E.deptno );

/* 4. Display employees whose commission (if any) is more than 10% of the total salary of their department. 
   Include their name, department name, commission, and total department salary. */
select E.ename, D.dname, E.comm, 
(select sum(E2.sal) from EMP as E2 where E.deptno = E2.deptno) as DeptSal
from EMP as E join DEPT as D
on E.deptno = D.deptno
where if(comm is not null, comm, 0) > 0.10 * (select sum(E2.sal) from EMP as E2 where E.deptno = E2.deptno);

/* 5. Find the department with the highest total number of employees who were hired after 1981. Display 
   the department name and the total count. */
select D.dname, count(*) as count
from EMP as E join DEPT as D on E.deptno = D.deptno
where year(hiredate) > 1981 group by D.dname
order by count desc limit 1;