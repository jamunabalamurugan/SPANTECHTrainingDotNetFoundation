select * from authors order by state,city

select * from authors a where address  in
(select address from authors where address = a.address and au_id != a.au_id)
--print the store name and address of all the sales for a given title

select * from titles
select stor_name,stor_address from stores where stor_id in
(select stor_id from sales where title_id in
(select title_id from titles where title = 'The Busy Executive''s Database Guide'))

select stor_name ,stor_address from stores st
join sales s on s.stor_id=st.stor_id
join titles ta on ta.title_id=s.title_id
where title='Cooking with Computers: Surreptitious Balance Sheets'

--print the total sales(price*quantity) for every city in the author table
select city, sum(price*qty) sum_of_price from authors a join titleauthor ta
on a.au_id = ta.au_id 
join titles t on t.title_id = ta.title_id
join sales s on t.title_id = s.title_id
group by city

-------------------------------------------------------------

begin
  declare
  @username varchar(20)
  set @username = 'Ramu'
  select substring(@username,1,2) username
  print 'welcome'
end

begin
   declare
   @age int
   set @age = 21*10+10
   print @age
end

begin
   print 'hello'
   begin
	declare
	@num1 int
	set @num1 = 100
	print @num1
   end 
   print @num1
end

begin
   print 'hello'
   begin
	declare
	@num1 int
	set @num1 = 10
	if(@num1 =10)
		begin
			print 'Good'
			print @num1
		end
	else
	    print 'Okay'
   end 
end

begin
  declare
  @num1 int,
  @num2 int
  set @num1 =10
  set @num2 = (select avg(price) from titles)
  if @num1 > @num2
    print 'Low average'
  else
    print 'Good average'
end

begin
   declare 
   @num1 int
   set @num1 = 10
   while @num1>0
   begin
	  print @num1
	  set @num1 = @num1 -1
   end
end

create table tblUserExceptions
(id int identity primary key,
user_msg varchar(20),
error_message varchar(1000),
error_Line int,
error_Date date)

begin
   declare 
   @num1 int,
   @num2 int,
   @result float
   set @num1 = 10
   set @num2 = 8
   while @num1>0
   begin
      begin try
		  set @result = @num1/@num2
		  print concat(@result,' ',@num2,' ',@num1)
	  end try
	  begin catch
			insert into tblUserExceptions(user_msg,error_message,error_Line,error_Date)
			values ('Invalid Division',Error_Message(),Error_Line(),GetDate())
	  end catch
	  set @num1 = @num1 -1
	  set @num2 = @num2 -2
   end
end

select * from publishers

-- get the total advance for all the titles by a given publisher,calculate and print the tax amount(total*12.2/100)
begin
  declare
  @pub_name varchar(100),
  @tot_amt float,
  @tax float
  set @pub_name = 'Algodata Infosystems'
  set @tot_amt = (select sum(advance) from titles where pub_id =(select pub_id from publishers where pub_name=@pub_name))
  set @tax = @tot_amt*12.2/100
  print concat('The tax amount is ',@tax)
end

select * from tblUserExceptions

create procedure proc_first
as
begin 
  print 'Hello world!!!'
end

exec proc_first

alter proc proc_first
as
begin 
  print 'Hello world!!! changed'
end

drop procedure proc_first

create proc proc_second(@num1 int,@num2 int)
as
begin
   declare
   @sum int
   set @sum = @num1+@num2
   print @sum
end

proc_second  10,20

-- create a proc which take 2 numbers and prints the greatest
create proc proc_greatest_of_two(@num1 int,@num2 int)
as
begin
   if @num1 = @num2
      print 'They are equal'
   else if @num1>@num2
      print 'Num1 is greater'
   else
	  print 'Num2 is greater'
end

proc_greatest_of_two 10,10
proc_greatest_of_two 10,20
proc_greatest_of_two 20,10


create proc proc_Calculate_Tax(@pub_name varchar(100))
as
begin
  declare
  @tot_amt float,
  @tax float
  set @tot_amt = (select sum(advance) from titles where pub_id =(select pub_id from publishers where pub_name=@pub_name))
  set @tax = @tot_amt*12.2/100
  print concat('The tax amount is ',@tax)
end

proc_Calculate_Tax 'Algodata Infosystems'

drop procedure proc_Return_Tax

create proc proc_Return_Tax(@pub_name varchar(100),@tax float out)
as
begin
  declare
  @tot_amt float
  set @tot_amt = (select sum(advance) from titles where pub_id =(select pub_id from publishers where pub_name=@pub_name))
  set @tax = @tot_amt*12.2/100
end

declare @getTax float
exec proc_Return_Tax 'Algodata Infosystems' ,@getTax out
print concat('The tax amount is ',@getTax)


create proc proc_Get_Title_Name(@Tid varchar(1000) out)
as
begin
  set @Tid = (select title from titles where title_id=@Tid)
end


select * from titles
declare @title varchar(1000)
set @title = 'BU2075'
exec proc_Get_Title_Name @title out
print @title

create proc proc_Print_All_Title_details
as
  select * from titles

  proc_Print_All_Title_details

--  create a sp that will print the bill for a given order number in the following format

--Order number :xxxxx
--Order Date :xx-xxxxxx-xxxx(day-month-year)
--------------------------------
--Title name : xxxxxxxxx
--Price: xxxxx
--Quantity : xxx
--Amount Payable : xxxx
---------------------------------
select * from sales
create proc proc_Generate_Bill(@onum varchar(10))
as
begin
  declare
  @title_name varchar(100),
  @title_price float,
  @order_Quantity int,
  @total float,
  @Order_date date
  set @title_name = (select title from titles where title_id = (select title_id from sales where ord_num = @onum))
  set @title_price = (select price from titles where title_id = (select title_id from sales where ord_num = @onum))
  set @order_Quantity = (select qty from sales where ord_num = @onum)
  set @Order_date = (select ord_date from sales where ord_num = @onum)
  set @total = @title_price * @order_Quantity
  print concat('Order number : ',@onum)
  print concat('Order Date : ', @Order_date)
  print '-------------------------------------------------'
  print concat('Title Name : ',@title_name)
  print concat('Price : ',@title_price)
  print concat('Quantity : ',@order_Quantity)
  print concat('Amount Payable : ',@total)
  print '-------------------------------------------------'
end
--6871

exec proc_Generate_Bill '6871'

create proc b(@bno varchar(100))
as
begin
    declare 
    @title_name varchar(100),
    @title_price float,
    @order_quantity int,
    @total float,
    @order_date date
    set @title_name =(select title from titles where title_id = (select title_id from sales where ord_num=@bno))
    set @title_price =(select price from titles where title_id = (select title_id from sales where ord_num=@bno))
    set @order_quantity =(select qty from sales where ord_num=@bno)
    set @order_date =(select ord_date from sales where ord_num=@bno)
    set @total = @title_price * @order_quantity

 

    print concat('Bill number: ',@bno)
    print concat('Bill date: ',@order_date)
    print concat('Title: ',@title_name)
    print concat('Price: ',@title_price)
    print concat('Quantity: ',@order_quantity)
    print concat('Amount payable: ',@total)
end

exec b '6871'

create database dbTrans
use dbTrans

create table tblAccount
(acc_no int primary key,
balance float)

create table tblTransaction
(from_Acc int,
to_acc int,
amount float,
remarks varchar(1000))

insert into tblAccount values(1,10000)
insert into tblAccount values(2,1000)
insert into tblAccount values(3,5000)
insert into tblAccount values(4,2000)

select * from tblAccount
begin transaction
   insert into tblAccount values(5,6000)
commit
rollback tran

begin tran
   insert into tblTransaction values(1,2,1000,'credit')
   update tblAccount set balance = balance + 1000 where acc_no = 2
   update tblAccount set balance = balance -1000 where acc_no = 1
   if(select balance from tblAccount where acc_no = 1)<1000
      rollback tran
	else
	begin
	    commit
	end

begin tran
   insert into tblTransaction values(2,1,1000,'credit')
   update tblAccount set balance = balance + 1000 where acc_no = 1
   update tblAccount set balance = balance -1000 where acc_no = 2
   if(select balance from tblAccount where acc_no = 2)<1000
      rollback tran
	else
	begin
	    commit
	end

select * from tblTransaction

drop proc proc_Do_Transaction

create proc proc_Do_Transaction(@facc int,@tacc int,@amt float)
as
begin
	begin tran
   insert into tblTransaction values(@facc,@tacc,@amt,FORMAT(getdate(),'hh:mm:ss'))
   update tblAccount set balance = balance + @amt where acc_no = @tacc
   update tblAccount set balance = balance -@amt where acc_no = @facc
   if(select balance from tblAccount where acc_no =@facc)<1000
   begin
      rollback tran
	  print 'Low balance'
	end
	else
	begin
		print 'Done dana done'
	    commit
	end
end

proc_Do_Transaction 1,3,1000

select * from tblTransaction

begin tran
    print concat('1 print ',@@trancount)
	begin tran 
	   print concat('2 Print inner ',@@trancount)
	commit--filp to rollback and check
    print concat('3. Print out again ',@@trancount)
rollback
delete from tblAccount where acc_no>5
begin tran
    print concat('1 print ',@@trancount)
	insert into tblAccount values(6,6000)
	begin tran 
	insert into tblAccount values(7,7000)
	   print concat('2 Print inner ',@@trancount)
	commit--filp to rollback and check
    print concat('3. Print out again ',@@trancount)
rollback


begin tran
    print concat('1 print ',@@trancount)
	insert into tblAccount values(6,6000) 
	insert into tblAccount values(7,7000)
	print concat('2 Print inner ',@@trancount)
	commit--filp to rollback and check
    print concat('3. Print out again ',@@trancount)
rollback
select * from tblAccount


begin tran
    print concat('1 print ',@@trancount)
	insert into tblAccount values(6,6000)
	save tran MySavePoint
	insert into tblAccount values(7,7000)
    print concat('2. Print out again ',@@trancount)
	rollback tran MySavePoint
commit


begin tran
    print concat('1 print ',@@trancount)
	insert into tblAccount values(6,6000)
	begin tran 
	insert into tblAccount values(7,7000)
	   print concat('2 Print inner ',@@trancount)
	commit--filp to rollback and check
	save tran MySavePoint
	insert into tblAccount values(8,7000)
    print concat('3. Print out again ',@@trancount)
rollback tran MySavePoint
commit