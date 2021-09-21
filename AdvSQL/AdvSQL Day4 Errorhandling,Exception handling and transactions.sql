--Recap of Day4
--TCL
--Intergity constraint

--T-Sql programming
/*o Variable Declarations
o Programming Constructs
o Conditional statements
o If-else
o Case
o While
o Break
o Continue*/

--T-Sql Programming
/*BEGIN
    -- Declare variables
    -- T-SQL Statements
END;*/

Begin
  -- Declaring a variable
  Declare @v_Result Int
  -- Declaring a variable with a value of 50
  Declare @a Int = 50
  -- Declaring a variable with a value of 100
  Declare @b Int = 100
  -- Sum
  Set @v_Result = @a + @b
  -- Print out Console
  print @v_Result
End

--if  else
--program 2
declare @Var1 int =10, @Var2 int
--set @Var1=10
set @Var2=40
begin
if( @Var1 > @Var1)
print 'Var1 is greater'
else
print 'Var2 is greater'
end
---------
select * from tbl_Performance

/*CASE <Case_Expression>
     WHEN Value_1 THEN Statement_1
     WHEN Value_2 THEN Statement_2
     .
     .
     WHEN Value_N THEN Statement_N
     [ELSE Statement_Else]   
END AS [ALIAS_NAME]*/

-------------
select Empid,Rating,Remarks=
case 
when Rating =5 then 'Excellent'
when Rating<=4.9 and Rating >=4 then 'Very Good'
else 'poor'
End as Description
from tblPerformance

------------------

select * from tblEmployeeInfo
alter table tblEmployeeinfo
alter column Gender nvarchar(20)

UPDATE tblEmployeeInfo
SET Gender = CASE Gender
 WHEN 'F' THEN 'female' 
 when 'M' then 'Male'
 else 'Not Entered'
 END


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
-----------------------
-----------------While
DECLARE @count INT;
SET @count = 1;
    
WHILE @count<= 5
BEGIN
   PRINT @count
   SET @count = @count + 1;
END

----------- While with break and continue
DECLARE @COUNTER INT = 0
WHILE @COUNTER < 10
 BEGIN
    SET @COUNTER = @COUNTER + 1
 
    IF @COUNTER = 7
        CONTINUE
 
    IF @COUNTER = 9
        BREAK
 
    PRINT @COUNTER
END

----------Stored Procedure--------
--DDL,DML,Logic
/*Create procedure <procedure_Name> 
As 
Begin 
<SQL Statement> 
End 
Go
*/
/*Implementing Stored Procedures
o What is Stored Procedure--Its a precompiled set of sql statements
o Creating Stored Procedures
o Executing Stored Procedures
o Creating Parameterized Stored Procedures
o Handle errors in a stored procedure */

select @@ERROR,@@SERVERNAME


---Inserting data in performance table
select * from tblPerformance
create Proc prcinsertPerformance(@id int,@Rating float(2)) 
as
begin
insert tblPerformance(Eid,Rating) values(@id,@Rating)
End

exec prcinsertPerformance   @id=1008,@Rating=3.7 

----

create proc prcPerformaceCalculation
as
begin
select Eid,
case 
when Rating =5 then 'Excellent'
when Rating<=4.9 and Rating >=4 then 'Very Good'
else 'poor'
End as Description
from tblPerformance
end

exec prcPerformaceCalculation

-----------TAX CALCULATOR--
--If annualsalary>4,00000
alter proc prcTaxCalculator(@id int)
as
begin
declare @Annualsalary int
declare @Taxamount int

set @Annualsalary = (select salary*12 from tblEmployeeInfo where id=@id)
if(@Annualsalary>400000)
   begin
   set @Taxamount=@Annualsalary*0.1
   print @Taxamount
   end
else
   begin
   print cast(@id as nvarchar(20))+' ' +'Not eligible to pay tax'
   end

end

exec prcTaxCalculator @id=1008
select * from tblEmployeeInfo

--retun 
/*int add(int a,int b)
{
return a+b;
}

Main()
{
int c=add(10,20);
}
*/
--return will retun only integer
create proc prcdeptcount
as
begin
return(select count(deptid) from tblDepartment)
end

declare @deptcount int
exec @deptcount=prcdeptcount
print 'Department count is'+' '+cast( @deptcount as nvarchar(30))

---below will raise an error since we trying to return string
create proc prcdeptname
as
begin
return(select Deptname from tblDepartment where Deptid=14)
end

exec prcdeptname


BEGIN TRY
  DECLARE @result INT
--Generate divide-by-zero error
  SET @result = 55/0
END TRY
BEGIN CATCH
    --THROW
	print 'unexpected error'
END CATCH


--Error handling in stored Procedure
/*RAISERROR(
    @MessageText, -- Message text
    16, -- severity
    1, -- state
    N'2001' -- first argument to the message text
);*/

sp_addmessage 50010,10,'Member id not found..'

sp_helptext sp_addmessage
sp_help sysmessages
select * from sysobjects
alter proc prcErrorHandling(@id int)
as
begin
begin try
if not exists(select name from tblEmployeeInfo
where id=@id)
begin
	raiserror(50010,10,1)
	return
end
else
begin
	update tblEmployeeInfo set Salary=Salary+name where id=@id
end
End try
begin catch
 --SELECT ERROR_STATE() AS Error_Stat,ERROR_SEVERITY() AS ErrorSeverity,
-- ERROR_LINE() as ErrorLine, ERROR_NUMBER() AS ErrorNumber, ERROR_MESSAGE() AS ErrorMsg;  
--select ERROR_SEVERITY()
	Raiserror(15600,6,1,'Invalid operation')
End Catch
End
select host_id(),HOST_NAME(),SUSER_NAME(),db_name()


exec prcErrorHandling 1004
select @@ERROR
select * from tblEmployeeInfo
---With output parameter
create procedure prcoutparameter2(@did int ,@result int output)
as
begin
set @result=(select Name from tblDepartment
where depid=@did )

end

Declare @Dcount int 
exec prcoutparameter2 1,@Dcount output
if(@Dcount>0)
print 'Department has '+ ' '+cast(@Dcount as nvarchar(30))
else
print 'Department has '+ ' '+cast(@Dcount as nvarchar(30))
--Drop 
drop procedure Procedure_Name

--calling stored procedure from another stored procedure
alter proc spu_callingProcedure(@id int,@r float(2))
as
begin

exec prcDisplayname 'Sai'
exec prcEmployeedetails
exec prcinsertPerformance @id,@r
End

exec spu_callingProcedure 1009,5

select * from tblPerformance


--StyleValues of the Date Format
--Compare the style values and observe that when the styles used 
--are 1, 2, 3, 4, or 5, year is displayed in the yy format. 
--Similarly, when the styles used are 101, 102, 103, 104, or 105, year is
--displayed in the yyyy format. 
--Consider the following example, where you need to display the
--Name and hire date from the Employee table.
--The hire date is converted from the date data type to the character data type and then displayed in the yy.mm.dd format. This is because the style specified in the function is 2. 
SELECT  CONVERT(char(10),HireDate,102) 'HireDate of Employee'
FROM tblEmployeeInfo


--Function
/*CREATE FUNCTION [schema_name.]function_name (parameter_list)
RETURNS data_type AS
BEGIN
    statements
    RETURN value
END*/
--function cant return text,ntext,image,cursor and timestamp
--user defined Function
    --Scalar Function (return only one value)
	--Table valued Function(Multiple value)
--Scalar Function

 create function funEmplNameCity(@Name nvarchar(30),@city nvarchar(30))
 returns nvarchar(100)
 as
 begin
 return (select @Name+' '+@City)
 end

 --execute 
 select dbo.funEmplNameCity('Jamuna','Chennai')

 select id as Emloyeeid,dbo.funEmplNameCity(name,location) as Employee_NAME_CITY,
 age from tblEmployeeInfo
  

 --TaxCalculator
 create function funTaxCalculation(@id int)
 returns int
 as
 begin
 declare @Annualsalary int
declare @Taxamount int
set @Annualsalary = (select salary*12 from tblEmployeeInfo where id=@id)
if(@Annualsalary>400000)
   begin
   set @Taxamount=@Annualsalary*0.1
  -- return @Taxamount
   end
else
   begin
 set @Taxamount= 0
   end
   return @Taxamount
  End

  --exec
  select id,name,salary,dbo.funTaxCalculation(Id) as TAXAMOUNT from tblEmployeeInfo

  --Drop function functionName

  --create a function to display the experience of each employee 

  --Table value function

  /*create function function_Name(ParameterList)
  returns table
  as
  return
  statement
  */ 
  create function fun_Employeetable()
  returns table
  as 
  return (select Name,Salary from tblEmployeeInfo)
  
  --exec
  select * from fun_Employeetable()
  select Name,Mobileno,Hiredate from fun_Employeetable()
  --------------
 create function fun_empdept14(@did int)
  returns table
  as
  return(select * from tblEmployeeInfo where depid=@did )

  select Name,Depid from fun_empdept14(2)
   --Alter
  alter function fun_empdept14(@did int)
  returns table
  as
  return(select * from tblEmployeeInfo where did=@did 
  and city like '[MC]%')

  select Name,Did,Managerid from fun_empdept14(13)


  --can i  call function from another function?no
  select max(min(salary)) from tblEmployeeInfo --error

  select  Name,Mobileno,Hiredate,dbo.funTaxCalculation(id)
  from funEmployeetable() --error
 ---------------------------------------
create function fun_callinganotherfunction1(@did int)
 returns nvarchar(200)
 as
 begin
 return(select name  from dbo.fun_empdept14(@did) )
 
 end
 select  dbo.fun_callinganotherfunction1(2) 
 select name  from dbo.fun_empdept14(2) 
 -----------------------------------------------
-- can i call a stored procedure inside a function?? no

--Only SELECT statements can be done inside a function


--difference btw functions and stored procedure
1.Cannot be executed by itself			SP can be executed separately
2.Cannot return more than one value		SP can return multiple output parameters
3.Only perform select...NO DDL or DML	SP can excute DML
4.Cannot call a SP						SP can call as many functions required
5.Function must return atleast one value SP need not return a value
--can we call a function inside the stored procedure?Yes


alter proc spu_callFunction
as
begin
select Emp_id,dbo.fun_EmplNameCity(name,City),mobileno from tblEmployeeInfo
end
 
 exec spu_callFunction 
 ----------not possible results in error
 create function fun_callprocedure()
 returns ----------
 as
 begin
return exec prcinsertPerformance 1009,4.5

----------Referential Integrity Constraint------
create table tbl_Book(Bid nvarchar(20) primary key,Bookname nvarchar(30))
create table tbl_customer(cid int primary key,cname nvarchar(20))


create table tbl_Reader(Bid nvarchar(20) references tbl_Book(Bid)
                        on delete cascade
					    on update cascade ,
						Cid int  references tbl_customer(cid))

insert into tbl_Book values ('B001','Java'),('B002','.Net'),('B003','C++')

insert into tbl_customer values(100,'Hari'),(101,'Nithya'),(102,'Suresh')

insert into tbl_Reader values('B001',100),('B001',102),('B002',101)
select * from tbl_customer
select * from tbl_Book

select * from tbl_Reader

delete from tbl_Book where Bid='B002'

update tbl_Book set Bid='N001' where Bookname='Network'

update tbl_Book set Bookname='Network' where Bookname='Java'

--TCL ,Commit,ROllback,Save --check point

begin transaction
save tran S1
insert into tbl_Book values('B002','AI')
select * from tbl_Book
save tran S2
delete from tbl_Book where Bookname='C++'

rollback tran S1
end transaction


select * from tbl_Book

begin transaction
save tran S1
insert into tbl_Book values('B004','OOPS')
save tran S2
delete from tbl_Book where Bookname='C++'
select * from tbl_Book
rollback tran S2

select * from tbl_Book

begin transaction t1
insert into tbl_Book values('B006','DS')
select * from tbl_Book
commit tran t1
rollback tran


Transactions

BEGIN TRANSACTION TR
BEGIN TRY
UPDATE Person.Contact 
SET EmailAddress='jamunbalamurugan@yahoo.com' 
WHERE ContactID = 1070
UPDATE EmployeeAddress SET MobileNo= 
9444032689
WHERE EmployeeID = 1
COMMIT TRANSACTION TR
SELECT 'Transaction Executed'
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION TR

SELECT 'Transaction Rollbacked'
END CATCH

set implicit_transactions on
select @@TRANCOUNT
-------Trigger---------
-- when an DML action is performed which in turn can lead
to calling a procedure automatically
--special sp that is executed whenever a data modification takes place

--differ from stored procedure...a sp can be explicitly by a users
--triggers cannot be manually executed by the user
--there is no chance for trigger to receive parameters
/*CREATE TRIGGER trigger_name   
ON { Table name or view name }   
[ WITH <Options> ]  
{ FOR | AFTER | INSTEAD OF }   
{ [INSERT], [UPDATE] , [DELETE] }
*/
--no one should insert record in tbl_Department
create trigger t_InsertDept
on tblDepartment
for Insert
as
begin

print 'Insert operation is not allowed!! '
End

-----------Ex1
alter TRIGGER tr_Insertdept 
ON tbldepartment
FOR INSERT
AS
BEGIN
  PRINT 'YOU CANNOT PERFORM INSERT OPERATION'
  Rollback transaction
  
END

--insert 
select * from tblDepartment
insert into tblDepartment values('CSE')

--drop trigger trigger_Name

---Insert Ex2
create table P_desc(Eid int,Description nvarchar(40)

select * from tblPerformance
select * from P_desc

create trigger t_insertinP_desc
on tbl_performance
for insert
as
begin
declare @t_id int,@t_rating float(2)
set @t_id=(select Eid from inserted)
set @t_rating=(select rating from inserted)
insert into P_desc values(@t_id,case
 when @t_rating=5 then 'Excellent'
 when  @t_rating<=4.9 and @t_rating>=4 then 'Good'
 else 'Poor'
 End)
 End
 select * from tblEmployeeInfo

 insert into tblPerformance values(1010,5)

  insert into tblPerformance values(1011,3)
 drop trigger trInsertPerformance

 ------Delete
 create trigger t_deleteperformance
 on tblPerformance
 for delete
 as
 begin
 declare @t_id int
 set @t_id=(select Eid from deleted)
 if(@t_id=Null)
 begin
 raiserror('Input cant be null',1,8)
 end
 else
 begin
 delete from P_desc where Eid=@t_id
 print 'Record Deleted'
 End
 End

 select * from tblPerformance
 select * from P_desc

 delete from tblPerformance where eid=1011
 -----
  alter trigger t_deleteperformance
 on tblPerformance
 for delete
 as
 begin
 declare @t_id int
 set @t_id=(select Eid from deleted)
 
 begin try
  delete from P_desc where Eid=@t_id
 print 'Record Deleted'
 end try
 begin catch
 raiserror('Please check the given Input',1,7)
 end catch
 End

 ----Update trigger
 create table tbl_LeaveStatus(Eid int references tblEmployeeInfo(Emp_id),Status nvarchar(30),
 ApprovedDate datetime)

 create trigger t_Leave
 on tbl_LeaveStatus
 for update
 as
 begin
 update tbl_LeaveStatus set ApprovedDate=GETDATE()
  where Status='Approved'
 end

 insert into tbl_LeaveStatus(Eid,Status) values(1002,'Pending')
 insert into tbl_LeaveStatus(Eid,Status) values(1004,'Pending')

 select *  from tbl_LeaveStatus
 update tbl_LeaveStatus set Status='Approved' where Eid=1002 


 --Disabling constraint
 --Enabling or disabling constraints work only to check and foreign key constraints
 sp_help tblEmployeeInfo
 --disabling one constraint
 alter table tblEmployeeInfo nocheck constraint CK__tbl_Employe__Age__398D8EEE
 select * from tblEmployeeInfo
 insert into tblEmployeeInfo values(1015,'Hari',16,'jammu','Male','8901234567',22200,'2019-11-11',15,1006)
 --Disabling both check and foreign key
 alter table tblEmployeeInfo nocheck constraint  all
 --To enable all constraint

 alter table tblEmployeeInfo check  constraint all
 insert into tblEmployeeInfo values(1016,'Sam',16,'jammu','Male','8901234567',22200,'2019-11-11',15,1006

 -----------



