--ISA Method B1, overlapping
--One relation for all
drop table Person cascade constraint;

create table Person (
	PID number(3),
	fullName varchar2(30),
	DoB date,
	constraint Person_pk primary key (PID)
);
	
insert into Person values(100, 'John Doe', '01-Jan-1970', 3.8, null);
insert into Person values(101, 'Jane Smith', '24-Sep-1988', null, 75000);
insert into Person values(102, 'Mary Jones', '11-Nov-1953', 2.3, 85000);

--Note the overlapping StudentEmployee with PID=102



in class :
--ISA Method B1, overlapping
--One relation for all
drop table Person cascade constraints;

create table Person (
	PID number(3),
    Role varchar2(10),
	fullName varchar2(30),
	DoB date,
    GPA number(2,1), 
    Salary number(6),
	constraint Person_pk primary key (PID), 
    constraint Person_UQ unique (PID, Role), 
    constraint PersonRoleVal check (Role in ('Student', 'Employee'))
);
	
insert into Person values(100, 'Student', 'John Doe', '01-Jan-1970', 3.8, null);
insert into Person values(101, 'Employee', 'Jane Smith', '24-Sep-1988', null, 75000);
insert into Person values(102, 'Student', 'Mary Jones', '11-Nov-1953', 2.3, 85000);

--Note the overlapping StudentEmployee with PID=102
select * 
from Person; 