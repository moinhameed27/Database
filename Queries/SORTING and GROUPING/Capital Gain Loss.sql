/* Leetcode : https://leetcode.com/problems/capital-gainloss/description/ */ 

/* Way - I */ 
select stock_name, sum( if(operation = "Buy", -price, price) )  
as capital_gain_loss from stocks 
group by stock_name

/* Way - II */ 
select stock_name, sum(
    case
        when operation = 'Buy' then -price
        else price
    end
) as capital_gain_loss
from Stocks
group by stock_name