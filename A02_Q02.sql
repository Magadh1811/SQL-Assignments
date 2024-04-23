use magadh;

drop table if exists store_item;
drop table if exists item_order;
drop table if exists orders;
drop table if exists stores;
drop table if exists customers;
drop table if exists items;
drop table if exists warehouses;
drop table if exists cities;

create table cities(city char(20) primary key,state char(20));
create table warehouses(wid int primary key,wname char(30),location char(20),city char(20),foreign key(city) references cities(city));
create table stores(sid int primary key,store_name char(20),location_city char(20),wid int,foreign key(wid) references warehouses(wid));
create table items(ino int primary key,description text(100),weight int,cost int);
create table customers(cno int primary key,cname char(20),addr char(20),cu_city char(20));
create table orders(ono int primary key,odate date,cno int,foreign key(cno) references customers(cno));
create table item_order(ino int,ono int,foreign key(ino) references items(ino),foreign key(ono) references orders(ono),o_quantity int);
create table store_item(sid int,ino int,foreign key(sid) references stores(sid),foreign key(ino) references items(ino));

desc store_item;
desc item_order;
desc orders;
desc stores;
desc customers;
desc items;
desc warehouses;
desc cities;

# Inserting values into tables

insert into cities values('Pune','Maharashtra'),('Mumbai','Maharashtra'),('Chandigarh','Chandigarh'),('Agra','U.P'),('Thane','Mumbai');

insert into warehouses values(101,'Nike','Viman Nagar','Pune'),(102,'Adidas','Mulund','Thane'),(103,'Puma','Sector 47','Chandigarh'),(104,'Adidas','Dadar','Mumbai'),(105,'Adidas','Kurla','Mumbai'),(106,'Nike','Kothrud','Pune'),(107,'Nike','Kalyani Nagar','Pune'),(108,'Puma','Ajeet Nagar','Agra');

insert into stores values(111,'ABC','Pune',101),(112,'DEF','Thane',102),(113,'GHI','Pune',101),(114,'JKL','Mumbai',104),(115,'KLM','Pune',107),(116,'NOP','Pune',102),(117,'QRS','Mumbai',105),(118,'TUV','Agra',108);

insert into items values(1001,'Socks',500,2500),(1002,'Shoes',800,3500),(1003,'SweatShirt',300,1400),(1004,'Slides',350,1900),(1005,'Shorts',150,1500),(1006,'Watch',325,4500),(1007,'T-Shirt',200,1200);

insert into customers values(1,'Harshit','Viman Nagar','Pune'),(2,'Mr.Patil','Kurla','Mumbai'),(3,'Sam','Ajeet Nagar','Agra'),(4,'Sakshi','Kalyani Nagar','Pune'),(5,'Aditi','Viman Nagar','Pune'),(6,'Ali','Dadar','Mumbai');

insert into orders values(901,'2018-01-12',1),(902,'2019-05-25',1),(903,'2020-12-20',3),(904,'2018-11-30',5),(905,'2020-10-05',6),(906,'2019-12-29',2),(907,'2021-02-14',4),(908,'2018-09-19',5),(909,'2021-01-23',5);

insert into item_order values(1001,901,24),(1002,902,15),(1003,903,10),(1004,905,35),(1005,907,12),(1006,909,50),(1007,904,21),(1003,902,19),(1005,906,24),(1001,908,36),(1007,901,39),(1002,904,44);

insert into store_item values(111,1001),(112,1007),(114,1003),(115,1002),(116,1006),(118,1002),(117,1004),(115,1005),(113,1007); 



select * from store_item;
select * from item_order;
select * from orders;
select * from stores;
select * from customers;
select * from items;
select * from warehouses;
select * from cities;

#Q1 
select * from items where weight = (select min(weight) from items);

#Q2 
select * from warehouses where wid in (select distinct(wid) from warehouses where city = 'Pune');

#Q3
select * from items where ino in (select ino from item_order where ono in (select ono from orders where cno = (select cno from customers where cname = 'Mr.Patil')));

# Q4
select * from warehouses where wid in(select wid from(select wid,count(*) as count from stores group by wid) temp where count=(select max(count) from(select count(*) as count from stores group by wid) temp));

# Q5
select * from items where ino in(select ino from (select ino,count(*) as count from item_order group by ino) temp where count=(select min(count) from (select count(*) as count from item_order group by ino) temp));