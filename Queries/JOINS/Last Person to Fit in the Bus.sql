/* Leetcode : https://leetcode.com/problems/last-person-to-fit-in-the-bus/description/ */

/* Way - I */
-- Select the rows where sum of weights <= 1000 and give the last person name by ordering by turn in descending order limit 1
select person_name from Queue as q1
where 1000 >= (select sum(weight) from Queue as q2 where q1.turn >= q2.turn)
order by turn desc limit 1

/* Way - II */
-- Select the groups having sum of weights <= 1000 and give the last person name by ordering by sum of weights in descending order limit 1
select q1.person_name from Queue as q1
join Queue as q2 on q1.turn >= q2.turn
group by q1.turn
having sum(q2.weight) <= 1000
order by sum(q2.weight) desc limit 1