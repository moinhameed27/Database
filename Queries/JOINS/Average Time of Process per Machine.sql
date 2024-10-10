/* Leetcode : https://leetcode.com/problems/average-time-of-process-per-machine/description/ */ 

/* Way - I (Join) */ 
select a1.machine_id, round(avg(a2.timestamp-a1.timestamp), 3) as processing_time 
from Activity a1
join Activity a2 
on a1.machine_id = a2.machine_id and a1.process_id = a2.process_id
and a1.activity_type = "start" and a2.activity_type = "end"
group by a1.machine_id

/* Way - II (Sub-Query) */ 
select machine_id, round(avg(difference), 3) as processing_time from
(
    select a2.machine_id, a2.process_id, a2.timestamp - a1.timestamp as difference
    from Activity as a1, Activity as a2
    where a1.machine_id = a2.machine_id and a1.process_id = a2.process_id and a1.activity_type = "start" and a2.activity_type = "end"
)
as subquery group by machine_id

/* Way - III (Double Column Calling) */
select a1.machine_id, round(avg(a2.timestamp - a1.timestamp), 3) as processing_time
from Activity as a1, Activity as a2
where a1.process_id = a2.process_id and a1.machine_id = a2.machine_id
and a1.activity_type = "start" and a2.activity_type = "end"
group by a1.machine_id