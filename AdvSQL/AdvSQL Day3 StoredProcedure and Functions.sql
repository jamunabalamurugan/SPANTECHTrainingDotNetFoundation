--Stored Procedures

create Procedure prcFirstexample
as
begin

Select getdate() CurrentDate
print 'Hello Todays Date is :'+ CONVERT(char(10),getdate(),1) 
end
--With out check option
create table Test (id int primary key,Name nvarchar(20),
Age int,gender char not null )

create proc prcSecondExample as
begin
if not exists(select * from test)
drop table test
else
print 'Table has records...we cannot drop....needs approval!'
end

--to execute
Execute  prcSecondexample

select * from test
insert into test values(103,'Charu',20,'F')
insert into test values(102,'Kavin',20,'M')
insert into test values(101,'Kanav',20,'M')


--first Query plan 1
select *  from tblEmployeeInfo order by Name
--for an example after 10 mins, new query plan will be generated for the below query
select Name from tblEmployeeInfo
order by name

--Create a proc
create proc prcEmployeeName
as
	select Name,Hiredate
	from tblEmployeeInfo
	order by name
--Calling a procedure or Executing

exec prcEmployeeName
--Creating  a procedure with input
alter proc prcDisplayname(@name varchar(50))
as
begin
select CONCAT('Hi!',@name)
select id,name from tblemployeeinfo
where name = @name
end

prcDisplayname 'Ram'

--Error as it is using a variable
--prcDisplayname @name
declare @myname varchar(30)
set @myname='Kavin'
execute ('prcDisplayname ' + @myname)



create proc prcDisplayId(
@myid int)
as
begin
select CONCAT('Hi!',@myid)
select * from tblemployeeinfo
where id=@myid --1003
end


create proc prcEmployeeManagerName
as
begin
select e.Name as 'Employee Name',
e.id,m.Name as 'Manager Name'
from tblEmployeeInfo e
inner join tblEmployeeInfo m
on e.managerid=m.id
end

 prcEmployeeManagerName
 --Create Procedure with input parameters
create proc prcGetEmpDetails(@place nvarchar(20),@Deptartmentid int)
as
begin
select * from tblEmployeeInfo where location=@place
and depid=@Deptartmentid
end

prcGetEmpDetails 'Bangalore',2

prcGetEmpDetails @Deptartmentid=2,@place='Bangalore'

sp_help test
sp_help prcGetEmpDetails
sp_helptext prcGetEmpDetails
sp_helptext vAge

-----------TAX CALCULATOR--
--If annualsalary>4,00000
create proc prcTaxCalculator(@id int)
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

exec prcTaxCalculator @id=1007
select * from tblEmployeeInfo

create proc prcdeptcount
as
begin
return(select count(depid) from tblDepartment)
end

exec prcdeptcount

declare @deptcount int
exec @deptcount=prcdeptcount
print 'Department count is'+' '+cast( @deptcount as char(2))


---With one input parameter and one output parameter
create procedure prcoutparameter(@did int,@result nvarchar(50) output)
as
begin
set @result=(select Name from tblDepartment
where depid=@did )

end

Declare @dname nvarchar(50) 
exec prcoutparameter 1,@dname output

print 'The Department name is '+@dname
sp_helptext prcoutparameter

---With output parameter
--Give the Total count of Employees for a given Department
create procedure prcoutparameter2(@did int ,@result int output)
as
begin
set @result=(select count(depid) from tblEmployeeInfo
where depid=@did
group by depid)
end

Declare @Dcount int 
exec prcoutparameter2 ,@Dcount output
if(@Dcount>0)
print 'Department has '+ ' '+cast(@Dcount as nvarchar(30))+' Employees'
else
print 'Sorry!!!Department has no employees '


--Drop 
drop procedure Procedure_Name

alter proc prcinsertPerformance(@id int,@rating float(2)) as
begin
if exists(Select * from tblEmployeeInfo where id=@id)
	begin
		--insert tblPerformance values(@id,@rating)
		update tblperformance
		set rating=@rating
		where id=@id
	end
	else
	 begin
		print cast(@id as nvarchar(20))+' ' +'Not eligible for Assesment'
   end
end

--calling stored procedure from another stored procedure
alter proc prcAll(@id int,@r float(2),@name varchar(40),@place varchar(5))
as
begin

exec prcDisplayname @name
exec prcGetEmpDetails @place,@id
exec prcinsertPerformance @id,@r
End

exec prcAll 1002,3,'Kavin','Bangalore'

select * from tblperformance
