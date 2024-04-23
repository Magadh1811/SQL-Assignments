drop database if exists d_p_m;

create database d_p_m;

use d_p_m;

drop table if exists doctor;
drop table if exists patients;
drop table if exists medicine;
drop table if exists buys;

create table doctor(doc_id int primary key, name char(25), phno int, address char(50));
create table patients(patient_id int primary key, pname char(25), phno int, doc_id int, foreign key(doc_id) references doctor(doc_id));
create table medicine(medname char(50) primary key, quantity int, price decimal(8,2));
create table buys(patient_id int, foreign key(patient_id) references patients(patient_id), medname char(50), foreign key(medname) references medicine(medname));

desc doctor;
desc patients;
desc medicine;
desc buys;

insert into doctor values(101,'Dr.Harshit',102,'Viman Nagar');
insert into doctor values(102,'Dr.Shameek',100,'FC Road');
insert into doctor values(103,'Dr.Sakshi',109,'Karve Nagar');

insert into patients values(10,'Magadh',9932,103);
insert into patients values(11,'Samruddhi',8765,101);
insert into patients values(12,'Ali',9156,102);

insert into medicine values('Paracetamol',10,10.23);
insert into medicine values('Dolo',5,20.56);
insert into medicine values('Disprine',7,5.69);

insert into buys values(10,'Paracetamol');
insert into buys values(11,'Dolo');
insert into buys values(12,'Disprine');
insert into buys values(10,'Disprine');
insert into buys values(11,'Paracetamol');
insert into buys values(12,'Dolo');

select * from doctor;
select * from patients;
select * from medicine;
select * from buys;

# Simple Queries
# 01 : Patient treated by doctor of viman Nagar

select pname from patients where doc_id in (select doc_id from doctor where address='Viman Nagar');


# 02 : Patient buys paracetamol medicine 

select pname from patients where patient_id in (select patient_id from buys where medname='Paracetamol');


# Join Queries
# 01 : Paintent info with doctor

select p.pname, d.name from patients p left join doctor d on p.doc_id=d.doc_id;


# 02 : Paintent buys medicines

select p.pname, m.medname from patients p left join buys b on p.patient_id=b.patient_id left join medicine m on m.medname=b.medname;


# View Queries
# 01 : Doctor detail of Karve nagar

create or replace view doctor_fcroad as select * from doctor where address='Karve Nagar';
select * from doctor_fcroad;


# Stored Function
# 01 : list the Patient who takes paracetamol

drop function no_of_patient;

delimiter $$
create function no_of_patient(pc varchar(30)) returns int
deterministic
begin 
      declare count int;
          select count(*) from patients where patient_id in (select patient_id from buys where medname=pc) into count;
          return count;
end
$$
delimiter ;
select no_of_patient('Paracetamol');
          

