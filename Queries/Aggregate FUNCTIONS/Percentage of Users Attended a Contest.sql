/* Leetcode : https://leetcode.com/problems/percentage-of-users-attended-a-contest/description/ */ 

/* Way - I */ 
select contest_id, round(count(user_id) * 100 / (select count(user_id) from Users), 2) as percentage
from Register
group by contest_id
order by percentage desc, contest_id

/* Way - II */ 
select contest_id, round(count(distinct R.user_id) * 100 / (count(distinct U.user_id)), 2) as percentage
from Register as R, Users as U
group by contest_id
order by percentage desc, contest_id