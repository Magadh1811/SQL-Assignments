drop database if exists Project_Employee;

create database Project_Employee;

use Project_Employee;

drop table if exists project_employee;
drop table if exists project;
drop table if exists employee;

create table project(pno int primary key, p_name char(30), ptype char(20),duration int);
create table employee(eno int primary key, e_name char(20), qualification char(15), joindate date);

desc project;
desc employee;

create table project_employee(pno int, foreign key(pno) references project(pno), eno int, foreign key(eno) references employee(eno), start_date date, no_of_hours_worked int);

desc project_employee;

insert into project values(1,'System','group',20);
insert into project values(2,'Robotics','individual',10);
insert into project values(3,'Data Analysis','group',30);
insert into project values(4,'Hypothesis Testing','individual',15);

select * from project;

insert into employee values(1,'Pratik','bcom','2019-01-06');
insert into employee values(2,'Ankit','Engineer','2022-04-26');
insert into employee values(3,'Sanjana','msc','2021-03-09');
insert into employee values(4,'Kritika','Engineer','2018-12-18');
insert into employee values(5,'Ram','mcom','2019-11-14');
insert into employee values(6,'Alexia','msc','2009-10-14');

select * from employee;

insert into project_employee values(1,1,'2021-01-06',11);
insert into project_employee values(1,4,'2021-11-16',9);
insert into project_employee values(2,2,'2022-05-07',10);
insert into project_employee values(3,3,'2021-10-15',16);
insert into project_employee values(3,6,'2021-10-15',14);
insert into project_employee values(4,5,'2018-04-01',15);

select * from project_employee;

drop view if exists employee_detail;
drop view if exists project_detail;

/*Create view over employee with only employee name and qualification sorted by qualification*/
create view employee_detail as select e_name,qualification from employee order by qualification;
select * from employee_detail;

/*Create view containing project name, project type and start date of the project and should be sorted by start date of project*/
create view project_detail as select p_name,ptype,start_date from project p, project_employee pe where p.pno=pe.pno order by start_date;
select * from project_detail;

/*List of different qualifications of employees*/
select qualification from employee_detail group by qualification;
/*select distinct qualification from employee_detail;*/

/*List the name and type of projects started on 1st April 2018*/
select p_name,ptype from project_detail where day(start_date)=1 and monthname(start_date)="April" and year(start_date)=2018;
/* select p_name,ptype from project_detail where start_date='2018-04-01';*/