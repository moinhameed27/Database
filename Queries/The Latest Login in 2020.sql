/* Leetcode : https://leetcode.com/problems/the-latest-login-in-2020/ */ 

/* Way - I */ 
select user_id, max(time_stamp) as last_stamp
from Logins
where year(time_stamp) = "2020"
group by user_id

/* Way - II */ 
select user_id, max(time_stamp) as last_stamp
from Logins
where time_stamp like "2020%"
group by user_id