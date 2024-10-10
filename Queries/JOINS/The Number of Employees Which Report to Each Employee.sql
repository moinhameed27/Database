/* Leetcode :  */

select E1.employee_id, E1.name, count(E2.reports_to) as reports_count, 
round(avg(E2.age), 0) as average_age
from Employees as E1
join Employees as E2
on E1.employee_id = E2.reports_to
group by E1.employee_id
order by E1.employee_id