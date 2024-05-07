

use Practice


select * from dbo.colors
insert into dbo.colors values (1,'red')
insert into dbo.colors values (5,'Black')

select * from dbo.sizes
insert into dbo.sizes values (1,'S')
Insert into dbo.sizes values (4,'XXL')

--- Joins
-- INNER
select * from dbo.colors c
INNER JOIN dbo.sizes s
on c.color_id = s.size_id

-- Left
select * from colors c
left join sizes s
on c.color_id = s.size_id

-- Right
select * from colors c
right join sizes s
on c.color_id = s.size_id

--Outer Join
select * from colors c
full outer join sizes s
on c.color_id =  s.size_id


---- Calculate the MODE
create table mode 
(
id int
);

insert into mode values (1),(2),(2),(3),(3),(4),(4),(5);

-- Method 1 - CTE
with cte_freq as 
(select id, count(*) as freq from mode group by id)
select * from cte_freq 
where freq = (select max(freq) from cte_freq )

insert into mode values (4),(4),(4);

--Method 2 - Rank and two CTE's
with cte_freq_1 as 
(select id, count(*) as freq from mode group by id)
, rk_cte as(
select id, freq, RANK() over( order by freq desc) as rk
from cte_freq_1)
select * from rk_cte where rk=1



----- Employees whos status is changed
create table emp_2020
(
emp_id int,
designation varchar(20)
);

create table emp_2021
(
emp_id int,
designation varchar(20)
)

insert into emp_2020 values (1,'Trainee'), (2,'Developer'),(3,'Senior Developer'),(4,'Manager');
insert into emp_2021 values (1,'Developer'), (2,'Developer'),(3,'Manager'),(5,'Trainee');

-- Solution

select isnull(e0.emp_id, e1.emp_id),
CASE when e0.designation != e1.designation then 'Promoted'
     when e0.designation is null then 'New'
	 else 'Resigned'
	 End as comment
from emp_2020 e0
full outer join emp_2021 e1
on e0.emp_id = e1.emp_id
where isnull(e0.designation,'ABC') != isnull(e1.designation,'DEF')



-- create a duplicate based on column
with cte_freq as
(select id from mode group by id having count(*) > 1)
, rk_cte as
(select id, RANK() over(order by id) as rk  from cte_freq)
select c.id, 'DUP ' + CAST(rc.rk as varchar(4)) rk_char
from rk_cte rc
right join mode c
on rc.id = c.id


