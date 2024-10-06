/* Leetcode : https://leetcode.com/problems/replace-employee-id-with-the-unique-identifier/description/ */ 

select EUT.unique_id, ET.name 
from Employees as ET
left join EmployeeUNI as EUT
on EUT.id = ET.id