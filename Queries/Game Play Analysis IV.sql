/* Leetcode : https://leetcode.com/problems/game-play-analysis-iv/description/ */ 

/* Way - I */ 
select round(count(distinct player_id) / (select count(distinct player_id) from Activity), 2)
as fraction from Activity
where (player_id, date_sub(event_date, interval 1 day)) in
(
    select player_id, min(event_date) as first_login
    from Activity group by player_id
)

/* Way - II */ 
select round(count(distinct A1.player_id) / (select count(distinct player_id) from activity), 2) 
as fraction from activity as A1
join (select player_id, min(event_date) as first_login from activity group by player_id) as A2
on A1.player_id = A2.player_id and datediff(A1.event_date, A2.first_login) = 1