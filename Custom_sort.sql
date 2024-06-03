
use Practice

---Data table
create table Happiness_index(
Rank int,
Country varchar(50),
Happiness_2021 NUMERIC(3,2),
Happiness_2022 NUMERIC(3,2),
Popultion NUMERIC(15));

--custom sort, order Sweden first
select * ,
       CASE when country = 'Sweden' then '1'
	        else '2' 
		End as cntry_pr
from Happiness_index
order by cntry_pr,Rank asc


-- calculating running cost
-- creates wrong running cost when same amount exists for multiple records
select *,
  sum(amount) over(order by amount asc) as cum_cum
from transactions

-- to solve above, use another col in order or unbounded
select *,
   sum(amount) over(order by amount asc rows between unbounded preceding and current row) as cum_sum
from transactions


------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

select * from int_orders

-- Calculate the sum of amount by sales id (grouping by sales id)
select *,
sum(amount) over(partition by salesperson_id)
from int_orders



-- calculate the rolling sum/ cum sum of amount
select *,
sum(amount) over(order by salesperson_id)
from int_orders

-- calculate the rolling sum by considering above 2 records only
select *,
sum(amount) over(order by order_date rows between 2 preceding and current row) as cumsum_2
from int_orders


--- Calculating the cumsum/rolling sum for each sales id
select *,
sum(amount) over(partition by salesperson_id order by order_date)
from int_orders

-- creating lead and lag col
select *,
sum(amount) over(order by salesperson_id rows between 1 preceding and 1 preceding) as lag,
sum(amount) over(order by salesperson_id rows between 1 following and 1 following) as lead
from int_orders



