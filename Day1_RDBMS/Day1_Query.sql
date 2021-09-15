create database dbShop

use dbShop

create table tblCustomer
(id char(4),
name varchar(20),
phone varchar(15),
email varchar(50)
)
--This is a comment--
sp_help tblCustomer

alter table tblCustomer
alter column id char(4) not null

alter table tblCustomer
add constraint pk_CID primary key(id)

drop table tblCustomer

create table tblCustomer
(id char(4) primary key,
name varchar(20) not null,
phone varchar(15) not null,
email varchar(50) not null
)

create table tblProduct
(id int identity(100,1) primary key,
name varchar(50) not null,
price float not null check(price>=0),
quantity int not null check(quantity>=0),
description varchar(1000)
)

sp_help tblProduct

create table tblBill
(BillNo int identity(1,1) primary key,
Bill_Date date not null,
Customer_Id char(4) references tblCustomer(id),
total_amount float check(total_amount>0)
)

sp_help tblBill

create table tblSupplier
(id char(4) primary key,
contact_name varchar(20) not null,
phone varchar(15))

create table tblSuppliersProduct
(ship_no int identity(1000,1) primary key,
product_id int references tblProduct(id),
supp_id char(4) references tblSupplier(id),
Supplier_date date,
quantity int
)

sp_help tblSuppliersProduct

alter table tblSupplier
add email varchar(50)

alter table tblSupplier
alter column email varchar(100)

sp_help tblSupplier

alter table tblSupplier
drop column email

--These queries not possible--
drop table tblSupplier
alter table tblSupplier
drop column id
--Ref integrity--

Create table tblEmployee
(id char(4) constraint pk_eid primary key,
name varchar(20) not null unique,
phone varchar(15) not null unique,
area varchar(20))

create table tblSkill
(name varchar(20) primary key,
info varchar(20))

create table tblEmployeeSkill
(eid char(4) references tblEmployee(id),
skill_name varchar(20) references tblSkill(name),
skill_level int default 3,
primary key(eid,skill_name))

sp_help tblEmployeeSkill

select * from tblSkill

insert into tblSkill values('C','PLT')
insert into tblSkill values('C','PLT')--Wrong  Violation of PRIMARY KEY constraint--
insert into tblSkill values(null,'PLT')--Wrong annot insert the value NULL into column 'name'--
insert into tblSkill values('C++','PLT','Hello')--Wrong Column name or number of supplied values does not match table definition.--
insert into tblSkill values('C++12345678901234567890','PLT')--Wrong String or binary data would be truncated in table--
insert into tblSkill(name,info) values('C++','OOPS')
insert into tblSkill(info,name) values('Web','java')
insert into tblSkill(name) values('other')

insert into tblEmployee values('E001','Ramu','1234567890','ABC')
insert into tblEmployee values('E002','Ramu','9876543210','ABC')--Wrong iolation of UNIQUE KEY constraint '--
insert into tblEmployee values('E003','Bimu','9876543210','ABC')

select * from tblEmployee


insert into tblEmployeeSkill values('E001','C',7)
insert into tblEmployeeSkill values('E001','C++',7)
insert into tblEmployeeSkill values('E001','C++',7)--Wrong Violation of PRIMARY KEY constraint'--
insert into tblEmployeeSkill values('E003','C++',7)
--Error coz E002 is not present in parent--
insert into tblEmployeeSkill values('E002','Java',7)--Wrong The INSERT statement conflicted with the FOREIGN KEY constraint--
insert into tblEmployeeSkill values('E003','Java',default)
insert into tblEmployeeSkill(eid,skill_name) values('E001','Java')


select * from tblEmployeeSkill

--Update a single row--
update tblEmployeeSkill set skill_level = skill_level+1 where eid= 'E001' and skill_name='C'
--Updates all rows--
update tblEmployeeSkill set skill_level = skill_level+1
--Other--
update tblEmployeeSkill set skill_level = 7 where eid= 'E001' and skill_name='C'
update tblEmployee set phone = '7777777777' where id='E003'

update tblEmployee set phone = '7777700000', area='BCA' where id='E003'




delete from tblEmployee--Wrong he DELETE statement conflicted with the REFERENCE constraint--
delete from tblEmployeeSkill
delete from tblEmployee--Now this will work--
--Delete with selection--
delete from tblEmployeeSkill where eid='E001'

--truncate--
--Cannot select with where--
---Parent tables cannot be truncated--
truncate table tblskill--Cannot truncate table 'tblskill' because it is being referenced by a FOREIGN KEY constraint.
--

--create table tblProduct
--(id int identity(100,1) primary key,
--name varchar(50) not null,
--price float not null check(price>=0),
--quantity int not null check(quantity>=0),
--description varchar(1000)
--)
insert into tblProduct(name,price,quantity,description) 
values('Doll',280.5,10,'To play with')

insert into tblProduct(name,price,quantity,description) 
values('Pen',50,5,'To Write')


insert into tblProduct(name,price,quantity,description) 
values('Pencil',-2,5,'To Write')--Wrong The INSERT statement conflicted with the CHECK constraint

insert into tblProduct values(103,'Pencil',2,5,'To Write')--Wrong An explicit value for the identity column in table 'tblProduct' can only be specified whe

select * from tblProduct
