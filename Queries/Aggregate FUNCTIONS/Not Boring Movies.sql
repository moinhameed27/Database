/* Leetcode : https://leetcode.com/problems/not-boring-movies/description/ */ 

/* Way - I */ 
select * from Cinema 
where id % 2 = 1 and description not in ("boring")
order by rating desc

/* Way - II */ 
select * from Cinema 
where mod(id, 2) = 1 and description != "boring"
order by rating desc