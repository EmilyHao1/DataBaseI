--ISA Method C
--Relations only for subentities

--For overlapping, create triggers to make sure the redundant information matches for
--when the same PID exists in both tables

--For disjoint, create triggers to make sure the PID does not exist in the other table
--Note: a simpler solution without triggers is to use ISA Method A2 with 
--      a Person table that has just a PID and Role

drop table Student cascade constraint;
drop table Employee cascade constraint;

create table Student (
	PID number(3),
	fullName varchar2(30),
	DoB date,
	GPA number(2,1),
	constraint Student_pk primary key (PID)
);
insert into Student values(100, 'John Doe', '01-Jan-1970', 3.8);
insert into Student values(102, 'Mary Jones', '11-Nov-1953', 2.3);
insert into Student values(104, 'Sarah Watts', '23-Apr-1991', 3.6);
insert into Student values(106, 'Chris Spencer', '05-Aug-1997', 3.3);


create table Employee (
	PID number(3),
	fullName varchar2(30),
	DoB date,
	Salary number(6),
	constraint Employee_pk primary key (PID)
);
insert into Employee values(101, 'Jane Smith', '24-Sep-1988', 75000);
insert into Employee values(102, 'Mary Jones', '11-Nov-1953', 85000); 
insert into Employee values(103, 'Paul Harris', '04-Jul-1979', 52000);
insert into Employee values(104, 'Sarah Watts', '23-Apr-1991', 34000);
insert into Employee values(105, 'Jane Smith', '17-Sep-1993', 76000);

--Note the overlapping StudentEmployee
