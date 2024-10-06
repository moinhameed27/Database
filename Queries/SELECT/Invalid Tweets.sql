/* Leetcode : https://leetcode.com/problems/invalid-tweets/description/ */ 

select tweet_id from Tweets
where length(content) > 15