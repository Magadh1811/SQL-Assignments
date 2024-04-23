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

/*Function to accept project name as input and returns the number of employees working on the project*/
drop function if exists no_of_employees;
delimiter $$
create function no_of_employees(pname char(30)) returns int
deterministic
begin
    declare count int;
     select count(*) into count from project_employee where pno=(select pno from project where p_name=pname);
     return count;
end
$$
delimiter ;
select no_of_employees("System");

/*Function to find number of employees whose date of joining is before '03/10/2010'*/
drop function if exists no_of_employees_2;
delimiter $$
create function no_of_employees_2() returns int
deterministic
begin
    declare count int;
     select count(*) from employee where datediff(joindate,'2010/10/03')<0 into count;
     return count;
end
$$
delimiter ;
select no_of_employees_2();