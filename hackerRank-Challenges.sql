
--- Hacker Rank Challenges

-- Basic SQL

-- 1. Revising the Select Query I
Select * from CITY 
where POPULATION > 100000 
And
CountryCode = 'USA'

-- 2. Revising the Select Query II
Select Name from CITY 
Where POPULATION > 120000 
and 
CountryCode = 'USA';

-- 3. Select All
Select * from CITY

-- 4. Select by ID
select NAME from CITY
Where ID = '1661'

-- 5. Japanese Cities' Attributes
Select * from City 
where CountryCode = 'JPN'

-- 6. Japanese Cities' Names
Select name from city 
WHERE countrycode = 'JPN'

-- 7. Weather Observation Station 1
Select city,state from station

-- 8. Weather Observation Station 3
Select distinct(city) from Station 
WHERE mod(id, 2) = 0;

-- 9. Weather Observation Station 4
Select count(CITY) - count(distinct(city))
FROM STATION

-- 10. Weather Observation Station 5
Select CITY, LENGTH(CITY)
FROM STATION
ORDER By LENGTH(CITY), CITY asc
LIMIT 1

Select CITY, LENGTH(CITY)
FROM STATION
ORDER By LENGTH(CITY) desc
LIMIT 1

-- 11. Weather Observation Station 6
SELECT DISTINCT(CITY)
FROM STATION
WHERE CITY Rlike '^[aeiou].*'

-- 12. Weather Observation Station 7
SELECT DISTINCT(CITY)
FROM STATION
WHERE CITY Rlike '.*[aeiou]$'

-- 13. Weather Observation Station 8
SELECT DISTINCT(CITY)
FROM STATION
WHERE CITY Rlike '^[aeiou].*[aeiou]$'

-- 14. Weather Observation Station 9
select distinct city 
from station
where city not Rlike '^[aeiou].*';

-- 15. Weather Observation Station 10
select distinct city 
from station
where city not Rlike '.*[aeiou]$';


-- 16. Weather Observation Station 11
select distinct city 
from station
where city not Rlike '^[aeiou].*[aeiou]$';

-- 17. Weather Observation Station 12
select distinct city 
from station
where city not Rlike '^[aeiou].*'
AND
city not Rlike '.*[aeiou]$'

-- 18. Higher Than 75 Marks
select Name
from STUDENTS
where marks > 75
order by RIGHT(Name,3), ID asc;

-- 19. Employee Names
select name
From Employee
order by name asc;

--20. Employee Salaries
select name
From Employee
where salary > 2000
AND months < 10
order by name asc;

-- Advanced SQL

-- 21. Type of Triangle
Select Case
		  when a+b > c and b+c > a and c+a > b then
			  CASE
				 When a =b and b =c and c = a then "Equilateral"
				 when a!=b and b!=c and c!=a then "Scalene"
				 else "Isosceles"
			  END
		   Else "Not a triangle"
		END
From Triangles

-- 22. The PADS

Select CONCAT(name,"(",LEFT(Name,0),")")
From OCCUPATIONS
order by name asc

Select CONCAT("There are a total of", count(*), lower(OCCUPATION) ,".s")
From OCCUPATIONS 
Group by OCCUPATION
order by count(*), occupation asc

-- 23. Binary Tree Nodes
select N, 
	if(P is null,'Root',
	        if((select count(*) from bst where P = B.N)>0,'Inner','Leaf'))
from BST as B
order by N

-- 24. New Companies

select c.company_code,c.founder,
       count(distinct(lm.lead_manager_code)),
       count(distinct(sm.senior_manager_code)),
       count(distinct(m.manager_code)),
	   count(distinct(e.employee_code)) 
From
    company c,
    lead_manager lm,
    senior_manager sm,
    manager m,
    employee e
where
	c.company_code = lm.company_code and
	lm.lead_manager_code = sm.lead_manager_code and
	sm.senior_manager_code = m.senior_manager_code and
	m.manager_code = e.manager_code
group by c.company_code,c.founder
order by c.company_code


-- 25. Occupations
--SQL server
select Doctor,Professor,Singer,Actor
From
(Select Name, occupation from Occupations)t
PIVOT
(max(Name) for occupation IN (Doctor,Professor,Singer,Actor)) as t2;

--mysql
set @r1=0, @r2=0, @r3=0, @r4=0;
select min(Doctor), min(Professor), min(Singer), min(Actor)
from(
  select case when Occupation='Doctor' then (@r1:=@r1+1)
            when Occupation='Professor' then (@r2:=@r2+1)
            when Occupation='Singer' then (@r3:=@r3+1)
            when Occupation='Actor' then (@r4:=@r4+1) end as RowNumber,
    case when Occupation='Doctor' then Name end as Doctor,
    case when Occupation='Professor' then Name end as Professor,
    case when Occupation='Singer' then Name end as Singer,
    case when Occupation='Actor' then Name end as Actor
  from OCCUPATIONS
  order by Name
) Temp
group by RowNumber


---- Aggregration

--26. Revising Aggregations - The Count Function
Select count(Name)
From CITY
Where Population > 100000

--27. Revising Aggregations - The Sum Function
select sum(POPULATION) from CITY where DISTRICT = 'California'

--28. Revising Aggregations - Averages
select avg(Population) from City where District = 'California'

--29. Average Population
select ROUND(avg(Population)) from City

--30. Japan Population
select sum(Population) from City where COUNTRYCODE = 'jpn'

--31. Population Density Difference
select max(Population)-min(Population) from City

--32. The Blunder
select CEIL(avg(salary) - avg(replace(salary,'0',''))) from employees

--33. Top Earners
Select max(salary*months) as earnings,count(*)
From Employee
group by earnings 
order by earnings desc 
Limit 1

--34. Weather Observation Station 2
Select round(sum(lat_n),2),round(sum(long_w),2)
From Station

--35. Weather Observation Station 13
Select truncate(sum(lat_n),4)
From Station
where lat_n > 38.7880
and lat_n < 137.2345

--36. Weather Observation Station 14
Select truncate(max(lat_n),4)
From Station
where lat_n < 137.2345

--37. Weather Observation Station 15
Select round(long_w,4)
From Station
Where lat_n = (select max(lat_n) from station where lat_n < 137.2345)

--38. Weather Observation Station 16
Select round(min(lat_n),4)
From Station
where lat_n > 38.7780

--39. Weather Observation Station 17
Select round(long_w,4)
from station
where lat_n = (select min(lat_n) from station where lat_n>38.7780)

--40. Weather Observation Station 18
Select round((max(lat_n)-min(lat_n)) + (max(long_w) - min(long_w)),4) 
from station

--41. Weather Observation Station 19
Select truncate(sqrt(power(max(lat_n)-min(lat_n),2) + power(max(long_w) - min(long_w),2)),4) 
from station

--42. Weather Observation Station 20
select round(lat_n,4) as median 
From station s
where (select count(lat_n) from station where s.lat_n>lat_n) =
 (select count(lat_n) from station where s.lat_n<lat_n)

 ---- Basic Join

 --43. Asian Population
 select sum(c.population)
 From city as c
 Inner Join country ct
 ON c.CountryCode = ct.code
 where ct.continent = 'Asia'

--44. African Cities
Select a.name
From city a
Inner Join Country b
ON a.CountryCode = b.Code
Where b.Continent = 'Africa'

--45. Average Population of Each Continent
Select b.continent,floor(AVG(a.population))
from city a
Inner Join country b
ON a.countrycode = b.code
group by b.continent

--46. The Report
Select if(g.grade>=8,s.Name,Null), g.grade, s.Marks
From Students s
Inner Join Grades g
ON s.marks between g.min_mark and g.max_mark
Order by g.grade desc, Name asc,s.marks

--47. Contest Leaderboard
Select h.hacker_id,h.name, sum(new.ms) as hs
From hackers h
inner join 
	(Select hacker_id, max(score) as ms
	From submissions
	group by hacker_id,challenge_id) new
ON h.hacker_id = new.hacker_id
group by h.hacker_id,h.name
having hs > 0
order by hs desc, h.hacker_id

--48. Top Competitors
select h.hacker_id,h.name,count(*)
from submissions s
Inner Join challenges c
ON s.challenge_id = c.challenge_id
Inner join difficulty d
ON c.difficulty_level = d.difficulty_level
Inner join hackers h
ON h.hacker_id = s.hacker_id
where s.score = d.score and c.difficulty_level = d.difficulty_level
group by h.hacker_id,h.name
having count(*) > 1
order by count(*) desc, h.hacker_id asc

--49. Ollivander's Inventory
select a.id, b.age, a.coins_needed, a.power 
from Wands a 
inner join Wands_Property b 
on a.code=b.code 
where b.is_evil != 1 
and a.coins_needed=(select min(Wands.coins_needed) 
                    from Wands 
                    inner join Wands_Property 
                    on Wands.code=Wands_Property.code 
                    where Wands_Property.age=b.age 
                    and Wands.power=a.power) 
order by a.power desc,b.age desc

--50. Challenges

select H.hacker_id, H.name, count(*) as total
from Hackers H, Challenges C
where H.hacker_id = C.hacker_id
group by H.hacker_id, H.name
having total = 
    (select count(*)
     from challenges
     group by hacker_id 
     order by count(*) desc limit 1
     )
or total in
    (select total
     from (
        select count(*) as total
        from Challenges
        group by hacker_id
      ) counts
     group by total
     having count(*) = 1)
order by total desc, H.hacker_id asc

---- Advanced Join

--51. Placements

Select s.name
From students s
inner join friends f
ON s.id = f.id
inner join packages p1
on s.id = p1.id
inner join packages p2
on f.friend_id = p2.id
where p1.salary < p2.salary
order by p2.salary asc


-- 52. Symmetric Pairs

with f as(
    Select X,Y,
            ROW_NUMBER() OVER ( 
                PARTITION BY X,Y
                ORDER BY X) as row_num
    From functions
)
select Distinct f1.x,f1.y
From f as f1
join functions f2
on f1.x = f2.y and f1.y = f2.x 
		and (f1.x != f1.y or f1.row_num>1)
Where f1.x<=f1.y  
order by f1.x


-- 53. SQL Project Planning

Select start_date,min(end_date)
from
  (select Start_date
  from projects
  where start_date not in 
        ( select end_date from projects)) a,   
  (select end_date
  from projects
  where end_date not in 
      ( select start_date from projects)) b
where start_date < end_date
group by start_date
order by datediff(day,start_date,min(end_date)),start_date


-- 54. Interviews

Select cn.contest_id,cn.hacker_id,cn.name,
       sum(ss.ts),sum(ss.tas),
       sum(vs.tv),sum(vs.tuv)
From contests cn
join Colleges cl
     On cn.contest_id = cl.contest_id
join Challenges cg
     On cl.college_id = cg.college_id
left join (select challenge_id, sum(total_views) as tv,
                          sum(total_unique_views) as tuv
           from View_Stats
           group by challenge_id) vs
      On cg.challenge_id = vs.challenge_id
left join (select challenge_id,sum(total_submissions) as ts,
                          sum(total_accepted_submissions) as tas
            From Submission_stats
            group by challenge_id) ss
      On cg.challenge_id = ss.challenge_id
group by cn.contest_id,cn.hacker_id,cn.name
having sum(ss.ts) + sum(ss.tas) + sum(vs.tv) + sum(vs.tuv) > 0
order by cn.contest_id


-- 55. 15 days of Learning SQL 

Select uq_hc.submission_date,uq_hc.hc_cnt,max_sub.hacker_id,h.name
From
	(select rt.submission_date, COUNT(DISTINCT(rt.hacker_id)) as hc_cnt
	from
	(select submission_date, hacker_id,
		DENSE_RANK() over(order by submission_date) as date_rank,
		DENSE_RANK() over(partition by hacker_id order by submission_date) as hacker_rank
	from submissions) rt
	where rt.date_rank = rt.hacker_rank
	group by rt.submission_date) uq_hc
join
	(select ct.submission_date,ct.hacker_id,
			rank() over(partition by ct.submission_date
						order by ct.cnt desc,ct.hacker_id) as rnk
	from
	(select submission_date,hacker_id,count(submission_id) as cnt
	from submissions
	group by submission_date,hacker_id) ct) max_sub
ON
  uq_hc.submission_date = max_sub.submission_date 
  and
  max_sub.rnk =1
Join 
   hackers h
ON 
  h.hacker_id = max_sub.hacker_id
order by uq_hc.submission_date


---- Alternative Queries 

-- 56. Draw The Triangle 1

-- method 1
with nt as (
    select 5 r
	union all
	select r-1 r from nt where r >1
)select REPLICATE('* ',r) from nt

--method 2
Declare @cnt INT = 5;

while @cnt > 0
BEGIN
	print REPLICATE('* ',@cnt);
	SET @cnt = @cnt - 1;
END;

-- 57. Draw The Triangle 2
with nt as (
    select 1 r
	union all
	select r+1 r from nt where r <20
)select REPLICATE('* ',r) from nt