

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

insert into mode values (1),(2),(2),(3),(3),(3),(3),(4),(5);

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






