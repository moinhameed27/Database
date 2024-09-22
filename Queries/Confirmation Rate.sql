/* Leetcode : https://leetcode.com/problems/confirmation-rate/description/ */ 

/* Way - I (IF Condition) */ 
select S.user_id, round(avg(if(C.action = "confirmed", 1, 0)), 2) as confirmation_rate
from Signups as S 
left join Confirmations as C 
on S.user_id = C.user_id 
group by S.user_id;

/* Way - II (CASE + UNION) */ 
select user_id, round (count(case when action = "confirmed" then 1 end) / count(*), 2)
as confirmation_rate from confirmations group by user_id
union
select user_id, 0.00 as confirmation_rate from Signups where user_id not in (select user_id from confirmations)