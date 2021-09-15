create database dbClinic
use dbClinic

create table tblDoctor
(id int identity(101,1) primary key,
name varchar(20) not null,
speciality varchar(20) not null,
exp int default 1)

alter table tblDoctor
add startTime time,endTime time

sp_help tblDoctor

create table tblPatient
(id char(4) primary key,
name varchar(20) not null,
date_of_birth date,
registerd_Date date default getDate())

alter table tblPatient
add phone varchar(15) 

create table tblAppoitment
(app_num int identity primary key,
doc_id int references tblDoctor(id),
pat_id char(4) references tblPatient(id),
app_date date,
app_time time,
Note_for_doc varchar(1000))

select * from tblDoctor
select * from tblPatient
select * from tblAppoitment

insert into tblAppoitment(doc_id,pat_id,app_date,app_time,Note_for_doc)
values(101,'D001',GETDATE(),'10:00','Fever and Cold')

use pubs

--5)select * from authors a where address in 
(select address from authors where address=a.address and au_id !=a.au_id)

--6) List the store names that have more than 4 orders

select stor_name from stores where stor_id in 
(select stor_id from sales group by stor_id having COUNT(ord_num)>4)

--7) List the store that has sold all the book atleast once
select stor_id from sales group by stor_id having count(distinct(title_id))=
(select count(title_id) from titles)

--8) given a store name list the books names that they have sold
select title from titles where title_id in
(select distinct title_id from sales where stor_id =
(select stor_id from stores where stor_name = 'Bookbeat'))

select * from stores

--9) Give the employee details for the all the orders with quantity > 3
select * from employee where pub_id in 
(select distinct pub_id from titles where title_id in 
(select distinct title_id from sales where qty >3))
--10) print the author's full name in capitals for all the books sold
select upper(concat(au_fname,' ',au_lname)) from authors where au_id in 
(select distinct au_id from titleauthor where title_id in
(select distinct title_id from sales))
--11) Print the list of all the author's name's first 3 chars
select substring(au_fname,1,3) from authors 
--12) print the sum, average and min of the advance amount for every publisher rounded to 2 decimal points
select round(sum(advance),2) sum_of_advance,
round(AVG(advance),2)average_advance,
round(min(advance),2) minimum_advance 
from titles group by pub_id




