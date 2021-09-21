  create table departments(department_id integer primary key,
		   depname varchar(40) not null,
		   mgrid char(10),
		   location_id integer)

CREATE TABLE employees
    ( employee_id    integer constraint myemployees_pk PRIMARY KEY
    , first_name     VARCHAR(20)
    , last_name      VARCHAR(25) NOT NULL
    , email          VARCHAR(25) NOT NULL UNIQUE
    , phone_number   VARCHAR(20)
    , hire_date      DATETIME NOT NULL check(hire_date<getdate())
    , job_id         VARCHAR(10) NOT NULL
    , salary         integer CHECK (salary>0)
    , commission_pct integer
    , manager_id     integer REFERENCES	 employees (employee_id)
    , department_id  integer REFERENCES  departments (department_id));

	sp_help myemployees_pk

	alter table employees_c drop constraint myemployees_pk
	insert into employees values(1003,'Akhil','V','Akilv@gmail.com','9444077777','01/23/2018','IT',40000,null,null,2)
		   select * from departments
		   drop table employees
		   drop table departments
		 
		   select * from departments
		   insert into departments values(2,'QUALITY','E001',200)

		   alter table departments disable trigger all

		   delete departments where department_id=2




declare @outvar integer
exec updatesal 10,30,@outvar output

print 'The total no of employees updated is : ' + convert(varchar,@outvar)

sp_helptext updatesal

create function displayemp() returns integer
as
begin
select * from emp

end
 
CREATE FUNCTION check_sal RETURN integer as
@v_dept_id integer
 BEGIN
@v_sal integer
 SELECT @v_sal=avg(sal) from emp where deptno=@v_dept_id
  IF @v_sal > 0
  RETURN @v_sal
 ELSE
  RETURN 0 

CREATE FUNCTION SalAmount (@dep_id integer ) 
  RETURNS MONEY 
  AS 
  BEGIN 
      DECLARE @totamt MONEY 
        SELECT @totamt = SUM(sal) 
          FROM emp 
        WHERE deptno = @dep_id 
      RETURN(@totamt) 
  END 
declare @amt money
exec @amt=SalAmount 50 
print @amt

select max(sal) from emp where deptno=10


begin transaction tr1
sp_helpindex employees
update emp set sal=sal+(sal*10/100) where deptno=10
if(select max(sal) from emp where deptno=10)>7500
begin
rollback transaction
print 'Updation failed'
end
else
begin
commit transaction
print 'Completed Updation Succcesfully'
end
end



alter trigger demotrigger
on departments
for insert
as
declare @rcnt int
set @rcnt=(select count(*) from departments d join inserted i on d.department_id=i.department_id)
if(@rcnt>1)
begin
raiserror('Transaction cannot be processed',16,1)
rollback transaction
end

if(select count(*) from departments d,inserted i where d.depname=i.depname)=1
begin
	print 'Insert trigger of dept table is called'
	commit tran
end
else
begin
	print 'This dept name already exists'
	rollback tran
end
select * from departments
--insert into dept values(101,'Finance','Chennai',null,12324)
insert into departments values(101,'Finance',null,1)
insert into departments values(102,'Finance',null,1)
insert into departments values(103,'Finance',null,1)--Departments will have 101,102,103 
													--inserted will 103



insert into departments values(103,'IT',null,1)
insert into departments values(104,'HR',null,1)

use library
go
create trigger trg_loaninsert
on tbl_loan
for insert
as
	update tbl_loancopy 
	set on_loan='Y'
	from tbl_loancopy c inner join inserted i
	on c.isbn=i.isbn and c.copy_no=i.copy_no


create trigger trg_loandelete
on tbl_loan for delete
as
update tbl_loancopy  set on_loan='N'
from tbl_loancopy c join deleted d
on c.isbn=d.isbn and c.copy_no=d.copy_no


--Same trigger for both insert and delete

create trigger trg_loaninsert
on tbl_loan--orders
for insert
as
	update tbl_loancopy --products
	set on_loan='Y'--qtyonhand should be reduced
	from tbl_loancopy c inner join inserted i
	on c.isbn=i.isbn and c.copy_no=i.copy_no


create trigger trg_loandelete
on tbl_loan for delete
as
update tbl_loancopy  set on_loan='N'
from tbl_loancopy c join deleted d
on c.isbn=d.isbn and c.copy_no=d.copy_no

use northwind
go


use northwind
go

alter trigger trg_productsdelete
on products for delete
as
begin
	declare @prodid int
	set @prodid=(select productid from deleted)
	
		print 'Cannot delete from products...only the discontinued status can be changed'
		rollback transaction
		print 'Updating products table with discontinued status = 1'
		begin transaction tranupdateproducts
			update products
			set discontinued=1 from products p 
			where p.ProductID=@prodid
		commit transaction tranupdateproducts
end

alter trigger updateproducts
on products
for update
as
begin
print 'Updating the discontinued status in products table'
select * from inserted
select * from deleted
end

insert into products(productname,unitprice) values('Pepsi',40)

delete products where productname='Pepsi'

select * from products where productname='Pepsi'

alter table products disable trigger trg_productsdelete


select * from employees
alter trigger trgempdel on employees for delete
as
begin
if(select count(*) from deleted where commission_pct is null)=0
begin
print 'Cannot delete....Its too early to quit'
rollback
end
else
print 'Best of Luck in your new organization'
end
insert into employees values('1005','Kanav','Kumar','kanav@gmail.com',null,'01/01/2018','IT',10000,10,null,1)
delete employees where employee_id='1005'


create trigger 






 
 sp_helpindex employees

 -- Trigger can only do this automatically
 --Update the qytonhand in products table wheneever a order is placed

 alter trigger trgorderinsert
 on [order details]
 for insert
 as
 begin
 declare @qty int
 set @qty=(select quantity from inserted)
	if @qty<(select unitsonorder from products p join inserted i
	on i.ProductID=p.ProductID)
	begin
		print 'Order has been accepted'
		update products set unitsonorder=unitsonorder-@qty
		from products p join inserted i
		on p.productid=i.productid

		commit transaction
	end
 else
	 begin
		print 'Sorry...We do not have this in stock....'
 --raiserror('Invalid transaction',1000,10,2)
		rollback transaction
	end
 end

 insert [order details] values(10252,3,18,60,0)
 select * from [order details] where productid=3




		   
		   
		   
		   
		   
		   
		   
		   
		   
		   
		   
		   
		   
		   
		   
		   
		   
		   
		   select * from emp
		   select * from emp where (sal,deptno) in 
		   (select sal,deptno from emp where sal between 1000 and 2000
		    )
			select * from emp

			select empno,sal,deptno from emp e1
			where sal>(select avg(sal) from emp e2 
			where e2.deptno=e1.deptno)


create view empsal30
as
select empno,ename,sal,deptno from emp where deptno=30

select * from empsal30
select * from emp
select * from empsal30
delete from emp where deptno=30
update empsal30 set sal=sal+(sal*20/100)

sp_help empsal30
sp_helptext empsal30
sp_help syscomments
select * from sysobjects
select * from syscolumns
select * from sysdepends
select ctext from syscomments

alter view empsal30
as
select * from emp where deptno=30

select * from emp
select * from empsal30

insert into empsal30 values('7001','KANAV','KUMAR',null,7902,getdate(),1000,50)

update empsal30
set deptno=30

select * from dept
sp_helptext empdept
alter view empdept
with encryption
as
select empno,ename,job,e.deptno,dname,loc from emp e,dept d where e.deptno=d.deptno

sp_help

select * from emp_personal


drop index PK__employee__AF4CE865755FE7D1 on employee
sp_help employees
alter view emp_personal as select * from employees where first_name like 'A%'
create index lastname_indx on employees(last_name)
drop index lastname_indx on employees