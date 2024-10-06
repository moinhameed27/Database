/* Leetcode : https://leetcode.com/problems/project-employees-i/description/ */ 

select P.project_id, round(avg(E.experience_years), 2) as average_years
from Project as P
left join Employee as E
on P.employee_id = E.employee_id
group by P.project_id