/* Leetcode : https://leetcode.com/problems/movie-rating/description/ */

-- Highest Frequency User and Highest Rated Movie in February 2020
(select U.name as results from MovieRating as MR
join Users as U on MR.user_id = U.user_id
group by MR.user_id
order by count(MR.user_id) desc, U.name
limit 1)
union all
(select M.title as results from MovieRating as MR
join Movies as M on MR.movie_id = M.movie_id
where MR.created_at like "2020-02%"
group by MR.movie_id
order by avg(MR.rating) desc, M.title
limit 1)