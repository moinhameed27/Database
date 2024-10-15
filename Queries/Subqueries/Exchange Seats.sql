/* Leetcode : https://leetcode.com/problems/exchange-seats/description/ */

-- If id is even, show previous id, if id is odd, show next id and if id is last and odd, show same id
/* Way - I */
select if( id < (select max(id) from Seat),
        if(id % 2 = 0, id - 1, id + 1),
        if(id % 2 = 0, id - 1, id)
) as id, student from Seat
order by id

/* Way - II */
select case 
        when id < (select max(id) from Seat) and id % 2 = 1 then id + 1
        when id % 2 = 0 then id - 1
        else id end as id,
student from Seat order by id