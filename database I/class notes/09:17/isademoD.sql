--ISA Method D
--Relations only for every entity combination
--Create triggers to make sure the PID does not exist in the other tables

--Note: a simpler solution without triggers is to use ISA Method A2 with 
--      a Person table that has just a PID and Role

drop table Student cascade constraint;
drop table Employee cascade constraint;
drop table StudentEmployee cascade constraint;

create table Student (
	PID number(3),
	fullName varchar2(30),
	DoB date,
	GPA number(2,1),
	constraint Student_pk primary key (PID)
);
insert into Student values(100, 'John Doe', '01-Jan-1970', 3.8);

create table Employee (
	PID number(3),
	fullName varchar2(30),
	DoB date,
	Salary number(6),
	constraint Employee_pk primary key (PID),
	constraint Employee_fk foreign key (PID) references Person (PID)
);
insert into Employee values(101, 'Jane Smith', '24-Sep-1988', 75000);

create table StudentEmployee (
	PID number(3),
	fullName varchar2(30),
	DoB date,
	GPA number(2,1),
	Salary number(6),
	constraint StudentEmployee_pk primary key (PID)
);
insert into StudentEmployee values(102, 'Mary Jones', '11-Nov-1953', 2.3, 85000);

--Note the overlapping StudentEmployee
select * from student;
select * from employee;
select * from studentemployee;
