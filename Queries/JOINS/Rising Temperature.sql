/* Leetcode : https://leetcode.com/problems/rising-temperature/description/ */ 

/* Way - I */ 
/* DATEDIFF() --> Checks the difference between days */
select w1.id 
from Weather as w1, Weather as w2
where datediff(w1.recordDate, w2.recordDate) = 1 and w1.temperature > w2.temperature

/* Way - II */ 
/* DATE_ADD() --> Checks Date1 is exactly one day after Date2 */
select w1.id 
from Weather as w1
join Weather as w2
on w1.recordDate = date_add(w2.recordDate, interval 1 day)
where w1.temperature > w2.temperature