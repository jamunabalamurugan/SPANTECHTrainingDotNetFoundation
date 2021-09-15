--print the publisher name and the title that they have published
select title,pub_name from titles join publishers
on   publishers.pub_id =titles.pub_id

select title,pub_name from titles,publishers
where titles.pub_id = publishers.pub_id

select title,pub_name from titles t join publishers p
on p.pub_id =t.pub_id

select title,pub_name from titles t,publishers p
where t.pub_id = p.pub_id


select * from stores
select * from pub_info

select * from stores,pub_info
select * from stores cross join pub_info
select * from stores s1 , stores s2

select distinct(title_id) from sales

select title_id from titles

select title, title_id from titles where title_id not in 
(select distinct(title_id) from sales)

--PC9999
--MC3026

--Net Etiquette
--The Psychology of Computer Cooking

--qty,ord_num,title_name
select qty,title,ord_num from titles t join sales s
on t.title_id = s.title_id
select ord_num order_number,title book_name,qty quantity,price ,qty*price amount 
from titles t join sales s
on t.title_id = s.title_id


select ord_num order_number,t.title_id ,title book_name,qty quantity,price ,qty*price amount 
from titles t join sales s
on t.title_id = s.title_id

select ord_num,title,pub_name, qty from titles t join sales s
on t.title_id = s.title_id 
join publishers p
on p.pub_id = t.pub_id

--print the employee name, title name for every book published
select CONCAT_WS(' ',fname,lname) employee_name, title book_name, pub_name publisher_name
from employee e join titles t
on t.pub_id = e.pub_id
join publishers p on p.pub_id = e.pub_id

select CONCAT_WS(' ',fname,lname) employee_name, title book_name, pub_name publisher_name
from employee e join titles t
on t.pub_id = e.pub_id
join publishers p on p.pub_id = e.pub_id
where price>10

select CONCAT_WS(' ',fname,lname) employee_name, title book_name, pub_name publisher_name
from employee e,titles t,publishers p
where t.pub_id = e.pub_id and p.pub_id = e.pub_id
and price>10

select title,sum(qty) total_quantity_sold from sales s join titles t
on t.title_id = s.title_id
group by title
--select the publisher's name and the count the number books published
select pub_name,count(title_id) count_Of_books_published from publishers p join titles t
on t.pub_id = p.pub_id
group by pub_name

select pub_name,count(title_id) count_Of_books_published from publishers p join titles t
on t.pub_id = p.pub_id
where price is not null
group by pub_name
having count(title_id) <6
order by pub_name

--list the store name and count the number of publishers sold by them only if 
--they have sold more than one publisher's work. sort the output with number of publisher's
select stor_name,count(distinct(t.pub_id)) from stores st join sales s
on st.stor_id = s.stor_id
join titles t on t.title_id = s.title_id
group by stor_name
having count(distinct(t.pub_id)) > 1
order by 2

select title,ord_num from titles t left outer join sales s
on t.title_id = s.title_id
order by 2

select title,ord_num from sales s right outer join titles t
on t.title_id = s.title_id
order by 2

--publisher name,title,order num
select pub_name,title,ord_num from sales s right outer join titles t
on s.title_id = t.title_id
left outer join publishers p on p.pub_id = t.pub_id

select pub_name,title,ord_num from sales s right outer join titles t
on s.title_id = t.title_id
right outer join publishers p on p.pub_id = t.pub_id

--get all the publisher name, employee full name and title of the books.
select pub_name, concat(fname,' ',lname),title from publishers left outer join employee
on publishers.pub_id = employee.pub_id
left outer join titles on titles.pub_id = publishers.pub_id



--1) print the employee name and the number of titles each of them have published
select concat(fname,' ',lname),count(title_id) from employee e 
join titles t
on t.pub_id=e.pub_id
group by concat(fname,' ',lname)
--2) print the store name, title name, total price , quantity, price, publisher name for every book
select title book,stor_name, qty*price total, qty,price, pub_name from sales s join stores s1
on s1.stor_id = s.stor_id
join titles t
on t.title_id = s.title_id
join publishers p
on p.pub_id =t.pub_id


--3) print every book name and  its auth's full name
select concat(au_fname,' ',au_lname) as name,title from titles t join titleauthor ta
                   on t.title_id=ta.title_id
                   join authors a
                   on a.au_id=ta.au_id
--4) print the author's full name and number of books written by each
select concat(au_fname,' ',au_lname),count(t.title_id)
from titles t join titleauthor ta on ta.title_id = t.title_id
join authors a on a.au_id = ta.au_id
group by concat(au_fname,' ',au_lname)

--5) print the author full name, publisher's name, title name, quantity sold, store name and the store address of all the books.
select concat(au_fname,' ',au_lname),pub_name ,title, qty, stor_name , stor_address
   from authors a join titleauthor ta on a.au_id= ta.au_id
   join titles t on t.title_id = ta.title_id
   join publishers p on p.pub_id =t.pub_id
   join sales s on s.title_id = t.title_id
   join stores st on st.stor_id =s.stor_id


select concat(au_fname,' ',au_lname) Author_Name,title from titles t  
join titleauthor ta on t.title_id = ta.title_id  join authors a on a.au_id = ta.au_id

create table tblEmployee
(eid int primary key,
ename varchar(20),
mid int)

select * from tblEmployee

alter table tblEmployee
add constraint fk_MID foreign key(mid) references tblEmployee(eid)

insert into tblEmployee values(101,'Ramu',null)
insert into tblEmployee values(102,'Somu',null)
insert into tblEmployee values(103,'Bimu',101)
insert into tblEmployee values(104,'Komu',102)
insert into tblEmployee values(105,'Lomu',101)

select eid,ename,mid from tblEmployee

select emp.eid employee_id,emp.ename employee_name ,
mgr.eid manager_id,mgr.ename manager_name from
tblEmployee emp join tblEmployee mgr
on emp.mid = mgr.eid

--simple
create view vwEmployee
as
Select * from tblEmployee

select * from vwEmployee

alter view vwEmployee
as
select * from employee

alter view vwEmployee
as
Select * from tblEmployee
select * from vwEmployee
insert into vwEmployee  values(106,'Jimu',102)

select * from tblEmployee

insert into tblEmployee values(107,'Mimu',102)

-- create a table accounts with accno, name, balance, reff id where reffId is teh account number of the person
-- who reff the customer to the bank and insert data into the table

create table tblAccount
(accno int primary key,
name varchar(20),
balance float,
reffid int,
foreign key(reffid) references tblAccount(accno))

insert into tblAccount values(1000,'Ramu',12344,null)
insert into tblAccount values(1001,'Somu',50000,1000)
insert into tblAccount values(1002,'Bimu',98765,1001)
insert into tblAccount values(1003,'Komu',36784,1000)

select * from tblAccount
select (36784+50000)/2
--print the name and average balance of all the people that a customer has reff
select t1.name,avg(t2.balance) from tblAccount t1 join tblAccount t2
on t1.accno=t2.reffid group by t1.name

--6) select author name and the average quantity sold for every author
select CONCAT(au_fname, ' ', au_lname) Author_name, AVG(qty) Avg_Qty_Sold
from authors a join titleauthor ta
on a.au_id = ta.au_id
join sales s
on s.title_id = ta.title_id
group by CONCAT(au_fname, ' ', au_lname)

--7) print the store name and address of all the sales for a given title
select stor_name,stor_address from stores where stor_id in
(select stor_id from sales where title_id=
(select title_id from titles where title = 'Cooking with Computers: Surreptitious Balance Sheets'))

select * from titles

--8) what is the max quantity sold for every publisher?
select pub_name,max(qty)Quantity from sales s
 join titles t on s.title_id=t.title_id
 join publishers p on p.pub_id=t.pub_id
 group by pub_name

--9) print the employee names for a given publisher
   
select CONCAT(fname, ' ', lname) Emp_name
from employee e join publishers p
on e.pub_id = p.pub_id
where pub_name = 'New Moon Books'
--or
select pub_id, fname from employee where pub_id in(select pub_id from publishers)

--10) Explore the function soundex. show an example query
select soundex ('mam') as CODE_1,SOUNDEX('maam') as CODE_2
--or
    select SOUNDEX('See')
 select SOUNDEX('Sea')
 

--11) print the total sales(price*quantity) for every city in the author table
select city,sum(price*qty) total from sales s join titles t
on s.title_id = s.title_id
join titleauthor ta
on t.title_id = ta.title_id
join authors a
on a.au_id = ta.au_id
group by city

--12) sort by date and print the store name and the latest purchase done by every store
   
select stor_name, max(ord_date) from sales s join stores st
on st.stor_id = s.stor_id
group by stor_name
order by max(ord_date) desc

create view vwLatestSale
as
select stor_name, max(ord_date) last_Odr_date from sales s join stores st
on st.stor_id = s.stor_id
group by stor_name

drop view vwLatestSale


select * from vwLatestSale where stor_name like 'B%' order by 2


