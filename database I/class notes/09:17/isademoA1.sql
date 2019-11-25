--ISA Method A1, overlapping
--Relation for each entity set
drop table Person cascade constraint;
drop table Student cascade constraint;
drop table Employee cascade constraint;

create table Person (
    PID number(3), 
    fullName varchar2(30), 
    DoB date, 
    constraint Person_PK primary key (PID)
);

create table Student (
    PID number(3), 
    GPA number(2,1), 
    constraint Student_PK primary key (PID),
    constraint student_FK foreign key (PID) references Person(PID)
);

create table Employee (

);

insert into Person values(100, 'John Doe', '01-Jan-1970');
insert into Person values(101, 'Jane Smith', '24-Sep-1988');
insert into Person values(102, 'Mary Jones', '11-Nov-1953');

insert into Student values(100, 3.8);
insert into Student values(102, 2.3);

insert into Employee values(101, 75000);
insert into Employee values(102, 85000); 

--Note the overlapping StudentEmployee

select * from 
Person join Student 
on Person.PID = Student.PID
join Employee 
on Employee.PID = Person.PID; 