/* Leetcode : https://leetcode.com/problems/customers-who-bought-all-products/description/ */

-- Cusomters from Customer table should have bought all the products from the Product table
select customer_id from Customer group by customer_id
having count(distinct product_key) = (select count(product_key) from Product)