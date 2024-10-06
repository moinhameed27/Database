/* Leetcode : https://leetcode.com/problems/product-sales-analysis-i/description/ */ 

/* Way - I */ 
select P.product_name, S.year, S.price
from Product as P, Sales as S
where P.product_id = S.product_id

/* Way - II */ 
select P.product_name, S.year, S.price
from Sales as S
left join Product as P
on P.product_id = S.product_id