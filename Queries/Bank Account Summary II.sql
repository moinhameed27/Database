/* Leetcode : https://leetcode.com/problems/bank-account-summary-ii/ */ 

/* Way - I */ 
select U.name, sum(amount) as balance
from Users as U, Transactions as T
where U.account = T.account
group by T.account
having sum(amount) > 10000

/* Way - II */ 
select U.name , sum(T.amount) as balance 
from Users as U
left join Transactions as T
on U.account = T.account
group by U.name
having sum(T.amount) > 10000;