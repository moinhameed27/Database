----------------------------------- Task 1 -----------------------------------
/* 1. Display the number of transactions that occurred in each month and year. This can help identify 
   seasonal patterns in transactions. */
select month(transDate) as month, year(transDate) as year, count(*) as transactions
from transaction
group by month(transDate), year(transDate);

/* 2. Count the number of high-value transactions (over 5000) per month */
select month(transDate) as month, year(transDate) as year,count(*) as count 
from transaction where amount > 5000
group by month(transDate), year(transDate);


/* 3. List each department along with the average salary of employees within that department, excluding 
   departments with an average salary below 2000. */
select deptno, avg(sal) as average from EMP
group by deptno
having avg(sal) < 2000;
   
/* 4. Display each job title and the maximum salary for that job across all departments, but only include 
   job titles where the maximum salary is greater than 2500. */
select job, max(sal) as max from EMP
group by job
having max(sal) > 2500;
   
/* 5. Classify employees into salary ranges: "Low" for salaries below 1500, "Medium" for salaries between 
   1500 and 3000, and "High" for salaries above 3000. Display the employee name, salary, and classification. */

/* 6. Count the number of employees in each department who have "High" (above 2000) and "Low" (2000 or below) salaries. */
select deptno, 
sum(if(sal > 2000, 1, 0)) as high,
sum(if(sal <= 2000, 1, 0)) as low
from EMP group by deptno;

select deptno,
case 
	when sal > 2000 then "High"
	else "Low"
end as classification, count(*) as count from EMP
group by deptno, classification;

/* 7. Count the number of employees with and without commission in each department, giving insight 
   into the prevalence of commission-based roles by department. */
select deptno,
sum(case when comm is not null then 1 else 0 end) as withCommision,
sum(case when comm is null then 1 else 0 end) as noCommision
from EMP group by deptno;
   
/* 8. List each department that has more than two distinct job roles. */   
select deptno, count(distinct job) as count from EMP
group by deptno
having count(distinct job) > 2;


----------------------------------- Task 2 -----------------------------------
/* 1. Calculate the minimum and maximum balance across all cards and display only if the maximum balance is 
   more than twice the minimum balance. */
select max(balance) as max, min(balance) as min from card
having max(balance) > min(balance) * 2;

/* 2. Categorize employee salaries into levels Low, Medium, High on salary ranges and to calculate the average 
   salary for each category. Salary range (Low for employees where salary is less than 1000),(Medium For 
   employees where salary range between 1000 and 3000 inclusive) and (High for employees where salary is more 
   than 3000). */
select 
case 
	when sal < 1000 then "Low"
    when sal between 2000 and 3000 then "Medium"
    else "High"
end as salaryLevel, avg(sal) as average
from EMP group by salaryLevel;

/* 3. Show  TransId, TransDate, and each user's average transaction amount across all their cards, labeling 
   each as "High", "Medium", or "Low" based on thresholds of 3000 and 1000. */
select cardNum,
case 
	when avg(amount) < 1000 then "Low"
    when avg(amount) between 1000 and 3000 then "Medium"
    else "High"
end as label 
from transaction group by cardNum;

/* 4. Display the maximum balance for each card type, but only show types where the difference between 
   the maximum and minimum balance is greater than 15,000. */
select cardTypeId, max(balance) as max, min(balance) as min from card
group by cardTypeId
having max(balance) - min(balance) > 15000;

/* 5.Write a query to display the name, sal, and commission of the employee along with net-sal column 
   which contains net salary of emplyees that is basically sum of their salary and their commission.
		a. Increament salary by 500 if employee earns more net salary than sal.
		b. Increament salary by 1000 if employee earns equal salary and net salary. */
select ename, sal, ifnull(comm, 0) as comm, if(comm is not null, sal + comm, sal) as netSal,
case
	when if(comm is not null, sal + comm, sal) > sal then sal + 500
    when if(comm is not null, sal + comm, sal) = sal then sal + 1000
end as newSal from EMP;

/* 6. The employees are hired in the last century and the current century. Display empno, ename, hiredate, 
   hired century from emp table. The hired century is either the current century or the last century. */
select ename, empno, hiredate,
case
	when year(hiredate) < 2000 then "Last Century"
    when year(hiredate) >= 2000 then "Current Century"
end
as hiredCentury from EMP;

/* 7. Display empno, ename, job, sal, tax, and net sal from the emp table. Tax is calculated based on the following:
    • Salary less than 1000: No tax.
    • Salary from 1000 to 1499: 5% tax.
    • Salary from 1500 to 1999: 8% tax.
    • Salary from 2000 to 2499: 10% tax.
    • Salary 2500 and above: 12% tax.
The net sal is calculated by subtracting the calculated tax from the sal. */
select empno, ename, job, sal, 
case
	when sal < 1000 then 0
    when sal between 1000 and 1499 then sal * 0.05
    when sal between 1500 and 1999 then sal * 0.08
    when sal between 2000 and 2499 then sal * 0.10
    when sal >= 2500 then sal * 0.12
end
as tax,
case
	when sal < 1000 then sal
    when sal between 1000 and 1499 then sal - (sal * 0.05)
    when sal between 1500 and 1999 then  sal - (sal * 0.08)
    when sal between 2000 and 2499 then  sal - (sal * 0.10)
    when sal >= 2500 then  sal - (sal * 0.12)
end
as netSal
from EMP;


----------------------------------- Task 3 -----------------------------------
/* 
Write a query to display the following:   
Employee Details: Show the employee’s name, job title, original salary, and commission.
    • Base New Salary: Calculate a new salary with the following conditions:
		• Increase by 10% for managers with a salary above 2000.
		• Increase by 7% for salesmen with a salary between 1000 and 2000.
		• Increase by 12% for analysts.
		• Apply a 5% increase for all other cases.
    • Final Salary: Adjust the base new salary further with these conditions:
		• For managers with salary above 2000 and commission over 500, increase by 15%.
		• For salesmen with salary between 1000 and 2000 without commission, increase by 9%.
		• For clerks with salary below 1000, increase by 2%.
		• For other cases, apply an 8% increase if commission is 300 or more; otherwise, 5%.
    • Increment Percentage: Show the percentage increase applied based on the final salary conditions.
    • Salary Level Classification: Classify each employee’s final salary into levels as follows:
		• "Executive" if final salary is 3000 or more.
		• "High Salary" for 2000–2999.
		• "Medium Salary" for 1500–1999.
		• "Low Salary" for 800–1499.
		• "Very Low Salary" for below 800.
Only display employees with a final_salary greater than 1500.
*/

select ename, job, sal, comm, 
-- Base New Salary Calculation
case 
	when job = 'MANAGER' and sal > 2000 then sal * 1.10
	when job = 'SALESMAN' and sal between 1000 and 2000 then sal * 1.07
	when job = 'ANALYST' then sal * 1.12
	else sal * 1.05
end as base_new_salary,
    
-- Final Salary Adjustment
case 
	when job = 'MANAGER' and sal > 2000 and comm > 500 then (sal * 1.10) * 1.15
	when job = 'SALESMAN' and sal between 1000 and 2000 and (comm is null or comm = 0) then (sal * 1.07) * 1.09
	when job = 'CLERK' and sal < 1000 then (sal * 1.05) * 1.02
	when comm >= 300 then (sal * 1.05) * 1.08
	else (sal * 1.05) * 1.05
end as final_salary,
    
-- Increment Percentage
case 
	when job = 'MANAGER' and sal > 2000 and comm > 500 then '15%'
	when job = 'SALESMAN' and sal between 1000 and 2000 and (comm is null or comm = 0) then '9%'
	when job = 'CLERK' and sal < 1000 then '2%'
	when comm >= 300 then '8%'
	else '5%'
end as increment_percentage,
    
-- Salary Level Classification
case 
	when 
		(case 
			when job = 'MANAGER' and sal > 2000 and comm > 500 then (sal * 1.10) * 1.15
			when job = 'SALESMAN' and sal between 1000 and 2000 and (comm is null or comm = 0) then (sal * 1.07) * 1.09
			when job = 'CLERK' and sal < 1000 then (sal * 1.05) * 1.02
			when comm >= 300 then (sal * 1.05) * 1.08
			else (sal * 1.05) * 1.05
		end) >= 3000 then 'Executive'
	when 
		(case 
			when job = 'MANAGER' and sal > 2000 and comm > 500 then (sal * 1.10) * 1.15
			when job = 'SALESMAN' and sal between 1000 and 2000 and (comm is null or comm = 0) then (sal * 1.07) * 1.09
			when job = 'CLERK' and sal < 1000 then (sal * 1.05) * 1.02
			when comm >= 300 then (sal * 1.05) * 1.08
			else (sal * 1.05) * 1.05
		end) between 2000 and 2999 then 'High Salary'
	when 
		(case 
			when job = 'MANAGER' and sal > 2000 and comm > 500 then (sal * 1.10) * 1.15
			when job = 'SALESMAN' and sal between 1000 and 2000 and (comm is null or comm = 0) then (sal * 1.07) * 1.09
			when job = 'CLERK' and sal < 1000 then (sal * 1.05) * 1.02
			when comm >= 300 then (sal * 1.05) * 1.08
			else (sal * 1.05) * 1.05
		end) between 1500 and 1999 then 'Medium Salary'
	when 
		(case 
			when job = 'MANAGER' and sal > 2000 and comm > 500 then (sal * 1.10) * 1.15
			when job = 'SALESMAN' and sal between 1000 and 2000 and (comm is null or comm = 0) then (sal * 1.07) * 1.09
			when job = 'CLERK' and sal < 1000 then (sal * 1.05) * 1.02
			when comm >= 300 then (sal * 1.05) * 1.08
			else (sal * 1.05) * 1.05
		end) between 800 and 1499 then 'Low Salary'
	else 'Very Low Salary'
end as salary_level_classification

from EMP
where 
    (case 
        when job = 'MANAGER' and sal > 2000 and comm > 500 then (sal * 1.10) * 1.15
        when job = 'SALESMAN' and sal between 1000 and 2000 and (comm is null or comm = 0) then (sal * 1.07) * 1.09
        when job = 'CLERK' and sal < 1000 then (sal * 1.05) * 1.02
        when comm >= 300 then (sal * 1.05) * 1.08
        else (sal * 1.05) * 1.05
    end) > 1500;


----------------------------------- Task 4 -----------------------------------
/*
Write a SQL query to display the following details and calculations for each employee:
    • Employee Information:
		• Display the employee’s name in uppercase.
		• If an employee's job is "MANAGER" and their original salary is above 3000 or commission exceeds 500, set their job title to "SALESMAN." Otherwise, show the original job title in lowercase.
		• Display the original salary.
    • Adjusted Salary Based on Complex Conditions:
		• If the employee’s job (after possible reassignment to "SALESMAN") is "MANAGER" and their original salary is between 1500 and 2500, increase the salary by 8%. If their commission is NULL, add an additional 2%.
		• For all other employees with a salary below 1500, increase by 10%. If they are a "CLERK," add an extra 5%.
    • Calculate the number of characters in each employee’s name.
    • Display the employee’s name in reverse order.
    • Commission Analysis:
		• Show commission as 0 if it is NULL.
		• Display “High Commission” if the commission is above 1000, otherwise “Standard Commission.”
    • Total Earnings:
		• Calculate total earnings by adding the adjusted salary and commission.
		• Display only employees whose total earnings are greater than 2000 (using HAVING).
    • Overall Salary Statistics:
		• Calculate the average salary and maximum salary across all employees.
		• Approximate the midpoint between the minimum and maximum salaries.
*/
select upper(ename) as ename,
case
	when job = "MANAGER" and (sal > 3000 or comm > 500) then "SALESMAN"
	else lower(job)
end as job,
sal, length(ename) as ename, reverse(ename) as rev,
case
	when comm is null then 0
	else comm
end as commission,
case
	when comm > 1000 then "High Commission"
	else "Standard Commission"
end as commission_type,
-- Adjusted Salary Based on Conditions
case 
	when job = "MANAGER" and sal between 1500 and 2500 then 
		sal * (case when comm is null then 1.10 else 1.08 end)
	when sal < 1500 then 
		sal * (case when lower(job) = 'clerk' then 1.15 else 1.10 end)
	else sal
end as adjusted_salary,
-- Total Earnings: Adjusted Salary + Commission
case 
	when job = "MANAGER" and sal between 1500 and 2500 then 
		sal * (case when comm is null then 1.10 else 1.08 end) + ifnull(comm, 0)
	when sal < 1500 then 
		sal * (case when lower(job) = 'clerk' then 1.15 else 1.10 end) + ifnull(comm, 0)
	else sal + ifnull(comm, 0)
end as total_earnings,
-- Salary Level Classification
case 
	when (case 
			when job = "MANAGER" and sal between 1500 and 2500 then 
				sal * (case when comm is null then 1.10 else 1.08 end) + ifnull(comm, 0)
			when sal < 1500 then 
				sal * (case when lower(job) = 'clerk' then 1.15 else 1.10 end) + ifnull(comm, 0)
			else sal + ifnull(comm, 0)
			end) >= 3000 then 'Executive'
	when (case 
			when job = "MANAGER" and sal between 1500 and 2500 then 
				sal * (case when comm is null then 1.10 else 1.08 end) + ifnull(comm, 0)
			when sal < 1500 then 
				sal * (case when lower(job) = 'clerk' then 1.15 else 1.10 end) + ifnull(comm, 0)
			else sal + ifnull(comm, 0)
		end) between 2000 and 2999 then 'High Salary'
	when (case 
			when job = "MANAGER" and sal between 1500 and 2500 then 
				sal * (case when comm is null then 1.10 else 1.08 end) + ifnull(comm, 0)
			when sal < 1500 then 
				sal * (case when lower(job) = 'clerk' then 1.15 else 1.10 end) + ifnull(comm, 0)
			else sal + ifnull(comm, 0)
		end) between 1500 and 1999 then 'Medium Salary'
	when (case 
			when job = "MANAGER" and sal between 1500 and 2500 then 
				sal * (case when comm is null then 1.10 else 1.08 end) + ifnull(comm, 0)
			when sal < 1500 then 
				sal * (case when lower(job) = 'clerk' then 1.15 else 1.10 end) + ifnull(comm, 0)
			else sal + ifnull(comm, 0)
		end) between 800 and 1499 then 'Low Salary'
	else 'Very Low Salary'
end as salary_level
from EMP
having total_earnings > 2000;