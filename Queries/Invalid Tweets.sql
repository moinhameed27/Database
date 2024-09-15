/* Leetcode : https://leetcode.com/problems/invalid-tweets/description/ */ 

/* Way - I */ 
select tweet_id from Tweets
where length(content) > 15