/* Leetcode : https://leetcode.com/problems/triangle-judgement/description/ */

/* Way - I (IF) */
select x, y, z, 
if(x + y > z and y + z > x and x + z > y, "Yes", "No") as triangle
from Triangle

/* Way - II (CASE) */
select *,
case when x + y > z and y + z > x and x + z > y then "Yes" else "No" end
as triangle from Triangle