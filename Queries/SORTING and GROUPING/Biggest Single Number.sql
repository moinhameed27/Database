/* Leetcode : https://leetcode.com/problems/biggest-single-number/ */

/* Way - I */
select max(num) as num from 
(select num from MyNumbers group by num
having count(num) = 1) as unique_numbers

/* Way - II */
select (select num from MyNumbers group by num having count(num) = 1 order by num desc limit 1) as num

/* Way - III */
select if(count(num) = 1, num, null) as num from MyNumbers
group by num order by num desc limit 1