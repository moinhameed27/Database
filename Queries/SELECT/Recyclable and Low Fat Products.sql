/* Leetcode : https://leetcode.com/problems/recyclable-and-low-fat-products/description/ */

/* Way - I */
select product_id from products
where low_fats = "Y" and recyclable = "Y"

/* Way - II */
select product_id from products
where low_fats = true and recyclable = true
