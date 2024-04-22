
-- SQL top 10 questions

-- data table
create table emp(
emp_id int,
emp_name varchar(20),
department_id int,
salary int,
manager_id int,
emp_age int);

create table dept(
dept_id int,
dept_name varchar(20)
);

insert into emp
values
(1, 'Ankit', 100,10000, 4, 39), (2, 'Mohit', 100, 15000, 5, 48), (3, 'Vikas', 100, 10000,4,37),
(4, 'Rohit', 100, 5000, 2, 16), (5, 'Mudit', 200, 12000, 6,55),(6, 'Agam', 200, 12000,2, 14),
(7, 'Sanjay', 200, 9000, 2,13),(8, 'Ashish', 200,5000,2,12), (1, 'Mukesh',300,6000,6,51),
(10, 'Rakesh',300,7000,6,50);

insert into dept
values (100, 'Analytics'), (300,'Development');

-- duplicating the table
select * into emp2 from emp


--Q1 - find duplicate employee id
select emp_id, count(2) as 'count1'  from emp
group by emp_id 
having count(2) > 1 

--Q2 - delete duplicate records
select * from emp1

with cte as
(select *, ROW_NUMBER() over(partition by emp_id order by emp_id asc) as rn
from emp1)
Delete from cte where rn>1

-- Q3 - Union (removes duplicates) and union all (includes all rows)

select * from emp
union
select * from emp1

select * from emp
union all
select * from emp1


-- Q4 - Employees not present in department

-- solution 1 - sub queries (performance is impacted)
select * from emp
where department_id not in (select dept_id from dept)

-- solution 2
select emp.*, dept.*
from emp
left join dept
on emp.department_id = dept.dept_id
where dept_id is null


-- Q5 - Second highest salary in each department
select *
from
(select *,
       Dense_RANK() over(partition by department_id order by salary desc) as rk
from emp) rk_tbl
where rk = 2

-- Q6 - find all transaction done by persom
select * from emp where UPPER(emp_name) = 'ANKIT'

-- Q7 Swap the department id 100 and 200

select * from emp2

update emp2 set department_id = CASE when department_id = 100 then 200 
                                     when department_id = 200 then 100
									 else department_id 
									 end


-- Q8 Get employees whose salary greater than manager

select e.emp_id,e.emp_name as emp_name, e.salary as emp_salary,m.emp_name as manager_name,m.salary as mng_salary
from emp e
inner join emp m
on e.manager_id = m.emp_id
where e.salary > m.salary

















