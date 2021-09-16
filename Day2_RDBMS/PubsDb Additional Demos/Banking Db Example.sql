create database BBank

create table cust_master(cust_num int primary key, fname varchar(20), mid_nam varchar(20) not null, lname varchar(20), cust_city varchar(20), 
cust_ph varchar(10) default 0000000000, cus_opp varchar(10), cust_DOB date)

create table Brn_master(brn_id int primary key, brn_name varchar(20) not null, brn_city varchar(20))

create table acc_master(acc_num int primary key, cust_num int foreign key references cust_master(cust_num), 
brn_id int foreign key references Brn_master(brn_id), op_bal int check(op_bal>=0), acc_op_date date check(acc_op_date>getdate()),
acc_type varchar(10) check(acc_type='savings' OR acc_type='current'), acc_stat varchar(11) check(acc_stat='active' OR acc_stat='terminated'))

create table loan_det(cust_no int foreign key references cust_master(cust_num), bran_id int foreign key references Brn_master(brn_id),
loan_amt bigint check(loan_amt>50000))

create table trans_det(tran_no int primary key,acc_num int foreign key references acc_master(acc_num), dat_trans date not null,
med_trans varchar(20), trans_typ varchar(20), trans_amt bigint not null check(trans_amt>0))

select * from trans_det
select * from cust_master
select * from Brn_master
select * from acc_master
select * from loan_det

insert into cust_master values('1','hari','krishna','ram','blore','9487657932','techie','12/19/1996')
insert into cust_master values('2','rui','kana','raq','bwre','9487612932','navy','12/20/1996')
insert into cust_master values('3','tap','anhna','aem','inoe','9487327932','army','11/19/1996')
insert into cust_master values('4','ri','aea','ram','manre','9487651332','govt','1/1/1996')
insert into cust_master values('5','nara','manu','rwm','chen','9487237932','busis','1/9/1991')

insert into Brn_master values(2,'DLF','Chennai')
insert into Brn_master values(1,'porur','Chennai')
insert into Brn_master values(3,'mana','Chennai')
insert into Brn_master values(4,'mugul','Chennai')
insert into Brn_master values(5,'koku','Chennai')


insert into acc_master values(101,1,2,1000,'10/01/2019','savings','active')
insert into acc_master values(102,2,1,1000,'10/01/2019','savings','active')
insert into acc_master values(103,3,1,1000,'10/01/2019','savings','active')
insert into acc_master values(104,2,3,1000,'10/01/2019','current','active')
insert into acc_master values(105,1,3,1000,'10/01/2019','savings','active')

insert into trans_det values(200,101,getdate(),'cheque','online','10000')
insert into trans_det values(201,102,getdate(),'cash','offline','200000')
insert into trans_det values(202,102,getdate(),'cheque','offline','5000')
insert into trans_det values(203,101,getdate(),'cash','offline','1100')
insert into trans_det values(204,103,getdate(),'cash','offline','18000')

insert into loan_det values(1,2,60000)
insert into loan_det values(2,5,70000)
insert into loan_det values(2,4,65000)
insert into loan_det values(3,1,70000)
insert into loan_det values(5,1,132000)

