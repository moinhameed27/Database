/* Leetcode : https://leetcode.com/problems/count-salary-categories/description/ */

/* Way - I */
-- sum will give 1 if condition satisfies and 0 otherwise
select "Low Salary" as category, 
sum(income < 20000) as accounts_count from Accounts
union
select "Average Salary" as category,
sum(income between 20000 and 50000) as accounts_count from Accounts
union
select "High Salary" as category,
sum(income > 50000) as accounts_count from Accounts

/* Way - II (CASE) */
-- count counts the non-null values or conditions
select "Low Salary" as category, 
count(case when income < 20000 then 1 end) as accounts_count 
from Accounts
union
select "Average Salary" as category,
count(case when income between 20000 and 50000 then 1 end) as accounts_count 
from Accounts
union
select "High Salary" as category,
count(case when income > 50000 then 1 end) as accounts_count 
from Accounts;