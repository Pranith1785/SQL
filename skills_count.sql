
use Practice

create table students  (
student_id int,
skill varchar(20)
);
delete from students;
insert into students values
(1,'sql'),(1,'python'),(1,'tableau'),(2,'sql'),(3,'sql'),(3,'python'),(4,'tableau'),(5,'python'),(5,'tableau');

--Fetch the students who know only SQL and Python
--method 1
with cte as(
select student_id,
	sum(case when skill = 'sql' then 1 else 0 end) as sql_l,
	sum(case when skill = 'python' then 1 else 0 end) as p_l,
	sum(case when skill = 'tableau' then 1 else 0 end) as t_l
from students
group by student_id)
select * from cte
where sql_l >0 and p_l >0 and t_l  = 0

-- method 2
with cte as(
select student_id
      ,count(*) as total_skills
	  ,count( case when skill in ('sql','Python') then skill else Null end) as sql_python_cnt
from students
group by student_id)
select * from cte
where sql_python_cnt = 2 and total_skills = 2

--method 3
select student_id
      ,count(*) as total_skills
	  ,count( case when skill in ('sql','Python') then skill else Null end) as sql_python_cnt
from students
group by student_id
having count(*) = 2 and count( case when skill in ('sql','Python') then skill else Null end) = 2


--method 4
select student_id, count(*) as total_cnt
from students
where student_id not in (
				select student_id from students
				where skill not in ('sql','python'))
group by student_id
having count(*) = 2

-- method 5

select student_id from students
group by student_id
having count(*) = 2
except
select student_id from students
				where skill not in ('sql','python')


-- method 6
select student_id, count(*)
from students s1
where not exists (select * from students s2 where s2.skill not in ('sql','python') and s1.student_id = s2.student_id)
group by student_id
having count(*) = 2

-- method 7

select *
from students s
inner join students p on s.student_id = p.student_id
left join students o on s.student_id = o.student_id and o.skill not in ('sql','python')
where s.skill = 'sql' and p.skill = 'python' and  o.skill is null

--method 8
with sql as (select * from students where skill='sql')
, python as (select * from students where skill='python')
, other as (select * from students where skill not in ('sql','python'))
select student_id from sql
intersect
select student_id from python
except
select student_id from other

-- method 9
with cte as(
select student_id,
sum(case when skill in ('sql','python') then 1 else 10 end) as skill_cnt
from students
group by student_id)
select * from cte 
where skill_cnt = 2

----------------------------sub query and correlated queries
--get employees whose salary is greater than their department salary

--method 1 independent subquery
select * 
from emp e1
join (select department_id,AVG(salary) as avg_dept_salary from emp group by department_id) d
on e1.department_id = d.department_id
where salary > avg_dept_salary

-- method 2
with cte as
(select * ,
AVG(salary) over (partition by department_id) as avg_dept_salary
from emp)
select * from cte
where salary >avg_dept_salary

-- method 3 correlated subquery
select * 
from emp e1
where e1.salary > ( select AVG(e2.salary) from emp e2 where e1.department_id =  e2.department_id)













