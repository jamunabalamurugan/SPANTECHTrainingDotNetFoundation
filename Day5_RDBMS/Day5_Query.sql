use pubs

create function fn_first()
returns varchar(20)
as
begin 
  return 'Hello world'
end

select dbo.fn_first()

select * from titles

create function fn_CalculateTax(@amount float)
returns money
as
begin
   return (@amount*12.2/100)
end
select advance,dbo.fn_CalculateTax(advance) tax_amount from titles

create function fn_Table_Example()
returns @MyTable table(f1 int,f2 varchar(10))
as
begin
   insert into @MyTable values(101,'ABC')
   insert into @MyTable values(102,'XYZ')
   return
end

select * from dbo.fn_Table_Example()

create table tblUserdetails
(username varchar(20) primary key,
password varchar(20),
role varchar(20))

create proc proc_Insert_TblUserDetails(@un varchar(20),@pass varchar(20), @rl varchar(20))
as
begin
   Insert into tblUserdetails values(@un,@pass,@rl)
end

proc_Insert_TblUserDetails 'Ramu','1234','Admin'
proc_Insert_TblUserDetails 'Somu','1234','User'
proc_Insert_TblUserDetails 'Bimu','1111','User'

select * from tblUserdetails

alter proc proc_Login_Check(@un varchar(20),@pass varchar(20), @rl varchar(20) out)
as
begin
   declare
   @rol varchar(20)
   set @rol = (select role from tblUserdetails where username = @un and password = @pass)
   if (select count(role) from tblUserdetails where username = @un and password = @pass )<1
      set @rol = 'Error'
end

	begin
		declare
		@checkRole varchar(20)
		exec proc_Login_Check 'Ramu','123', @checkRole out
		print @checkRole
	end

select role from tblUserdetails where username = 'Ramu' and password = '1234'

create table tblsalary
(salid int primary key,
 basi float,
 hra float,
 da float,
 deductions float)

Create proc inserttosalary(@salid int, @basic float, @hra float, @da float, @deduction float)
as
begin
    insert into tblsalary values(@salid,@basic,@hra,@da,@deduction)
end

 

exec inserttosalary 1002,54000,5000,4000,1000
drop table tbl_employee

create table tbl_employee(
eid int primary key identity (1,1),
ename varchar(20),
sa_id int references tblSalary(salid),
leaveCount int)	

alter proc pro_Insert_into_tbl_employee(@en varchar(20),@sa_id int,@leaveCount int)
as 
begin
    insert into tbl_employee values (@en,@sa_id,@leaveCount )
    
end

select * from tbl_employee
pro_Insert_into_tbl_employee 'Ramu',1003,2
pro_Insert_into_tbl_employee 2,3
pro_Insert_into_tbl_employee 3,3

create function fn_GetSalWithEID(@eid int)
returns @SalTab table
(ename varchar(20),
basic float,
hra float,
da float,
ded float,
grossSal float,
netSal float)
as
begin
  declare
   @en varchar(20),
   @bas float,
   @hra float,
   @da float,
   @ded float,
   @gross float,
   @leavecount int,
   @netSa float,
   @salid int
   set @salid = (Select sa_id from tbl_employee where eid = @eid)
   set @leavecount = (Select leaveCount from tbl_employee where eid = @eid)
   set @en = (select ename from tbl_employee where eid = @eid)
   set @bas = (Select basi from tblsalary where salid=@salid)
   set @hra = (Select hra from tblsalary where salid=@salid)
   set @da = (Select da from tblsalary where salid=@salid)
   set @ded = (Select deductions from tblsalary where salid=@salid)
   set @gross = (@bas+@hra+@da-@ded)-((@bas+@hra+@da-@ded)*10/100)
   if @leavecount <=2
      set @netSa = @gross
   else if @leavecount > 2 and @leavecount <= 5
   begin
      declare
	  @perday float
	  set @perday = @gross/30
	  set @netSa = (30-@leavecount)*@perday
   end
   else
      set @netSa = @gross/2
	insert into @SalTab values(@en,@bas,@hra,@da,@ded,@gross,@netSa)
  return
end

update tbl_employee set leavecount = 6

select * from dbo.fn_GetSalWithEID(1)

create table tbl_Tri_Ex
(f1 varchar(20))

create trigger trg_Insert_First
on tbl_Tri_Ex
for insert
as
begin 
   print 'Hello'
end

drop trigger trg_Insert_First

insert into tbl_Tri_Ex values('Jimu')

select * from tbl_Tri_Ex

create table tbl_Tri_Ex_Target
(f1 varchar(20))

create trigger trg_Insert_First
on tbl_Tri_Ex
for insert
as
begin 
   insert into tbl_Tri_Ex_Target select f1 from inserted
end

select * from tbl_Tri_Ex_Target

-- create a trigger that will print the total sal for employee when a new employee is inserted
create trigger trg_Cal_Sal
on tbl_employee
for insert
as
begin
   declare 
   @sal float
   set @sal = (select (basi+hra+da-deductions) from tblsalary where salid=(select sa_id from inserted))
   print @sal
end

pro_Insert_into_tbl_employee 'Somu',1002,2

select * from tblsalary
select * from tbl_employee

delete from tblsalary where salid = 1003

create trigger trg_delete_Sal
on tblsalary
instead of delete
as
begin
    update tbl_employee set sa_id = null where sa_id = (select salid from deleted)
	delete from tblsalary where salid = (select salid from deleted)
end

--create a function that will take the au_id and list every order with the price and quantity(table function)
create function fn_GetAllTitle_using_author_id(@auid varchar(20))
returns  @OrderTable table
(titlename varchar(1000),
price float,
quantity float)
as
begin
   insert into @orderTable select title,price,qty from sales s join titles t on s.title_id = t.title_id
where t.title_id in (select title_id from titleauthor where au_id = @auid)
   return
end

select * from authors

select * from dbo.fn_GetAllTitle_using_author_id('213-46-8915')

create database dbShowTime
use dbShowTime
create table tblScreen
(sid int identity(1,1) primary key,
capacity int default 20,
status varchar(10) check(status in('active','inactive')))

create table tblMovie
(id char(4) primary key,
name varchar(100),
duration float,
details varchar(2000))

create table tblShow
(showid int primary key,
mid char(4) references tblMovie(id),
sid int references tblScreen(sid),
showtime time)

create table tblCustomer
(id int identity(101,1) primary key,
name varchar(20),
age int)

create table tblBooking
(bookingid varchar(10) primary key,
cid int references tblCustomer(id),
showid int references tblShow(showid),
showdate date,
ticketCount int)