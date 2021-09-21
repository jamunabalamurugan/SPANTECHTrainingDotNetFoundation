select * from shippers

--Joining tables which are not related
select customerid,employeeid,c.city,e.city,c.region,e.region 
from customers c join employees e
on e.country=c.country

--Find the details Employee of the Highest experience
select Lastname from employees
where hiredate=(
select min(hiredate) from employees)

--Find the customers who has maximum orders

select count(customerid),customerid
from orders
group by customerid

--Find the customers who has maximum orders
select * from customers 
where customerid in(
select top 1 customerid from orders 
group by customerid 
order by count(orderid) desc)

select CustomerId from Ordersgroup by CustomerIDhaving (count(orderid) =
(select max(countId) from 
(select count(o2.customerid) as [countId] 
from Orders o2 group by o2.CustomerID) t))


select CustomerId from Ordersgroup by CustomerIDhaving (count(orderid) =
(select max(countId) from 
(select count(customerid) as [countId] 
from Orders group by CustomerID) mycust))

select * from employees
select * from customers
insert customers
select substring(firstname,1,3)+substring(lastname,1,2),
lastname,firstname,title,address,city,region,postalcode,country,
homephone,null from employees

select * from products

update products
set unitprice=unitprice+2
where supplierid in(select supplierid from suppliers
where country='USA')

alter table products add totalsales int default 0

alter table products add constraint dfTotalsales 
default 0 for totalsales

select * from products

update products
set totalsales=0
where totalsales is null

--Correlated Subqueries
--This example updates total sales for all orders of each product
update products
set totalsales=(
select sum(quantity) from [order details] od
where products.productid=od.ProductID)

--Exists example
select * from products
where exists(select * from suppliers
where country='USA')

--Delete example using Joins
delete from [order details]
from orders o join [order details] od
on o.orderid=od.OrderID
where o.orderdate='4/15/1998'

--Delete with Subquery Example
delete from [order details]
where orderid in(
select orderid from orders
where orderdate='4/14/1998')

--View
--A view provides ability to store a predefined query
--Subset of rows or columns of a base table
--view is a virtual table 
--Assignment is like a table
--Show only the question no 5 by folding the other pages

--Why we need a View
--Focus the Data for Users-Important or appropriate data
--Limit access to sensitive data
--Hide complex database design
--Simplify complex queries,including distributed queries to 
--hetrogeneous data
--Simplify Management of User Permissions

--DCL Data Control Language
--Used to decide who can control or modify data
--eg of Grant
grant connect on northwind to public
grant select on products to public
revoke select on products to public
--deny 
grant select on myproducts to public
grant update on myproducts to public
grant delete on myproducts to public
grant insert on myproducts to public

alter view MyProducts as
select productid,productname,unitprice from products where productid <10

select * from products
update myproducts set unitprice=unitprice+5 where productid=10

update myproducts set unitinstock=unitinstock+5 where productid=1


select * from products


update products set unitprice=21 where productid=1
update myproducts set unitprice=25 where productid=1

insert myproducts values('Sevenup',45)

delete myproducts where productid=82

delete products where productid=82

sp_help myproducts
sp_help products

alter view myproducts as
select productid,productname,unitprice,totalsales/12 'Monthly Sales' from products 
where Discontinued=0


update products set discontinued=1 where productid=82

/*create view view_name as select from colmn1....column n */
--view without __________
--created
use dbHumanResource
go
alter view vEmployeepersonaldetails
as
select id, Name, age,gender from tblEmployeeInfo

--display
select * from vEmployeepersonaldetails
select * from tblemployeeinfo
select Name,Age from vEmployeepersonaldetails

--alter
alter view vEmployeepersonaldetails
as
select id, Name, age,gender,salary from tblEmployeeInfo

--Drop 
drop view vEmployeepersonaldetails
go
--create a view with condition
alter view vEmployeeAge
as
select id,Name,location,age from tblEmployeeInfo
where age>=25
with check option

update vEmployeeAge set age=21 where id=1
update tblEmployeeInfo set salary=salary+1000
select * from vAge

alter view vMaxsalary
as
select  d.name,max(e.Salary) as 'Maximum Salary'  
from tblEmployeeInfo e join tblDepartment d
on d.Depid=e.Depid
group by d.name


select * from vMaxsalary
insert vMaxsalary values('IT',55000)
----------------------------------------
--Insert record  in below vEmployeepersonaldetails 
create view vEmployeepersonaldetails
as
select id, Name, age,gender from tblEmployeeInfo

insert into vEmployeepersonaldetails
(id,Name,age,Gender) values( 1010,'Jamuna',37,'M')
select * from tblEmployeeInfo
select * from vEmployeepersonaldetails
select * from vAge
select *from  tblEmployeeInfo

insert into vEmployeeAge values(1010,'Ram',17)

-------------------------------------
drop table test1
--With out check option
create table Test1 (id int primary key,Name nvarchar(20),
Age int,gender char not null )

alter table test1
add gender char 

alter table test1
add constraint chkgender check (gender in('F','M'))



alter view vAgeTest
as
select * from Test1
where age>=20
with check option

insert into vAgeTest(id,Name,Age) values(101,'Shreya',20)

select * from Test1
select * from vAgeTest

--With check option

alter view vAgeTest
as
select * from Test1
where age>=20 with check option

insert into vAgeTest(id,Name,Age) values(103,'charu',20)
insert into test1 values(103,'Charu',20,'F')
insert into test1 values(102,'Kavin',20,'M')
insert into test1 values(101,'Kanav',20,'M')
--drop view viewname
-------------
select * from v_Age

CASE <Case_Expression>
     WHEN Value_1 THEN Statement_1
     WHEN Value_2 THEN Statement_2
     .
     .
     WHEN Value_N THEN Statement_N
     [ELSE Statement_Else]   
END AS [ALIAS_NAME]*/

-------------

SELECT Name, CONVERT(char(10),HireDate,2) 
FROM tblEmployeeInfo

create table tblPerformance (id int,rating int)

insert tblperformance values(1001,5)
insert tblperformance values(1002,4.5)
insert tblperformance values(1003,3)
insert tblperformance values(1004,2)
insert tblperformance values(1005,1)
select * from tblperformance
create view emprating as
select id,Rating,Remarks=
case 
when Rating =5 then 'Excellent'
when Rating<=4.9 and Rating >=4 then 'Very Good'
else 'poor'
End 
from tblPerformance

------------------

select * from emprating


alter table tblEmployeeinfo
alter column Gender nvarchar(20)
select * from tblEmployeeInfo
update tblEmployeeInfo set gender='M' where id=1001
update tblEmployeeInfo set gender='F' where id=1010
UPDATE tblEmployeeInfo
SET Gender = CASE Gender
 WHEN 'F' THEN 'Female' 
 when 'M' then 'Male'
 else gender
 END
 -------------------
 Select *,
 CASE
WHEN Salary >=80000 AND Salary <=100000 THEN 'Director Level 1'
WHEN Salary >=50000 AND Salary <80000 THEN 'Senior Consultant'
Else 'Programmer'
END AS Designation from tblEmployeeInfo



------------------
Select 
 CASE
WHEN Salary >=80000 AND Salary <=100000 THEN 'Director Level 1'
WHEN Salary >=50000 AND Salary <80000 THEN 'Senior Consultant'
Else 'Programmer'
END AS Designation,
Min(salary) as MinimumSalary,
Max(Salary) as MaximumSalary
from tblEmployeeInfo
Group By
CASE
WHEN Salary >=80000 AND Salary <=100000 THEN 'Director Level 1'
WHEN Salary >=50000 AND Salary <80000 THEN 'Senior Consultant'
Else 'Programmer'
END




--We are going to learn T-SQL 
--Implementation of entry level ANSI SQL ISO standard

--Transact SQL Programming Elements
--local variables,operators,functions,control flow,comments

begin
declare @myname varchar(30)
set @myname='Jamuna Balamurugan'
print 'Hello '+ @myname
end

begin
declare @myname varchar(30)
set @myname='Kanav'
select * from tblstudent where name=@myname
end

begin
select user_name(),DB_NAME()
declare @myname varchar(30)
set @myname=user_name()
if @myname<>'dbo'
    print 'must be system admin or valid user'
else
	select * from tblstudent
end

--While Expression


declare @v1 int
set @v1=0
while @v1<10
begin
	set @v1=(@v1+1)
	print @v1
end




--CASE Expression

--Eg1
select productid,unitsinstock,unitsonorder,'Product Status'=
case when(discontinued=1) then 'This product is in Use'
else '****This product is discontinued***' end
from products

--Eg2
select productid,'Status'=
case when(unitsinstock<unitsonorder)
		then 'Negative Inventory- Pls Order Now!'
	when((unitsinstock-unitsonorder)<reorderlevel)
		then 'Reorder level reached-Place the order'
	when(discontinued=1)
		then '*****This product is Discontinued*****'
	else
		'In Stock....No Worries'
	end,
	'Remarks'='Print your Analysis using case'
from products

create proc stockstatus
as begin
select productname,UnitsinStock,case
					when UnitsInStock<10 then 'Danger Level'
					when UnitsInStock>30 then 'Over Stock Level'
					else 'Correct Level'
					end as Stock_Status
from products
end

execute stockstatus with recompile

alter table products add totalsales money

alter table products alter column totalsales int

update products set totalsales=(select sum(quantity) from [order details] od
where products.productid=od.ProductID)
alter table products add status varchar(50)

--Update the status of the product based on totalsales

UPDATE products SET status=CASE WHEN totalsales <= 30 THEN 'Slow moving Product'	 WHEN totalsales <= 60 THEN 'Medium moving Product'	 WHEN totalsales <= 100 THEN 'Fast moving Product'	 WHEN totalsales <= 500 THEN 'Fastest moving Product'ELSE 'Star Moving Product'END from Products

select * from products
--Execute command is for building statements dynamically
execute ('set nocount on' + ' select * from products' +
' set nocount off')
 

declare @dbname varchar(30),@tablename varchar(30)
set @dbname='dbaDOExample'
set @tablename='tblStudent'
execute ('use '+ @dbname + ' select * from '+@tablename)

use dbAdoExample
select * from tblStudent

select * from products

--Performance
--Speed of Search and Results which is relevant



--Index
--clustered           and          Non-clustered
-- Index in dictionary             index at back side of book,atlas
--Eg: range 1050 to 2000           Eg:names starts with M
--only one clustered index		more than one column can have non clustered index
--Primary Key clustered Index		Foreign Key Non Clustered Index

/* create index indexname on tablename(Column1,Columnn)*/
--Non-clustered

create index idxEmployeeName 
on tblEmployeeInfo(Name)

drop table test2
create table test2(tid int,tname char(10))
create unique clustered index idxUniqueName
on Test2(tname)

insert test2 values(1,'Kavin')
insert test2 values(1,'Kavin')
insert test2 values(1,'Kavin')

sp_help tbl_EmployeeInfo
--rename index
sp_rename  'tblEmployeeInfo.idxEmployeeName','tblEmployeeInfo.idxName','index'
--creating unique 
create unique index idxEName 
on tblEmployeeInfo(Name)

drop index tblEmployeeInfo.idxEName
-- drop index indexname

update myproducts set unitprice=18 where productid=1







select * from [order details] 
where orderid in(11020,11021)

--Why use SubQueries
--To break down a complex query into a series of logical steps
--To answer a query that relies on the results of another query

--Why use Joins rather than Subqueries
--Sql Server executes joins faster tham subqueries

--enclose subqueries in parantheses
--Use only on Expression or Column in select list
--Use Subquery in place of an Expression
--No Limit to the levels of Subqueries
--Avoid use order by command in sub query
--Cannot use Subqueries on Columns containing Text or Image


--display name,salary of employees whose salary is greater 
--than salary of emp_id 1005
--name,salary of employees

--greater than salary of emp_id 1005
--single row sub query,> ,>=,<,<=,=,!
select name,salary from tblemployeeinfo where salary >   --outerquery
              (select salary from tblEmployeeInfo 
			  where id=1005)

--delete the employee details whose department name is HR		

--display the deptid,average salary of all departments ,whose average salary is > the average of depart 13
--
select depid ,avg(salary) from tblemployeeinfo 
group by depid
having avg(salary)>
   (select avg(salary) from tblEmployeeInfo where Depid=2)
   order by depid desc
  -- Multiple row sub query, IN,ALL,Any,exists
  --display name and salary of employees whoes salary is equal to one of the 
  --salaries of employee in department 14

  select name,salary from tblEmployeeinfo where salary in
    (select salary from tblEmployeeInfo where Depid=14)

--display name and salary of employees whoes salary is equal to one of the 
 --salaries of employee in department 14  and  excluding the employees in department 14
  select name,salary from tblEmployeeinfo where salary in
    (select salary from tblEmployeeInfo where Depid= 14  )
	and Depid<>14--did not in(14)-- 

---Retrive all employees whose salary is higher than atleast one of 
--the salaries of the employees in department 13
select salary from tblEmployeeInfo where depid=13

select id,Salary from tblEmployeeinfo where salary > Any 
(select salary from tblEmployeeInfo where depid=13)

-----Retrive all employees whose salary is higher than salary of all 
--employees in department 13
select id,Salary from tblEmployeeinfo where salary > All
(select salary from tblEmployeeInfo where depid=1)


   select * from tblEmployeeInfo
   select * from tblDepartment




--SubQueries

--Test Day3 SQL

--1.Write a query to print the age of all employees
--2.Write a query to display employees with >25 year experience
--3.Write a query to display all employees getting
--salary below the average salary of their department
--4.Print the names of employees getting salary
--more than Anne
--5.Print the experience of Miller



