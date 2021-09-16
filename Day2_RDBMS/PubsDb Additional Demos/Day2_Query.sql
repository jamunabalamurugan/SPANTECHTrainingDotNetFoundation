use pubs

select * from titles 

select title_id from titles

select title_id,title from titles
select title,title_id from titles
select title,type from titles
select title book_name , type book_type from titles
select title 'book name' , type book_type from titles

select * from titles where type='trad_cook'
select * from titles where type='trad_cook' or type = 'business'
select * from titles where type='trad_cook' and royalty>10

select title_id from titles where type='trad_cook' and royalty>10


select * from titles where ytd_sales between 2000 and 2500
select * from titles where ytd_sales >= 2000 and ytd_sales <=2500
select * from titles where pubdate between '1994-06-12' and '2020-11-02'

select * from titles where title like 'The%'--wildcard search %- 0 or any number of any char
select * from titles where title like '_e%'--wildcard search _- any one char
select * from titles where title like '%e_'--wildcard search _- any one char
select * from titles where title like '%e_' and title not like'%?' --wildcard search _- any one char
select * from titles where title like '%[%]%'


select * from titles where type in ('trad_cook','business')
select * from titles where type='trad_cook' or type = 'business'

select * from titles where type not in ('trad_cook','business')
select * from titles where type != 'trad_cook' and type != 'business'

select * from titles where price is null
select * from titles where price is not null

select * from titles order by price
select * from titles order by type,price,pubdate
select * from titles order by type desc,price,ytd_sales desc

select type,title_id from titles order by type desc,price,ytd_sales desc

select AVG(price) average_price from titles
select title,AVG(price) average_price from titles--wrong aggregate function and normal column cannot be clubbed
select SUM(price) 'total_price',AVG(price) average_price,min(price) minimum_price from titles
select count(price),count(title_id) from titles
select round(AVG(price),2) average_price from titles
select round(123.456,2)--0-4 no change in previous,5-9 incr 1 to previous
select round(123.456,-1)
select round(127.456,-1)
select round(627.456,-3)--wrong Arithmetic overflow error converting expression to data type numeric.
select round(127.456,-3)
select CEILING(123.456)
select Floor(123.956)
select CONCAT('hello',' ','world')
select CONCAT_ws(' ','hello','world','this','will','have','space')
select CONCAT_ws(' ',au_fname,au_lname) from authors

select UPPER(title) from titles
select Lower(title) from titles
select SUBSTRING(title,1,4) from titles
select CHARINDEX(' ',title,1) from titles
select SUBSTRING(title,CHARINDEX(' ',title,1)+1,4) from titles--second word's 4 chars
select LEN(title) from titles

select SYSDATETIME()
select GETDATE()
select FORMAT(getdate(),'dd-MMMM-yyyy hh:mm')

select pubdate,DATEADD(DAY,3,pubdate) from titles

select pubdate,DATEDiff(MONTH,pubdate,getdate()) from titles

select top 2 * from titles

select top 5 * from titles order by price 

select * from titles

select type,count(title_id),sum(price) from titles group by type
select pub_id,count(title_id) from titles group by pub_id

select pub_id,count(title_id) from titles where price>10 group by pub_id

select pub_id,count(title_id) from titles  group by pub_id having count(title_id)>5
select pub_id,count(title_id) from titles where price>10  group by pub_id having count(title_id)>3

select pub_id,count(title_id) from titles  group by pub_id having count(title_id)>5 order by 2
select pub_id,count(title_id) title_count from titles  group by pub_id having count(title_id)>5 
order by title_count
select pub_id,count(title_id) title_count from titles  group by pub_id having count(title_id)>5 
order by count(title_id)


select pub_id,count(title_id) title_count from titles 
where price>10  
group by pub_id 
having count(title_id)>3
order by count(title_id)

select * from publishers
select pub_id from publishers where pub_name = 'New Moon Books'
select * from titles where pub_id ='0736'

select * from titles where pub_id = (select pub_id from publishers where pub_name = 'New Moon Books')
select pub_id from publishers where country = 'USA'
select * from titles where pub_id in('0736','0877')
select * from titles where pub_id =(select pub_id from publishers where country = 'USA')--Wrong ubquery returned more than 1 value. 
select * from titles where pub_id in (select pub_id from publishers where country = 'USA')

select * from authors
select * from authors where au_fname = 'Johnson'
select * from titleauthor where au_id='172-32-1176'
select * from titles where title_id = 'PS3333'

select * from titles where title_id =
(select title_id from titleauthor where au_id=
(select au_id from authors where au_fname = 'Johnson'))

select * from sales where title_id in
(select title_id from titleauthor where au_id in
(select au_id from authors where au_fname = 'Michael'))

select * from titles where price> (select AVG(price) from titles)

select * from titles where price > (select max(price) from titles where type = 'business')
select * from titles where price > all (select price from titles where type = 'business')

select * from titles where price > (select min(price) from titles where type = 'business')
select * from titles where price > any (select price from titles where type = 'business')

select * from titles where 
price > any (select price from titles where type = 'business') 
and type != 'business'

select type,count(title_id) book_count from titles
where price> 10 and title_id in
(select title_id from titleauthor where au_id in
(select au_id from authors where state='CA'))
group by type
having count(title_id)>1
order by 2

select * from sales

--9. select the number of orders for every title pulished by author with first name Johnson

select title_id,count(ord_num) from sales 
where title_id in (select title_id from titleauthor where au_id =(
select au_id from authors where au_fname= 'Johnson'))
group by title_id
--10. select the number of orders for every title pulished by authors for the state CA and having price >10
select title_id,count(ord_num) from sales 
where title_id in (select title_id from titles where title_id 
in(select title_id from titleauthor where au_id in(
select au_id from authors where state= 'CA'))) and 
title_id in (select title_id from titles where price >10)
group by title_id
-- 8. select the sale data for the orders for the title published by New Moon Books
select * from sales where title_id in (select title_id from titles where pub_id =
(select pub_id from publishers where pub_name = 'New Moon Books'))
--7. select the orders placed between two given dates
select * from sales where ord_date between '1992-06-15 00:00:00.000' and '1993-05-24 00:00:00.000'

--6. select all teh sale data sorted by the order date
select * from sales order by ord_date

--5. select the sum of quantity for every title
select title_id,sum(qty) 'Total Sale' from sales group by title_id
--1) select all the sale details
 select * from sales
--2) select the order number and quantity from the sales table with proper headings
select ord_num order_number,qty quantiy from sales
--3) select all the sale data for those title with id BU1032
select * from sales where title_id ='BU1032'
--4) select the count of sale for every title
select title_id,count(title_id) as Sale_Count from sales group by title_id


select title_id from titles where title_id in (select title_id from sales)
union all
select title_id from titleauthor where au_id in(
select au_id from authors where state= 'CA')

select title_id from titles where title_id in (select title_id from sales)
intersect
select title_id from titleauthor where au_id in(
select au_id from authors where state= 'CA')

select pub_id,AVG(price) from titles group by pub_id


select title_id,title,price,pub_id from titles t
where price >(select avg(price) from titles where pub_id = t.pub_id)
order by 4


use dbShop

select * from tblEmployee
select * from tblEmployeeSkill

delete from tblEmployee where id not in(select eid from tblEmployeeSkill)


update tblEmployeeSkill set skill_level =(select AVG(skill_level) from tblEmployeeSkill)
where eid in(select eid from tblemployee where area like 'A%')