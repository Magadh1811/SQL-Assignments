use magadh;

drop table if exists p_e;
drop table if exists pro;
drop table if exists emp;

create table pro(pno int primary key,pname char(20),ptype char(20),duration int);
create table emp(eno int primary key,ename char(20),qualification char(15),jdate date);
create table p_e(pno int , foreign key(pno) references pro(pno),eno int, foreign key(eno) references emp(eno),sdate date,nohourswork int);

desc pro;
desc emp;
desc p_e;

insert into pro values(101,'System','CS',3),(102,'Robotics','AI',4),(103,'Automation','AI',8),(104,'System','CS',1),(105,'Robotics','AI',2),(106,'Codec','CS',10);
insert into emp values(5501,'Harshit','Data Eng','2015-09-19'),(5502,'Magadh','Automation Eng','2016-12-27'),(5503,'Sam','ML Eng','2015-01-10'),(5504,'Sakshi','CSE','2014-05-25'),(5505,'Ali','DL Eng','2015-11-16'),(5506,'Rohit','FSWD','2014-09-29');
insert into p_e values(101,5501,'2018-12-10',8),(102,5502,'2021-11-09',7),(103,5503,'2016-10-19',3),(104,5504,'2015-08-29',8),(105,5505,'2017-09-01',9),(106,5506,'2016-12-25',7);

select * from pro;
select * from emp;
select * from p_e;

/* Find the names of the employees staring with 'A' */
select ename from emp where ename like 'A%'; 

/* Find the details of employees working on the project 'System' */
select * from emp where eno in(select eno from p_e where pno in(select pno from pro where pname='System'));

/* Find the employee no of employees who do not work on project 'Robotics' */
select eno from emp where eno in(select eno from p_e where pno in(select pno from pro where pname!='Robotics'));

/* List the names of the first three employees in aplhabetical order */
select ename from emp order by ename limit 3;

/* Find the names of the employees who have worked for more than 3 years */
select ename from emp,p_e where emp.eno=p_e.eno and datediff(curdate(),sdate)>(365*3);