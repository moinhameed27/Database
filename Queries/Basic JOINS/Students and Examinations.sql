/* Leetcode : https://leetcode.com/problems/students-and-examinations/description/ */ 

/* CROSS JOIN : Returns all set of records between two tables (Cartesian Product) */
select ST.student_id, ST.student_name, SU.subject_name, count(E.subject_name) as attended_exams
from Students as ST
cross join Subjects as SU
left join Examinations as E
on ST.student_id = E.student_id and SU.subject_name = E.subject_name
group by ST.student_id, ST.student_name, SU.subject_name
order by ST.student_id, SU.subject_name