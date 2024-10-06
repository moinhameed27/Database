/* Leetcode : https://leetcode.com/problems/managers-with-at-least-5-direct-reports/description/ */ 

/* Way - I */ 
select e1.name from Employee as e1
join Employee as e2 on e1.id = e2.managerId
group by e2.managerId       /* One manager can have multiple >= 5 reports so he should appear multiple times */
having count(e2.managerId) >= 5

/* Way - II */
/* INNER JOIN : Intersection of records from two tables */ 
select e1.name from Employee as e1
inner join Employee as e2 on e1.id = e2.managerId
group by e2.managerId
having count(*) >= 5