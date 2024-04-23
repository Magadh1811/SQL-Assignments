use magadh;
drop if exists person,area;
create table area(aname varchar(20) primary key,area_type varchar(20), constraint check(area_type in('rural','urban')));

create table person(pnumber int primary key,pname varchar(20),birthdate date,income int,aname varchar(20),foreign key(aname) references area(aname));

insert into area values('Gangapur Road','Urban'),('Peth Road','Urban'),('Main Road','Rural'),('Trimbak Road','Rural'),('Nashik Road','Urban'),('Cannal Road','Rural');

insert into person values(111,'Gaku','2001-01-23',50000.00,'Trimbak Road'),(112,'Pikasa','1996-12-2',20000.00,'Gangapur Road'),
(113,'Tanjiro','2000-05-10',30000.00,'Main Road'),(114,'Naruto','1995-11-26',40000,'Main Road'),
(115,'Inosuke','1999-08-19',10000,'Nashik Road'),(116,'Sasuke','2012-01-06',30000,'Trimbak Road'),
(117,'Zenitsu','2001-02-14',40000,'Cannal Road'),(118,'Luffy','2000-03-16',10000,'Nashik Road'),
(119,'Nezuko','1998-12-31',10000,'Peth Road');

select * from area;

select * from person;

/*Q1 Names of people living in Gangapur Road */
select pname from person where aname='Gangapur Road';

/*Q2 Details of person having name start with letter 'a' */
select * from person where lower(pname) like 'a%';

/*Q3 Names of people having birthday in March */
select pname from person where month(birthdate)=3;

/*Q4 Count the people born on '2012-01-06' */
select count(*) from person where birthdate='2000-03-16';

/*Q5 Count people whose income < 50000 */
select count(*) from person where income<50000;

/*Q6 Names of people whose income bw 25000 and 75000 */
select pname from person where income between 25000 and 75000;

/*Q7 List people by names */
select * from person order by pname;

/*Q8 Tranfer people from Pune to Mumbai */
update person set aname='Mumbai' where aname='Pune';

select * from person;
select * from area;

/*Q9 Delete info of people liviing in 'Urban' areas */
delete from person where aname in(select aname from area where area_type='Urban');

select * from person;
select * from area;