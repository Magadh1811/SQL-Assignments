drop database if exists Bank;

create database Bank;

use Bank;

drop table if exists ternary;
drop table if exists branch;
drop table if exists customer;
drop table if exists loan_application;

create table branch(BID int primary key, BR_NAME char(30), BRCITY char(10));
create table customer(CNO int primary key, CNAME char(20), CADDR char(35), CITY char(20));
create table loan_application(LNO int primary key, LAMTREQUIRED numeric(9,2), LAMTAPPROVED numeric(9,2), L_DATE date);
create table ternary(BID int, foreign key(BID) references branch(BID), CNO int, foreign key(CNO) references customer(CNO), LNO int, foreign key(LNO) references loan_application(LNO));

desc branch;
desc customer;
desc loan_application;
desc ternary;

insert into branch values(1111,"Sodepur","Kolkata");
insert into branch values(1121,"Aundh","Pune");
insert into branch values(1122,"Kothrud","Pune");
insert into branch values(1123,"FC Road","Pune");
insert into branch values(1131,"Tejpur","Durgapur");
insert into branch values(1141,"BT Road","Nor24Parg");

select * from branch;

insert into customer values(1,'Pratik',"37/A, HB Town, Sodepur, Kol-700110","Kolkata");
insert into customer values(2,'Ankit',"34/A, Swarg, Aundh, Pune-411007","Pune");
insert into customer values(3,'Sanjana',"68/A, Ramstu, FC Road, Pune-400078","Pune");
insert into customer values(4,'Kritika',"12/B, Tejpur, Durgapur-700204","Durgapur");
insert into customer values(5,'Ram',"37/D, BT Road, North24Parg-700090","Nor24Parg");
insert into customer values(6,'Alexia',"37/A, Matru, Kothrud, Pune-411038","Pune");
insert into customer values(7,'Sanju',"62/C, Ramstu, FC Road, Pune-400078","Pune");
insert into customer values(8,'Alexis',"93/B, Matru, Kothrud, Pune-411038","Pune");

select * from customer;

insert into loan_application values(1,1000000.00,900000.00,'2019-01-06');
insert into loan_application values(2,20000.00,12000.00,'2018-12-18');
insert into loan_application values(3,1000000.00,1000000.00,'2021-03-09');
insert into loan_application values(4,500000.00,400000.00,'2022-04-04');
insert into loan_application values(5,1000000.00,700000.00,'2022-04-26');
insert into loan_application values(6,2500000.00,1900000.00,'2021-10-15');
insert into loan_application values(7,20000.00,20000.00,'2019-12-11');
insert into loan_application values(8,3700000.00,1700000.00,'2022-10-11');

select * from loan_application;

insert into ternary values(1111,1,1);
insert into ternary values(1121,2,3);
insert into ternary values(1122,6,2);
insert into ternary values(1123,8,5);
insert into ternary values(1123,7,7);
insert into ternary values(1123,3,2);
insert into ternary values(1131,4,4);
insert into ternary values(1141,5,6);

select * from ternary;

delimiter $$
create function no_of_customers(name char(30)) returns int
deterministic
begin
    declare count int;
     select count(*) from customer where CNO in(select CNO from ternary where BID=(select BID from branch where BR_NAME=name)) into count;
     return count;
end
$$
delimiter ;
select no_of_customers("FC Road");

delimiter $$
create function max_loan() returns numeric(9,2)
deterministic
begin
    declare max_loan numeric(9,2);
     select count(*) from customer where CNO in(select CNO from ternary where BID=(select BID from branch where BR_NAME=name)) into max_loan;
     return max_loan;
end
$$
delimiter ;
select no_of_customers("FC Road");
