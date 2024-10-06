/* Leetcode : https://leetcode.com/problems/queries-quality-and-percentage/description/ */ 

/* Way - I */ 
select query_name, round(sum(rating / position) / count(query_name), 2) as quality, 
round(sum(if(rating < 3, 1, 0)) / count(query_name) * 100, 2) as poor_query_percentage
from Queries 
where query_name is not null
group by query_name

/* Way - II */ 
select query_name, round(avg(rating / position), 2) as quality, 
round(sum(if(rating < 3, 1, 0)) / count(*) * 100, 2) as poor_query_percentage
from Queries 
where query_name is not null
group by query_name