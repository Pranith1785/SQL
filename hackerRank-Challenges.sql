
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

-- 23. New Companies

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


-- 24. Occupations

select Doctor,Professor,Singer,Actor
From
(Select Name, occupation from Occupations)t
PIVOT
(max(Name) for occupation IN (Doctor,Professor,Singer,Actor)) as t2;


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

