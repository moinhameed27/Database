/* Leetcode : https://leetcode.com/problems/primary-department-for-each-employee/description/ */

/* Either Employee has a primary Flag 'Y' or he owns only one apartment. */
select employee_id, department_id
from Employee where primary_flag = "Y"
or employee_id in 
(select employee_id from Employee group by employee_id having count(employee_id) = 1)