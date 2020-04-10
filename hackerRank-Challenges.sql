

--- Hacker Rank Challenges

--Problem Statement
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