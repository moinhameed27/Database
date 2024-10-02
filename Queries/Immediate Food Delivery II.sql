/* Leetcode : https://leetcode.com/problems/immediate-food-delivery-ii/description/ */ 

/* See where earliest order date matches the customer_pref_delivery_date, meaning it's the first and immediate order. */
/* Way - I */ 
select round(avg(order_date = customer_pref_delivery_date) * 100, 2) 
as immediate_percentage from Delivery
where (customer_id, order_date) in (
    select customer_id, min(order_date)
    from Delivery group by customer_id
)

/* Way - II */ 
select round(sum(order_date = customer_pref_delivery_date) / count(distinct customer_id) * 100, 2) 
as immediate_percentage from Delivery
where (customer_id, order_date) in (
    select customer_id, min(order_date)
    from Delivery group by customer_id
)