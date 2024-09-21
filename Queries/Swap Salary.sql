/* Leetcode : https://leetcode.com/problems/swap-salary/description/ */ 

/* Way - I */ 
update Salary
set sex = 
case
    when sex = "f" then "m"
    else "f"
end;

/* Way - II */ 
update Salary
set sex = (case when sex = "f" then "m" else "f" end);