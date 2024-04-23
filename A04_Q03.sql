drop database if exists Warehouse;

create database Warehouse;

use Warehouse;

drop table if exists stores_items;
drop table if exists items_orders;
drop table if exists items;
drop table if exists orders;
drop table if exists stores;
drop table if exists customer;
drop table if exists warehouses;
drop table if exists cities;

create table cities(city char(20) primary key, state char(20));
create table warehouses(wid int primary key, wname char(20), location char(20), city char(20), foreign key(city) references cities(city));
create table stores(sid int primary key, store_name char(20), location_city char(20), wid int, foreign key(wid) references warehouses(wid));
create table items(itemno int primary key, description text, weight numeric(5,2), cost numeric(5,2));
create table customer(cno int primary key, cname char(50), addr varchar(50), cu_city char(20));
create table orders(ono int primary key, odate date, cno int, foreign key(cno) references customer(cno));
create table items_orders(itemno int, foreign key(itemno) references items(itemno), ono int, foreign key(ono) references orders(ono), orderes_quantity int);
create table stores_items(sid int, foreign key(sid) references stores(sid), itemno int, foreign key(itemno) references items(itemno), quantity int);

desc cities;
desc warehouses;
desc stores;
desc items;
desc customer;
desc orders;
desc items_orders;
desc stores_items;

insert into cities values("Pune","Maharashtra");
insert into cities values("Mumbai","Maharashtra");
insert into cities values("Kolkata","West Bengal");
insert into cities values("Chennai","Tamil Nadu");
insert into cities values("Hyderabad","Telangana");
insert into cities values("Jaipur","Rajasthan");

select * from cities;

insert into warehouses values(101,"Aditya Birla","Rangareddy","Hyderabad");
insert into warehouses values(102,"Nike","SB Road","Pune");
insert into warehouses values(103,"Nestle","Dharavi","Mumbai");
insert into warehouses values(104,"Spares","FC Road","Pune");
insert into warehouses values(105,"Shreeleathers","Esplanade","Kolkata");
insert into warehouses values(106,"Adidas","Kokampet","Hyderabad");

select * from warehouses;

insert into stores values(11,"Sitara Stores","Hyderabad",101);
insert into stores values(12,"Raju Bhandar","Pune",104);
insert into stores values(13,"Elite Sports Shop","Pune",102);
insert into stores values(14,"Sneha Nirlata","Kolkata",105);
insert into stores values(15,"Jagannath Clothings","Hyderabad",101);
insert into stores values(16,"Laxman Stores","Mumbai",103);
insert into stores values(17,"Adidasa Access","Hyderabad",106);
insert into stores values(18,"Ram Bhandar","Pune",104);

select * from stores;

insert into items values(1,"Sneakers White",1.3,999);
insert into items values(2,"Maggi Family Pack",0.5,70);
insert into items values(3,"Checked Blue Shirt",0.2,500);
insert into items values(4,"Soan Papdi",1,200);
insert into items values(5,"Brown Office Shoes",0.9,450);
insert into items values(6,"Amul Taza",1,89);

select * from items;

insert into customer values(1,"Mr. A","68/A, Ramstu, FC Road, Pune-411004","Pune");
insert into customer values(2,"Mr. Saha","37/A, HB Town, Sodepur, Kol-700110","Kolkata");
insert into customer values(3,"Mrs. Singh","34/A, Swarg, Aundh, Pune-411007","Pune");
insert into customer values(4,"Mr. Reddy","93/B, Matru, Cybercity, Hyderabad-611038","Hyderabad");
insert into customer values(5,"Mrs. Raj","62/C, Ramstu, JM Road, Pune-400078","Pune");
insert into customer values(6,"Mr. Bhowmick","37/D, BT Road, Kolkata-700090","Kolkata");

select * from customer;

insert into orders values(1,'2015-10-10',1);
insert into orders values(2,'2022-04-26',2);
insert into orders values(3,'2022-01-01',1);
insert into orders values(4,'2022-11-12',5);
insert into orders values(5,'2022-10-31',3);
insert into orders values(6,'2022-03-24',4);
insert into orders values(7,'2022-07-16',6);
insert into orders values(8,'2022-06-15',1);

select * from orders;

insert into items_orders values(1,1,1);
insert into items_orders values(2,3,5);
insert into items_orders values(1,7,2);
insert into items_orders values(3,8,3);
insert into items_orders values(5,6,1);
insert into items_orders values(6,5,2);
insert into items_orders values(4,4,2);

select * from items_orders;

insert into stores_items values(11,3,20);
insert into stores_items values(12,6,40);
insert into stores_items values(13,1,5);
insert into stores_items values(14,5,10);
insert into stores_items values(15,3,15);
insert into stores_items values(18,6,25);

select * from stores_items;

drop view if exists stores_Spares;
drop view if exists customer_detail;

/*Create view containing details of all stores of a Warehouse named 'Spares'*/
create view stores_Spares as select * from stores where wid=(select wid from warehouses where wname="Spares");
select * from stores_Spares;

/*Create view to list details of all customers who placed orders on 10-10-2015*/
create view customer_detail as select c.cno,c.cname, c.addr, c.cu_city,o.ono,o.odate from customer as c,orders as o where c.cno=o.cno and day(odate)=10 and month(odate)=10 and year(odate)=2015;
select * from customer_detail;

/*List of names of stores of Spares located in Pune*/
select store_name from stores_Spares where location_city="Pune";

/*List the names of customers from Pune City who have placed orders on 10-10-2015*/
select cname from customer_detail where cu_city="Pune";

/*List the orders placed by Mr.A*/
select ono from customer_detail where cname="Mr. A";