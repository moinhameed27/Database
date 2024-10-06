/* Leetcode : https://leetcode.com/problems/customer-who-visited-but-did-not-make-any-transactions/description/ */ 

select V.customer_id, count(V.visit_id) as count_no_trans
from Visits as V
left join Transactions as T
on V.visit_id = T.visit_id
where T.transaction_id is null
group by customer_id