--1
select productid,supplierid  into catalogue from products p 
select Suppliers.supplierid,count(Catalogue.SupplierID) as [Count of Supplied Products] from Suppliers join Catalogue on Suppliers.supplierid=Catalogue.SupplierIDgroup by Suppliers.supplieridhaving count(Catalogue.ProductID)=2
--3
select c.SupplierID,count(p.productid) from Products p join catalogue c on p.ProductID=c.ProductID
group by c.SupplierID
having count(p.productid)>2 and count(p.productid)<=4
--4.List out the third costliest product
select * from products where UnitPrice=(
SELECT TOP 1 UnitPrice 
FROM 
    (SELECT TOP 3 unitprice 
     FROM products 
     ORDER BY unitprice DESC) AS Comp 
ORDER BY unitprice ASC)



create table product
(
pid int not null primary key,
pname varchar(20),
cost int,
color varchar(10)
);

--drop table supplier

create table supplier
(
sid1 int not null primary key,
sname varchar(20),
city varchar(10)
);

create table catalogue
(
pid int,
sid1 int,
foreign key(pid) references product(pid),
foreign key(sid1) references supplier(sid1)
);

insert into product
values(1,'samosa',30,'red');
insert into product
values(2,'bricks',50,'dark_red');
insert into product
values(3,'sky',100,'blue');
insert into product
values(4,'laptop',200,'black');




insert into supplier
values(1,'ram','delhi');
insert into supplier
values(2,'shyam','mumbai');
insert into supplier
values(3,'ghanshyam','banglore');

select * from supplier;
select * from product;
select * from catalogue;


insert into catalogue
values(1,1);

insert into catalogue
values(2,1);
insert into catalogue
values(3,1);
insert into catalogue
values(4,1);

insert into catalogue
values(4,2);
insert into catalogue
values(4,2);
insert into catalogue
values(3,2);
insert into catalogue
values(4,2);

------Query1----------
select c.sid1,count(p.pid) from Product p 
join catalogue c on c.pid=p.pid
group by c.sid1 having COUNT(c.pid)=2

----------Query2---------
select c.sid1,max(p.pid) from Product p 
join catalogue c on c.pid=p.pid
group by c.sid1 having count(c.sid1)=max(p.pid)

---------Query3-----------
select c.sid1,count(p.pid) from Product p 
join catalogue c on c.pid=p.pid
group by c.sid1 having count(p.pid)>2 and count(p.pid)<=4

--------Query4------------
select * from product where cost=(
SELECT TOP 1 cost 
FROM 
(SELECT TOP 3 cost FROM product ORDER BY cost DESC) AS Comp ORDER BY cost ASC)



