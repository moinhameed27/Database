/* Leetcode : https://leetcode.com/problems/restaurant-growth/description/ */

/* Way - I */
-- Chech the visited_on date between the last 7 days for the sum and average
-- Interval starts 7th day from min(visited_on) date
select visited_on,
( select sum(amount) from Customer 
    where visited_on between date_sub(C.visited_on, interval 6 day) 
    and C.visited_on ) as amount,
round( ( select sum(amount) / 7 from Customer 
    where visited_on between date_sub(C.visited_on, interval 6 day) 
    and C.visited_on ), 2) as average_amount
from Customer as C
where visited_on >= (
    select date_add(min(visited_on), interval 6 day) from Customer
)
group by visited_on
order by visited_on

/* Way - II */
-- Window from 6 days before to current day for sum and average
select distinct visited_on,
sum(amount) over w as amount,
round(sum(amount) over w / 7, 2) as average_amount
from Customer
window w as (
    order by visited_on
    range between interval 6 day preceding and current row
)
limit 6, 999