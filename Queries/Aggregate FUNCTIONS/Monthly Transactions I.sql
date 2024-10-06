/* Leetcode : https://leetcode.com/problems/monthly-transactions-i/description/ */ 

/* Way - I */ 
/* SUBSTR : Get the substring from the string */
select substr(trans_date, 1, 7) as month,
country, count(*) as trans_count, 
sum(case when state = "approved" then 1 else 0 end) as approved_count,
sum(amount) as trans_total_amount,
sum(case when state = "approved" then amount else 0 end) as approved_total_amount
from Transactions
group by month, country

/* Way - II */ 
/* LEFT : Get the left part of the string from a index */
select left(trans_date, 7) as month,
country, count(*) as trans_count, 
sum(if(state = "approved", 1, 0)) as approved_count,
sum(amount) as trans_total_amount,
sum(if(state = "approved", amount, 0)) as approved_total_amount
from Transactions
group by month, country

/* Way - III */
select left(trans_date, 7) as month,
country, count(*) as trans_count, 
sum(state = "approved") as approved_count,
sum(amount) as trans_total_amount,
sum((state = "approved") * amount) as approved_total_amount
from Transactions
group by month, country