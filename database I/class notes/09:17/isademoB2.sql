--ISA Method B2, disjoint
--One relation for all with Role

--Triggers are necessary to enforce disjoint based on the Role
--Depending on the Role, certain attributes are changed  to null
--if they are not already

drop table Person cascade constraint;

create table Person (
	PID number(3),
	fullName varchar2(30),
	DoB date,
	GPA number(2,1),
	Salary number(6),
	constraint Person_pk primary key (PID)
);

insert into Person values(100, 'Student', 'John Doe', '01-Jan-1970', 3.8, null);
insert into Person values(101, 'Employee', 'Jane Smith', '24-Sep-1988', null, 75000);
insert into Person values(102, 'Student', 'Mary Jones', '11-Nov-1953', 2.3, 85000);

select *
from Person;