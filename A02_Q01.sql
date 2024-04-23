use magadh;

drop table if exists b_c_l;
drop table if exists branch;
drop table if exists customer;
drop table if exists loan;

create table branch(bid int primary key,br_name char(30),br_city char(10));
create table customer(cno int primary key,cname char(20),caddr char(35),city char(20));
create table loan(lno int primary key,lamtreq decimal(13,2),lamtapp decimal(13,2),l_date date,check(lamtapp<=lamtreq));
create table b_c_l(bid int,foreign key(bid) references branch(bid),cno int,foreign key(cno) references customer(cno),lno int,foreign key(lno) references loan(lno));

desc b_c_l;
desc branch;
desc customer;
desc loan;

insert into branch values(101,'Aundh','Pune'),(102,'Kothrud','Pune'),(103,'Koregaon Park','Pune'),(104,'JM ROAD','Pune'),(105,'Aundh','Pune'),(106,'Kothrud','Pune'),(107,'Baner','Pune'),(108,'JM ROAD','Pune');
insert into customer values(1001,'Harshit','Viman Nagar','Pune'),(1002,'Magadh','Karve Nagar','Nashik'),(1003,'Sam','Dhanakwadi','Pune'),(1004,'Sakshi','Baner','Pimpri'),(1005,'Rohan','Kothrud','Pune'),(1006,'Ali','Kroegaon Park','Pune'),(1007,'Aditi','Karve Nagar','Pune'),(1008,'Rakshita','Viman Nagar','Pune');
insert into loan values(1111,1000000,800000,"2022-11-16"),(1112,500000,500000,"2021-11-12"),(1113,3500000,2500000,"2022-01-31"),(1114,1500000,1500000,"2022-04-29"),(1115,400000,400000,"2021-12-30"),(1116,900000,500000,"2021-11-29"),(1117,2500000,2500000,"2020-12-12")
,(1118,200000,200000,"2022-07-25");
insert into b_c_l values(101,1001,1111),(102,1002,1112),(103,1003,1113),(104,1004,1114),(105,1005,1115),(106,1006,1116),(107,1007,1117),(108,1008,1118);

select * from b_c_l;
select * from branch;
select * from customer;
select * from loan;


#Q1 
select cname from customer where cno in (select cno from b_c_l where bid in(select bid from branch where br_name='Aundh'));

#Q2
select cname from customer where cno in (select cno from b_c_l where lno in(select lno from loan where lamtapp<lamtreq));

#Q3
select max(lamtapp) from loan;

#Q4
select sum(lamtapp) from loan where lno in(select lno from b_c_l where bid in(select bid from branch where br_name='Aundh'));

#Q5
select count(*) from loan where lno in(select lno from b_c_l where bid in(select bid from branch where br_name='JM ROAD'));

#Q6
select c.cname,b.br_name from branch as b,customer as c,loan as l,b_c_l as bcl where bcl.bid=b.bid and bcl.cno=c.cno and l.lno=bcl.lno and month(l.l_date)=12;