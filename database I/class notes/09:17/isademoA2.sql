--ISA Method A2, disjoint 
--Relation for each entity set, Role to enforce disjoint
drop table Person cascade constraint;
drop table Student cascade constraint;
drop table Employee cascade constraint;

create table Person (
	PID number(3),
	fullName varchar2(30),
	DoB date,
	constraint Person_pk primary key (PID),
);

create table Student (
	PID number(3),
	GPA number(2,1),
	constraint Student_pk primary key (PID)
);

create table Employee (
	PID number(3),
	Salary number(6),
	constraint Employee_pk primary key (PID)
);
	
insert into Person values(100, 'Student', 'John Doe', '01-Jan-1970');
insert into Person values(101, 'Employee', 'Jane Smith', '24-Sep-1988');
insert into Person values(102, 'Student', 'Mary Jones', '11-Nov-1953');

-- Error: Overlapping is not possible
insert into Person values(102, 'Employee', 'Mary Jones', '11-Nov-1953');

insert into Student values(100, 'Student', 3.8);
insert into Student values(102, 'Student', 2.3);

insert into Employee values(101, 'Employee', 75000);

-- Note the error - disjoint enforced
insert into Employee values(102, 'Employee', 85000); 

select * 
from person P join student S
 on P.pid = S.pid;

select * 
from person P join employee E
  on P.pid = E.pid;


