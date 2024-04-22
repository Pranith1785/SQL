

-- Cross Join Examples

create table products (
id int,
name varchar(10)
);
insert into products VALUES 
(1, 'A'),(2, 'B'),(3, 'C'),(4, 'D'),(5, 'E');

create table colors (
color_id int,
color varchar(50)
);
insert into colors values (1,'Blue'),(2,'Green'),(3,'Orange');

create table sizes
(
size_id int,
size varchar(10)
);

insert into sizes values (1,'M'),(2,'L'),(3,'XL');

create table transactions
(
order_id int,
product_name varchar(20),
color varchar(10),
size varchar(10),
amount int
);
insert into transactions values (1,'A','Blue','L',300),(2,'B','Blue','XL',150),(3,'B','Green','L',250),(4,'C','Blue','L',250),
(5,'E','Green','L',270),(6,'D','Orange','L',200),(7,'D','Green','M',250);


-- Get transaction details of all products, color, sizes

with mstdata as(
select p.name, c.color, s.size from products p, colors c, sizes s)
, sales as (
select product_name,color,size, SUM(amount) as total from transactions
group by product_name,color,size)
select m.name, m.color, m.size, ISNULL(s.total,0) as total
from mstdata m
left join sales s
on m.name = s.product_name and m.color = s.color and m.size = s.size
order by s.total desc


---- Creating huge data for performance testing

--- empty table of transaction to save huge data
select * into transaction_test from transactions where 1=2
select * from transaction_test

Insert into transaction_test
select  ROW_NUMBER() over(order by t.order_id asc) as order_id , 
		t.product_name,t.color, 
		CASE when ROW_NUMBER() over(order by t.order_id asc)%3=0 then 'M'
		     when ROW_NUMBER() over(order by t.order_id asc)%5=0 then 'L'
		     else 'XL' end size , 
		t.amount 
from transactions t, sizes, products, colors, transactions t2, transactions t3
