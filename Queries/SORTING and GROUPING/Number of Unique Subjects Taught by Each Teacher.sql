/* Leetcode : https://leetcode.com/problems/number-of-unique-subjects-taught-by-each-teacher/description/ */

Select  teacher_id, 
count(distinct subject_id ) as cnt from Teacher
group by teacher_id 