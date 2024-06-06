
use Practice

create table source(id int, name varchar(5))

create table target(id int, name varchar(5))

insert into source values(1,'A'),(2,'B'),(3,'C'),(4,'D')

insert into target values(1,'A'),(2,'B'),(4,'X'),(5,'F');


---Problem statement
-- Get the records which are not common in both tables along with 
-- if record present only in source ,then New in source
-- if record present only in target, then New in target
-- if record present in both but name is changed then Mismatch

--- method 1
select coalesce(s.id,t.id)as id,
     Case when s.id is null then 'New in target' 
		  when t.id is null then 'New in source' 
		  else 'Mismatch'
	End as comment
from source s
full outer join target t
on s.id = t.id
where s.name != t.name or s.name is null or t.name is null

-- method 2
with cte as(
select *, 'source' as tbl_name from source
union all
select *, 'target' as tbl_name from target)
select id, count(*) as cnt, min(name) as min_name, max(name) as max_name
, min(tbl_name) as min_tbl_name, max(tbl_name) as max_tbl_name
, case when min(name) != max(name) then 'Mismatch'
       when min(tbl_name) = 'source' then 'New in source'
	   else 'New in Target'
   End as comment
from cte
group by id
having count(*) = 1 or (count(*) =2 and MIN(name) != max(name))

--------------------------------------------------------------------------------------------

CREATE TABLE employees1  (employee_id int,employee_name varchar(15), email_id varchar(15) );
delete from employees1;
INSERT INTO employees1 (employee_id,employee_name, email_id) VALUES ('101','Liam Alton', 'li.al@abc.com');
INSERT INTO employees1 (employee_id,employee_name, email_id) VALUES ('102','Josh Day', 'jo.da@abc.com');
INSERT INTO employees1 (employee_id,employee_name, email_id) VALUES ('103','Sean Mann', 'se.ma@abc.com'); 
INSERT INTO employees1 (employee_id,employee_name, email_id) VALUES ('104','Evan Blake', 'ev.bl@abc.com');
INSERT INTO employees1 (employee_id,employee_name, email_id) VALUES ('105','Toby Scott', 'jo.da@abc.com');
INSERT INTO employees1 (employee_id,employee_name, email_id) VALUES ('106','Anjali Chouhan', 'JO.DA@ABC.COM');
INSERT INTO employees1 (employee_id,employee_name, email_id) VALUES ('107','Ankit Bansal', 'AN.BA@ABC.COM');


--- if duplicate email id is present, dont fetch the Upper case mail id
with cte as(
select *, ASCII(email_id) as ascii_cnt,
 RANK() over(partition by email_id order by ASCII(email_id) desc) rnk
from employees1)
select * from cte
where rnk = 1


---method 2 
-- changing the column collation to case sensitive
ALTER Table employees1
ALTER column email_id VARCHAR(15) collate SQL_Latin1_General_CP1_CS_AS;

with cte as(
select * 
, rank() over(partition by lower(email_id) order by ASCII(email_id) desc) as rnk
from employees1)
select * from cte
where rnk = 1



---------------------------------------------------------------------------------
--------Create points table

with cte as
(select Team_1, 
       CASE when team_1 = Winner then 1 else 0 end as win_flag
from icc_world_cup
union all 
select Team_2, 
       CASE when team_2 = Winner then 1 else 0 end as win_flag
from icc_world_cup)
select Team_1 as team, 
       count(*) as Matches_played,
	   sum(win_flag) as matches_won,
	   count(*) - sum(win_flag) as matches_lost
from cte
group by Team_1