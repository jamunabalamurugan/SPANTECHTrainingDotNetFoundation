/****** Object:  Database [dbHumanResource]    Script Date: 9/22/2021 12:55:07 PM ******/
CREATE DATABASE [dbHumanResource]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'dbHumanResource', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.HBSQLEXPRESS\MSSQL\DATA\dbHumanResource.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'dbHumanResource_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.HBSQLEXPRESS\MSSQL\DATA\dbHumanResource_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [dbHumanResource] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [dbHumanResource].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [dbHumanResource] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [dbHumanResource] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [dbHumanResource] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [dbHumanResource] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [dbHumanResource] SET ARITHABORT OFF 
GO
ALTER DATABASE [dbHumanResource] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [dbHumanResource] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [dbHumanResource] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [dbHumanResource] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [dbHumanResource] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [dbHumanResource] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [dbHumanResource] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [dbHumanResource] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [dbHumanResource] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [dbHumanResource] SET  ENABLE_BROKER 
GO
ALTER DATABASE [dbHumanResource] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [dbHumanResource] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [dbHumanResource] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [dbHumanResource] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [dbHumanResource] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [dbHumanResource] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [dbHumanResource] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [dbHumanResource] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [dbHumanResource] SET  MULTI_USER 
GO
ALTER DATABASE [dbHumanResource] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [dbHumanResource] SET DB_CHAINING OFF 
GO
ALTER DATABASE [dbHumanResource] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [dbHumanResource] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [dbHumanResource] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [dbHumanResource] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [dbHumanResource] SET QUERY_STORE = OFF
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetSalWithEID]    Script Date: 9/22/2021 12:55:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[fn_GetSalWithEID](@eid int)
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
GO
/****** Object:  UserDefinedFunction [dbo].[fun_callinganotherfunction1]    Script Date: 9/22/2021 12:55:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[fun_callinganotherfunction1](@did int)
 returns nvarchar(200)
 as
 begin
 return(select name  from dbo.fun_empdept14(@did) )
 
 end
GO
/****** Object:  UserDefinedFunction [dbo].[funEmplNameCity]    Script Date: 9/22/2021 12:55:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create function [dbo].[funEmplNameCity](@Name nvarchar(30),@city nvarchar(30))
 returns nvarchar(100)
 as
 begin
 return (select @Name+' '+@City)
 end
GO
/****** Object:  UserDefinedFunction [dbo].[funTaxCalculation]    Script Date: 9/22/2021 12:55:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[funTaxCalculation](@id int)
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
GO
/****** Object:  Table [dbo].[tblEmployeeInfo]    Script Date: 9/22/2021 12:55:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblEmployeeInfo](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](20) NOT NULL,
	[Location] [nvarchar](30) NULL,
	[DepId] [int] NULL,
	[age] [int] NULL,
	[gender] [nvarchar](20) NULL,
	[Salary] [money] NULL,
	[Hiredate] [date] NULL,
 CONSTRAINT [pkEmployeeId] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vEmployeeAge]    Script Date: 9/22/2021 12:55:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--create a view with condition
CREATE view [dbo].[vEmployeeAge]
as
select id,Name,location,age from tblEmployeeInfo
where age>=25
with check option
GO
/****** Object:  Table [dbo].[tblDepartment]    Script Date: 9/22/2021 12:55:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblDepartment](
	[DepId] [int] NOT NULL,
	[Name] [nvarchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DepId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vMaxsalary]    Script Date: 9/22/2021 12:55:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[vMaxsalary]
as
select  d.name,max(e.Salary) as 'Maximum Salary'  
from tblEmployeeInfo e join tblDepartment d
on d.Depid=e.Depid
group by d.name
GO
/****** Object:  Table [dbo].[tblPerformance]    Script Date: 9/22/2021 12:55:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblPerformance](
	[id] [int] NULL,
	[rating] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[emprating]    Script Date: 9/22/2021 12:55:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[emprating] as
select id,Rating,Remarks=
case 
when Rating =5 then 'Excellent'
when Rating<=4.9 and Rating >=4 then 'Very Good'
else 'poor'
End 
from tblPerformance
GO
/****** Object:  UserDefinedFunction [dbo].[fun_Employeetable]    Script Date: 9/22/2021 12:55:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[fun_Employeetable]()
  returns table
  as 
  return (select Name,Salary from tblEmployeeInfo)
GO
/****** Object:  UserDefinedFunction [dbo].[fun_empdept14]    Script Date: 9/22/2021 12:55:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  --------------
 create function [dbo].[fun_empdept14](@did int)
  returns table
  as
  return(select * from tblEmployeeInfo where depid=@did )
GO
/****** Object:  View [dbo].[vEmployeepersonaldetails]    Script Date: 9/22/2021 12:55:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vEmployeepersonaldetails]
as
select id, Name, age,gender from tblEmployeeInfo
GO
/****** Object:  Table [dbo].[departments]    Script Date: 9/22/2021 12:55:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[departments](
	[department_id] [int] NOT NULL,
	[depname] [varchar](40) NOT NULL,
	[mgrid] [char](10) NULL,
	[location_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[department_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[employees]    Script Date: 9/22/2021 12:55:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[employees](
	[employee_id] [int] NOT NULL,
	[first_name] [varchar](20) NULL,
	[last_name] [varchar](25) NOT NULL,
	[email] [varchar](25) NOT NULL,
	[phone_number] [varchar](20) NULL,
	[hire_date] [datetime] NOT NULL,
	[job_id] [varchar](10) NOT NULL,
	[salary] [int] NULL,
	[commission_pct] [int] NULL,
	[manager_id] [int] NULL,
	[department_id] [int] NULL,
 CONSTRAINT [myemployees_pk] PRIMARY KEY CLUSTERED 
(
	[employee_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[P_desc]    Script Date: 9/22/2021 12:55:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[P_desc](
	[Eid] [int] NULL,
	[Description] [nvarchar](40) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_employee]    Script Date: 9/22/2021 12:55:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_employee](
	[eid] [int] IDENTITY(1,1) NOT NULL,
	[ename] [varchar](20) NULL,
	[sa_id] [int] NULL,
	[leaveCount] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[eid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_LeaveStatus]    Script Date: 9/22/2021 12:55:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_LeaveStatus](
	[Eid] [int] NULL,
	[Status] [nvarchar](30) NULL,
	[ApprovedDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblEmployeeLeave]    Script Date: 9/22/2021 12:55:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblEmployeeLeave](
	[EmployeeID] [int] NOT NULL,
	[LeaveStartDate] [datetime] NOT NULL,
	[LeaveEndDate] [datetime] NOT NULL,
	[LeaveReason] [varchar](100) NULL,
	[LeaveType] [char](2) NULL,
 CONSTRAINT [cpkEmployeeId] PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC,
	[LeaveStartDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblsalary]    Script Date: 9/22/2021 12:55:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblsalary](
	[salid] [int] NOT NULL,
	[basi] [float] NULL,
	[hra] [float] NULL,
	[da] [float] NULL,
	[deductions] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[salid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblUserdetails]    Script Date: 9/22/2021 12:55:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUserdetails](
	[username] [varchar](20) NOT NULL,
	[password] [varchar](20) NULL,
	[role] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Test]    Script Date: 9/22/2021 12:55:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Test](
	[id] [int] NOT NULL,
	[Name] [nvarchar](20) NULL,
	[Age] [int] NULL,
	[gender] [char](1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[departments] ([department_id], [depname], [mgrid], [location_id]) VALUES (2, N'QUALITY', N'E001      ', 200)
INSERT [dbo].[departments] ([department_id], [depname], [mgrid], [location_id]) VALUES (101, N'Finance', NULL, 1)
INSERT [dbo].[departments] ([department_id], [depname], [mgrid], [location_id]) VALUES (102, N'Finance', NULL, 1)
INSERT [dbo].[departments] ([department_id], [depname], [mgrid], [location_id]) VALUES (103, N'IT', NULL, 1)
GO
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [job_id], [salary], [commission_pct], [manager_id], [department_id]) VALUES (1003, N'Akhil', N'V', N'Akilv@gmail.com', N'9444077777', CAST(N'2018-01-23T00:00:00.000' AS DateTime), N'IT', 40000, NULL, NULL, 2)
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [job_id], [salary], [commission_pct], [manager_id], [department_id]) VALUES (1004, N'Akhilandeshwari', N'V', N'Akiladeshwari@gmail.com', N'9444077777', CAST(N'2018-01-23T00:00:00.000' AS DateTime), N'IT', 40000, NULL, NULL, 2)
GO
SET IDENTITY_INSERT [dbo].[tbl_employee] ON 

INSERT [dbo].[tbl_employee] ([eid], [ename], [sa_id], [leaveCount]) VALUES (2, N'Kavin', NULL, 2)
INSERT [dbo].[tbl_employee] ([eid], [ename], [sa_id], [leaveCount]) VALUES (3, N'Kanav', 1002, 2)
SET IDENTITY_INSERT [dbo].[tbl_employee] OFF
GO
INSERT [dbo].[tbl_LeaveStatus] ([Eid], [Status], [ApprovedDate]) VALUES (1004, N'Approved', CAST(N'2021-05-19T12:38:52.877' AS DateTime))
GO
INSERT [dbo].[tblDepartment] ([DepId], [Name]) VALUES (1, N'Admin')
INSERT [dbo].[tblDepartment] ([DepId], [Name]) VALUES (2, N'Finance')
INSERT [dbo].[tblDepartment] ([DepId], [Name]) VALUES (3, N'Training')
INSERT [dbo].[tblDepartment] ([DepId], [Name]) VALUES (4, N'IT Services')
INSERT [dbo].[tblDepartment] ([DepId], [Name]) VALUES (5, N'Human Resources')
INSERT [dbo].[tblDepartment] ([DepId], [Name]) VALUES (6, N'Quality')
INSERT [dbo].[tblDepartment] ([DepId], [Name]) VALUES (7, N'SoftwareTesting')
INSERT [dbo].[tblDepartment] ([DepId], [Name]) VALUES (8, N'Quality')
INSERT [dbo].[tblDepartment] ([DepId], [Name]) VALUES (9, N'Account')
INSERT [dbo].[tblDepartment] ([DepId], [Name]) VALUES (10, N'Sales')
GO
INSERT [dbo].[tblEmployeeInfo] ([Id], [Name], [Location], [DepId], [age], [gender], [Salary], [Hiredate]) VALUES (1001, N'Kavin', N'Bangalore', 2, NULL, N'Male', NULL, NULL)
INSERT [dbo].[tblEmployeeInfo] ([Id], [Name], [Location], [DepId], [age], [gender], [Salary], [Hiredate]) VALUES (1004, N'Harshitha', NULL, 2, 26, NULL, 83000.0000, CAST(N'2017-08-10' AS Date))
INSERT [dbo].[tblEmployeeInfo] ([Id], [Name], [Location], [DepId], [age], [gender], [Salary], [Hiredate]) VALUES (1006, N'Saadhana', NULL, 2, 21, NULL, 33000.0000, CAST(N'2017-08-10' AS Date))
INSERT [dbo].[tblEmployeeInfo] ([Id], [Name], [Location], [DepId], [age], [gender], [Salary], [Hiredate]) VALUES (1007, N'Ram', NULL, 1, 26, NULL, 23000.0000, CAST(N'2017-08-10' AS Date))
INSERT [dbo].[tblEmployeeInfo] ([Id], [Name], [Location], [DepId], [age], [gender], [Salary], [Hiredate]) VALUES (1008, N'Raj', NULL, NULL, 37, NULL, NULL, NULL)
INSERT [dbo].[tblEmployeeInfo] ([Id], [Name], [Location], [DepId], [age], [gender], [Salary], [Hiredate]) VALUES (1009, N'Ragul', N'17', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tblEmployeeInfo] ([Id], [Name], [Location], [DepId], [age], [gender], [Salary], [Hiredate]) VALUES (1010, N'Jamuna', NULL, NULL, 37, N'Female', NULL, NULL)
GO
INSERT [dbo].[tblPerformance] ([id], [rating]) VALUES (1001, 3)
INSERT [dbo].[tblPerformance] ([id], [rating]) VALUES (1002, 4)
INSERT [dbo].[tblPerformance] ([id], [rating]) VALUES (1003, 3)
INSERT [dbo].[tblPerformance] ([id], [rating]) VALUES (1004, 2)
GO
INSERT [dbo].[tblsalary] ([salid], [basi], [hra], [da], [deductions]) VALUES (1002, 54000, 5000, 4000, 1000)
GO
INSERT [dbo].[tblUserdetails] ([username], [password], [role]) VALUES (N'Kanav', N'1234', N'User')
INSERT [dbo].[tblUserdetails] ([username], [password], [role]) VALUES (N'Kavin', N'1234', N'Admin')
INSERT [dbo].[tblUserdetails] ([username], [password], [role]) VALUES (N'Sumedha', N'1111', N'User')
GO
INSERT [dbo].[Test] ([id], [Name], [Age], [gender]) VALUES (101, N'Kanav', 20, N'M')
INSERT [dbo].[Test] ([id], [Name], [Age], [gender]) VALUES (102, N'Kavin', 20, N'M')
INSERT [dbo].[Test] ([id], [Name], [Age], [gender]) VALUES (103, N'Charu', 20, N'F')
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__employee__AB6E61643702828E]    Script Date: 9/22/2021 12:55:07 PM ******/
ALTER TABLE [dbo].[employees] ADD UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [indxCity]    Script Date: 9/22/2021 12:55:07 PM ******/
CREATE NONCLUSTERED INDEX [indxCity] ON [dbo].[tblEmployeeInfo]
(
	[Location] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[employees]  WITH CHECK ADD FOREIGN KEY([department_id])
REFERENCES [dbo].[departments] ([department_id])
GO
ALTER TABLE [dbo].[employees]  WITH CHECK ADD FOREIGN KEY([manager_id])
REFERENCES [dbo].[employees] ([employee_id])
GO
ALTER TABLE [dbo].[tbl_employee]  WITH CHECK ADD FOREIGN KEY([sa_id])
REFERENCES [dbo].[tblsalary] ([salid])
GO
ALTER TABLE [dbo].[tbl_LeaveStatus]  WITH CHECK ADD FOREIGN KEY([Eid])
REFERENCES [dbo].[tblEmployeeInfo] ([Id])
GO
ALTER TABLE [dbo].[tblEmployeeInfo]  WITH CHECK ADD FOREIGN KEY([DepId])
REFERENCES [dbo].[tblDepartment] ([DepId])
GO
ALTER TABLE [dbo].[tblEmployeeLeave]  WITH CHECK ADD  CONSTRAINT [fkEmployeeID] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[tblEmployeeInfo] ([Id])
GO
ALTER TABLE [dbo].[tblEmployeeLeave] CHECK CONSTRAINT [fkEmployeeID]
GO
ALTER TABLE [dbo].[employees]  WITH CHECK ADD CHECK  (([hire_date]<getdate()))
GO
ALTER TABLE [dbo].[employees]  WITH CHECK ADD CHECK  (([salary]>(0)))
GO
ALTER TABLE [dbo].[tblEmployeeLeave]  WITH CHECK ADD  CONSTRAINT [chkLeave] CHECK  (([LeaveType]='PL' OR [LeaveType]='SL' OR [LeaveType]='CL'))
GO
ALTER TABLE [dbo].[tblEmployeeLeave] CHECK CONSTRAINT [chkLeave]
GO
/****** Object:  StoredProcedure [dbo].[inserttosalary]    Script Date: 9/22/2021 12:55:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create proc [dbo].[inserttosalary](@salid int, @basic float, @hra float, @da float, @deduction float)
as
begin
    insert into tblsalary values(@salid,@basic,@hra,@da,@deduction)
end
GO
/****** Object:  StoredProcedure [dbo].[prcAll]    Script Date: 9/22/2021 12:55:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[prcAll](@id int,@r float(2),@name varchar(40),@place varchar(5))
as
begin

exec prcDisplayname @name
exec prcGetEmpDetails @place,@id
exec prcinsertPerformance @id,@r
End
GO
/****** Object:  StoredProcedure [dbo].[prcdeptcount]    Script Date: 9/22/2021 12:55:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[prcdeptcount]
as begin
select count(depid) from tblDepartment
end
GO
/****** Object:  StoredProcedure [dbo].[prcDisplayname]    Script Date: 9/22/2021 12:55:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[prcDisplayname](@name varchar(50))
as
begin
select CONCAT('Hi!',@name)
select id,name from tblemployeeinfo
where name = @name
end
GO
/****** Object:  StoredProcedure [dbo].[prcErrorHandling]    Script Date: 9/22/2021 12:55:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[prcErrorHandling](@id int)
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
GO
/****** Object:  StoredProcedure [dbo].[prcFirstexample]    Script Date: 9/22/2021 12:55:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create Procedure [dbo].[prcFirstexample]
as
begin

Select getdate() CurrentDate
print 'Hello Todays Date is :'+ CONVERT(char(10),getdate(),1) 
end
GO
/****** Object:  StoredProcedure [dbo].[prcGetEmpDetails]    Script Date: 9/22/2021 12:55:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[prcGetEmpDetails](@place nvarchar(20),@Deptartmentid int)
as
begin
select * from tblEmployeeInfo where location=@place
and depid=@Deptartmentid
end
GO
/****** Object:  StoredProcedure [dbo].[prcinsertPerformance]    Script Date: 9/22/2021 12:55:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[prcinsertPerformance](@id int,@rating float(2)) as
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
GO
/****** Object:  StoredProcedure [dbo].[prcoutparameter]    Script Date: 9/22/2021 12:55:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[prcoutparameter](@did int,@result nvarchar(50) output)
as
begin
set @result=(select Name from tblDepartment
where depid=@did )

end
GO
/****** Object:  StoredProcedure [dbo].[prcoutparameter2]    Script Date: 9/22/2021 12:55:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[prcoutparameter2](@did int ,@result int output)
as
begin
set @result=(select count(depid) from tblEmployeeInfo
where depid=@did
group by depid)
end
GO
/****** Object:  StoredProcedure [dbo].[prcoutparameter3]    Script Date: 9/22/2021 12:55:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[prcoutparameter3](@did int ,@result int output,@maxhiredt datetime output)
as
begin
set @result=(select count(depid) from tblEmployeeInfo
where depid=@did
group by depid)
set @maxhiredt=(select max(hiredate) from tblemployeeinfo
where depid=@did
group by depid)
end

GO
/****** Object:  StoredProcedure [dbo].[prcSecondExample]    Script Date: 9/22/2021 12:55:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[prcSecondExample] as
begin
if not exists(select * from test)
drop table test
else
print 'Table has records...we cannot drop....needs approval!'
end
GO
/****** Object:  StoredProcedure [dbo].[prcSeconfExample]    Script Date: 9/22/2021 12:55:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[prcSeconfExample] as
begin
if not exists(select * from test)
drop table test
else
print 'Table has records...we cannot drop....needs approval!'
end
GO
/****** Object:  StoredProcedure [dbo].[pro_Insert_into_tbl_employee]    Script Date: 9/22/2021 12:55:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[pro_Insert_into_tbl_employee](@en varchar(20),@sa_id int,@leaveCount int)
as 
begin
    insert into tbl_employee values (@en,@sa_id,@leaveCount )
    
end
GO
/****** Object:  StoredProcedure [dbo].[proc_Insert_TblUserDetails]    Script Date: 9/22/2021 12:55:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[proc_Insert_TblUserDetails](@un varchar(20),@pass varchar(20), @rl varchar(20))
as
begin
   Insert into tblUserdetails values(@un,@pass,@rl)
end

GO
/****** Object:  StoredProcedure [dbo].[proc_Login_Check]    Script Date: 9/22/2021 12:55:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[proc_Login_Check](@un varchar(20),@pass varchar(20), @rl varchar(20) out)
as
begin
   declare
   @rol varchar(20)
   set @rol = (select role from tblUserdetails where username = @un and password = @pass)
   if (select count(role) from tblUserdetails where username = @un and password = @pass )<1
      set @rl = 'Error'
	else
		set @rl=@rol
end
GO
ALTER DATABASE [dbHumanResource] SET  READ_WRITE 
GO
