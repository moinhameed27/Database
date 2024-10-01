----------------------------------- Task 1 -----------------------------------
/* SELECT */
select * from emp;
select deptno from dept;

/* WHERE */
select ename, job, sal from emp where sal > 2000;
select * from dept where loc = "boston";

----------------------------------- Task 2 -----------------------------------
/* 1. Retrieve all student names from the PUCIT table. */
select * from pucit;

/* 2. Retrieve employee names and their job titles from the EMP table. */
select ename, job from emp;

/* 3. Retrieve department names and locations from the DEPT table. */
select dname, loc from dept;

/* 4. Retrieve the grades and salary ranges (losal, hisal) from the SALGRADE table. */
select * from salgrade;

/* 5. Retrieve all employees from the EMP table who are managers. */
select * from emp where job = "manager";

/* 6. Retrieve employees whose salary is greater than 3000. */
select * from emp where sal > 3000;

/* 7. Retrieve employee names and calculate their annual salary assuming the current salary is monthly. */
select ename, (sal * 12) as annual_salary from emp;

/* 8. Retrieve employee names and subtract 500 from their salary. */
select ename, (sal - 500) as deducted_salary from emp;

/* 9. Retrieve employees who work in department number 30 and have a salary greater than 2000. */
select * from emp where deptno = 30 and sal > 2000;

/* 10. Retrieve employees who are either salesmen or clerks. */
select * from emp where job = "salesman" or job = "clerk";
select * from emp where job in ("salesman", "clerk");

/* 11. Retrieve employees who work in department 20 or have a salary greater than 2500. */
select * from emp where deptno = 20 or sal > 2500;

/* 12. List the employee-manager working under the having id=7566. */
select * from emp where mgr = 7566;

/* 13. List the employees that are not clerks. */
select * from emp where job != "clerk";
select * from emp where job not in ("clerk");