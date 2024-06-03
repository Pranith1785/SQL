


create table del_dup(
emp_id int,
emp_name VARCHAR(20),
salary int,
create_timestamp datetime
)

Insert into del_dup values (1,'PRanith',99000,'2024-05-30 20:56:20.617')

select * from del_dup

use Practice

-- method 1

DELETE FROM del_dup where(emp_id) in (select emp_id as create_timestamp from del_dup group by emp_id having count(*) > 1)

--method 2  
-- remove the dulpicates where all rows are same
-- create a backup table, delete all records from del_dup and insert unique records to del_dup
select * into test_backup from del_dup
delete from del_dup

insert into del_dup select distinct * from test_backup


--- method 3
Delete from test_backup

insert into test_backup 
select emp_id, emp_name,salary, create_timestamp 
from
(select * , ROW_NUMBER() over(partition by emp_id order by salary asc) as row_num
from del_dup) A
where row_num =1


-- method 4 Rank cte
with CTE as
(select * , ROW_NUMBER() over(partition by emp_id order by salary asc) as row_num
from del_dup)
delete from CTE where row_num > 1

select * from del_dup



-------------------------------------------------------------------------------------------------
--- first and last value from employee table

select * from employee

select *,
FIRST_VALUE(emp_name) over(order by salary) 
from employee


---last value is giving wrong results,it is ordering ages and checking only preceding rows for calculating last value
select * ,
LAST_VALUE(emp_name) over(order by emp_age)
From Employee

-- Fix for above solution
-- method 1 use first value but order by desc
select *,
FIRST_VALUE(emp_name) over(order by emp_age desc) highest_age_person
from Employee

-- method 2 using rows
select *,
LAST_VALUE(emp_name) over(order by emp_age rows between current row and unbounded following) as highest_age_person
from employee















