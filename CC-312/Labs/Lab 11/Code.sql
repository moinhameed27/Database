----------------------------------- Task 1 -----------------------------------
/* 1. Find Employees Who Were Hired Before the Manager of Their Department. */
select E1.ename, E1.empno, E1.hiredate as EMPDATE, E2.hiredate as MGRDATE from EMP as E1
join EMP as E2 on E1.mgr = E2.empno
where E1.hiredate < E2.hiredate;

/* 2. List all employees in department 20 who have a manager in department 10. */
select E1.ename, E1.deptno as EMPDEPT, E2.deptno as MGRDEPT
from EMP as E1
join EMP as E2 on E1.mgr = E2.mgr
where E1.deptno = 20 and E2.deptno = 10;

/* 3. Find the name of the department with the highest number of employees. */
select D.dname, count(*) as count
from EMP as E
join DEPT as D on E.deptno = D.deptno
group by D.dname 
order by count desc limit 1;

/* 4. Find the job with the lowest average salary. */
select job, avg(sal) as averageSAL from EMP
group by job
order by averageSAL limit 1;

/* 5. Display the department name of lowest paid employee without using join. */
select dname from DEPT
where deptno = (select deptno from EMP
	where sal = (select min(sal) from EMP) );

/* 6. List the Names of Employees Working in the Same Location as Department 'SALES' */
select E.ename, E.job, E.deptno
from EMP as E
join DEPT as D on E.deptno = D.deptno
where D.loc = (select loc from DEPT where dname = "SALES");

/* 7. Find Departments Where All Employees Earn a Salary Greater Than 2000. */
select dname from DEPT
where deptno in
(select deptno from EMP
 group by deptno having min(sal) > 2000);


----------------------------------- Task 2 -----------------------------------
/* 1. Find the employees who earn more than the average salary of their department. */
select E1.ename, E1.sal, E1.deptno
from EMP as E1
where E1.sal > (
    select avg(E2.SAL)
    from EMP as E2
    where E1.deptno = E2.deptno
);

/* 2. Find the employees who have the same manager as another employee. */
select empno, ename, mgr
from EMP as E1
where mgr in (
    select mgr
    from EMP as E2
    where E1.empno != E2.empno
);

/* 3. Find the department(s) that has at least one employee earning above the average salary in the department. */
select distinct deptno from EMP as E1
where sal > (
    select avg(sal) from EMP as E2
    where E1.deptno = E2.deptno
);

/* 4. Find the number of Employees having same job as “Blake” and working in the Research Department. */
select ename from EMP
where job = (
    select job from EMP where ename = "BLAKE"
) and deptno = (
    select deptno from DEPT where dname = "RESEARCH"
);

/* 5. Find the department with the highest number of employees earning above the highest salary in grade. */
select deptno from EMP
where sal > (
    select hisal from SALGRADE
    where grade = 3
)
group by deptno
order by count(*) desc limit 1;

/* 6. Find employees with salaries that match the highest and lowest salaries for each grade. */
select E.ename, E.sal, S.grade, case
when E.sal = S.losal then "Lowest salary in grade"
when E.sal = S.hisal then "Highest salary in grade"
else "Middle Salary in grade"
end as Level
from EMP as E join SALGRADE as S
on E.sal between S.losal and S.hisal;

/* 7. Find the employee with the THIRD lowest salary. */
select empno, ename, sal from EMP as E1
where 2 = (
    select count(*) from EMP as E2 
    where E1.sal > E2.sal
);


----------------------------------- Task 3 -----------------------------------
/* 1. Find the Department with the Most Employees Earning Over 2000. */
select deptno from EMP	
where sal > 2000 group by deptno
order by count(*) desc limit 1;

/* 2. List the Departments Where the Average Salary of Employees is Greater Than the Salary of the 
   Highest Paid Employee in the Department Who is Not the Manager of Any Employee. */
select distinct deptno from EMP as E1
where (
    select avg(sal) from EMP as E2
    where E1.deptno = E2.deptno
) > (
    select max(sal) from EMP as E3
    where E1.deptno = E3.deptno and E3.empno not in (
        select mgr from EMP where mgr is not null )
);

/* 3. Find Employees Who Have a Manager in a Different Department. */
select empno, ename, deptno, mgr
from EMP as e1
where deptno != (
    select deptno from EMP e2
    where e2.empno = e1.mgr
);