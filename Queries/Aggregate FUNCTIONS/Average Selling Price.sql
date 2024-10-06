/* Leetcode : https://leetcode.com/problems/average-selling-price/description/ */ 

/* IFNULL(expression, alternate value) : If value is null then expression otherwise go for alternate value */
select P.product_id, ifnull(round(sum(units * price) / sum(units), 2), 0) as average_price
from Prices as P
left join UnitsSold as U
on P.product_id = U.product_id and U.purchase_date between P.start_date and P.end_date
group by P.product_id