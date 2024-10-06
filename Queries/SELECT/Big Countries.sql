/* Leetcode : https://leetcode.com/problems/big-countries/description/ */ 

select name, population, area from World
where population >= 25000000 or area >= 3000000