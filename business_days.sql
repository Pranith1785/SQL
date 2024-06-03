
use Practice


-- calculate the number of days to resolve the tickets
-- provide total days, business days and removing public holidays


select *,
       DATEDIFF(day,create_date,resolved_date) as total_days_taken,
	   DATEDIFF(week,create_date,resolved_date) as week_diff,
	   DATEDIFF(DAY,create_date,resolved_date) - 2*(DATEDIFF(week,create_date,resolved_date)) as business_days,
	   DATEPART(week,resolved_date) as week_num
from dbo.tickets

with CTE as
(
select t.ticket_id, t.create_date, resolved_date, count(holiday_date) as no_of_holidays from tickets t
left join (select * from holidays where datename(dw,holiday_date) <> 'Saturday')h
on h.holiday_date between t.create_date and t.resolved_date
group by t.ticket_id, t.create_date, resolved_date)
select *,
       DATEDIFF(day,create_date,resolved_date) as total_days_taken,
	   DATEDIFF(DAY,create_date,resolved_date) - 2*(DATEDIFF(week,create_date,resolved_date)) as business_days,
	   DATEDIFF(DAY,create_date,resolved_date) - 2*(DATEDIFF(week,create_date,resolved_date)) - no_of_holidays as business_days_ex_holidays
from cte



-- get the count the filter count


select value as room_type, count(*) as cnt from dbo.airbnb_searches
cross apply string_split(filter_room_types,',')
group by value
order by cnt desc


with cte_table as 
(select count(case when filter_room_types like '%entire home%' then 1 End) as 'entire home',
count(case when filter_room_types like '%private room%' then 1 End) as 'private room',
count(case when filter_room_types like '%shared room%' then 1 End) as 'shared room'
from 
airbnb_searches)
Select value, i as count_room_type from cte_table
unpivot
(
 i for value in ([entire home],[private room],[shared room])
) as unpivot_table
ORDER By i DESC;
 







