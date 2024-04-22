
-- Database
use Practice

-- table creation
create table emp_compensation (
emp_id int,
salary_component_type varchar(20),
val int
);

-- records into table
insert into emp_compensation
values (1,'salary',10000),(1,'bonus',5000),(1,'hike_percent',10)
, (2,'salary',15000),(2,'bonus',7000),(2,'hike_percent',8)
, (3,'salary',12000),(3,'bonus',6000),(3,'hike_percent',7);


-- view table
select * from emp_compensation

--create single row for each employee with all components as columns
select 
	emp_id,
	SUM(CASE when salary_component_type = 'salary' then val end) as salary,
	sum(CASE when salary_component_type = 'bonus' then val end) as bonus,
	SUM(CASE when salary_component_type = 'hike_percent' then val end) as hike
from
	emp_compensation
group by
     emp_id


--- Create table for pivot data
select 
	emp_id,
	SUM(CASE when salary_component_type = 'salary' then val end) as salary,
	sum(CASE when salary_component_type = 'bonus' then val end) as bonus,
	SUM(CASE when salary_component_type = 'hike_percent' then val end) as hike
into 
	emp_compensation_pivot
from
	emp_compensation
group by
     emp_id

--- Unpivot table 
select * from emp_compensation_pivot

select *
from
(
select emp_id, 'salary' as salary_component_type, salary as value from emp_compensation_pivot
union all
select emp_id, 'bonus' as salary_component_type, bonus as value from emp_compensation_pivot
union all
select emp_id, 'hike' as salary_component_type, hike as value from emp_compensation_pivot
) a
order by emp_id,salary_component_type






