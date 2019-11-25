/* Emily Hao */
/* CS3431 */
/* Assignment 2 */

/* drop tables */

drop table Reservations;
drop sequence reservationID_seq; 
drop table Cruises;
drop sequence cruiseID_seq; 
drop table Ships; 
drop table TravelAgents;
drop sequence travelAgentID_seq; 
drop table Company;
drop table Customers;
drop sequence customerID_seq; 

/* create tables */
CREATE TABLE Ships (
	shipName varchar2(25),
	rating number(2,1),
	yearBuilt number(4),
	shipType varchar2(25),
	tipsPerDay number (5,2),
	Constraint Ships_PK Primary Key (shipName),
	Constraint ShipsType_Check Check (shipType IN ('Small', 'Mid-sized', 'Large', 'Mega Ship')),
	Constraint rating_check Check (rating Between 1 and 6),
	Constraint rating_check2 Check ( rating = trunc(rating) Or rating Like '%.5'),
	Constraint yearBuilt_check Check (yearBuilt >= 1822));

CREATE TABLE Customers (
   customerID number,
   firstName varchar2(15),
   lastName varchar2(20),
   address varchar2(30),
   phone number(10),
   age number(3), 
   Constraint Customers_PK Primary Key (customerID),
   Constraint Customers_UK Unique (firstName,lastName));
   

create sequence customerID_seq
start with 1
increment by 1; 

CREATE TABLE Company (
  companyName varchar2(25), 
  phone char(10), 
  website varchar2(40), 
  Constraint Companies_PK Primary Key (companyName),
  Constraint Companies_UK Unique (phone),
  Constraint Companies_NotNull check (phone IS NOT NULL));

CREATE TABLE TravelAgents (
  travelAgentID number,
  firstName varchar2(15),
  lastName varchar2(20),
  title varchar2(15),
  salary number(7,2),
  Constraint TravelAgents_PK Primary Key (travelAgentID),
  Constraint check_title Check (title IN ('Agent', 'Junior Agent', 'Senior Agent')),
  Constraint TravelAgents_UK Unique (firstName, lastName)); 

create sequence travelAgentID_seq
start with 1
increment by 1;


CREATE TABLE Cruises (
    cruiseID number,
    cruiseName varchar2(25),
    departurePort varchar2(25),
    days number(3),
    companyName varchar2(25),
    shipName varchar2(25),
    Constraint Cruises_PK Primary Key (cruiseID),
    Constraint CompanyName_FK Foreign Key (companyName) References Company(companyName) On Delete Cascade,
    Constraint shipName_FK Foreign Key (shipName) References Ships(shipName) On Delete Cascade);

create sequence cruiseID_seq
start with 1
increment by 1;

CREATE TABLE Reservations (
    reservationID number,
    customerID number,
    cruiseID number,
    travelAgentID number,
    travelDate date,
    paymentDeadline date,
    price number(8,2),
    Constraint Reservations_PK Primary Key (reservationID),
    Constraint Customer_FK Foreign Key (customerID) References Customers(customerID) On Delete Set Null,
    Constraint cruise_FK Foreign Key (cruiseID) References Cruises(cruiseID) On Delete Set Null,
    Constraint travelAgent_FK Foreign Key (travelAgentID) References TravelAgents(travelAgentID) On Delete Set Null);

create sequence reservationID_seq
start with 1
increment by 1;


/*create a high level summary of the database schema */

/* insert tables */
insert into Ships values ('Norwegian Gem',4, 2007, 'Mid-sized', 14.5);
insert into Ships values ('Norwegian Dawn',3.5, 2002, 'Small', 14.5);
insert into Ships values ('Equinox',5.5, 2018, 'Mega Ship', 17.25);
insert into Ships values ('Grand Princess',4.5, 1996, 'Large', 13.5);

insert into Company values ('Celebrity', '8887517804', 'http://www.celebritycruises.com');
insert into Company values ('NCL', '8662347350', 'http://www.ncl.com');
insert into Company values ('Princess', '8007746237', 'http://www.princess.com');
insert into Company values ('Carnival', '8007647419', 'http://www.carnival.com');

insert into Customers values (customerID_seq.nextval, 'Michael', 'Davis', '8711 Meadow St.', 2497873464, 67);
insert into Customers values (customerID_seq.nextval, 'Lisa', 'Ward', '17 Valley Drive', 9865553232, 20);
insert into Customers values (customerID_seq.nextval, 'Brian', 'Gray', '1212 8th St.', 4546667821, 29);
insert into Customers values (customerID_seq.nextval, 'Nicole', 'Myers', '9 Washington Court', 9864752346, 18);
insert into Customers values (customerID_seq.nextval, 'Kelly', 'Ross', '98 Lake Hill Drive', 8946557732, 26);
insert into Customers values (customerID_seq.nextval, 'Madison', 'Powell', '100 Main St.', 8915367188, 57);
insert into Customers values (customerID_seq.nextval, 'Ashley', 'Martin', '42 Oak St.', 1233753684, 73);
insert into Customers values (customerID_seq.nextval, 'Joshua', 'White', '1414 Cedar St.', 6428369619, 18);
insert into Customers values (customerID_seq.nextval, 'Tyler', 'Clark', '42 Elm Place', 1946825344, 22);
insert into Customers values (customerID_seq.nextval, 'Anna', 'Young', '657 Redondo Ave.', 7988641411, 25);
insert into Customers values (customerID_seq.nextval, 'Justin', 'Powell', '5 Jefferson Ave.', 2324648888, 17);
insert into Customers values (customerID_seq.nextval, 'Bruce', 'Allen', '143 Cambridge Ave.', 5082328798, 45);
insert into Customers values (customerID_seq.nextval, 'Rachel', 'Sanchez', '77 Massachusetts Ave.', 6174153059, 68);
insert into Customers values (customerID_seq.nextval, 'Dylan', 'Lee', '175 Forest St.', 2123043923, 19);
insert into Customers values (customerID_seq.nextval, 'Austin', 'Garcia', '35 Tremont St.', 7818914567, 82);

insert into Cruises values (cruiseID_seq.nextval, 'Bermuda', 'Boston', 7, 'NCL', 'Norwegian Gem');
insert into Cruises values (cruiseID_seq.nextval, 'New England', 'New York', 7, 'NCL', 'Norwegian Dawn');
insert into Cruises values (cruiseID_seq.nextval, 'Western Caribbean', 'Miami', 4, 'Celebrity', 'Equinox');
insert into Cruises values (cruiseID_seq.nextval, 'Alaska', 'San Francisco', 10, 'Princess', 'Grand Princess');

insert into TravelAgents values (travelAgentID_seq.nextval, 'Emily', 'Williams', 'Senior Agent', 54000.5);
insert into TravelAgents values (travelAgentID_seq.nextval, 'Ethan', 'Brown', 'Junior Agent', 30500.75);
insert into TravelAgents values (travelAgentID_seq.nextval, 'Chloe', 'Jones', 'Senior Agent', 27044.52);
insert into TravelAgents values (travelAgentID_seq.nextval, 'Ben', 'Miller', 'Junior Agent', 32080.9);
insert into TravelAgents values (travelAgentID_seq.nextval, 'Mia', 'Davis', 'Agent', 49000);
insert into TravelAgents values (travelAgentID_seq.nextval, 'Noah', 'Garcia', 'Agent', 22000.5);
insert into TravelAgents values (travelAgentID_seq.nextval, 'Liam', 'Rodriguez', 'Junior Agent', 31750);
insert into TravelAgents values (travelAgentID_seq.nextval, 'Mason', 'Wilson', 'Senior Agent', 45000);
insert into TravelAgents values (travelAgentID_seq.nextval, 'Olivia', 'Smith', 'Junior Agent', 25025.95);
insert into TravelAgents values (travelAgentID_seq.nextval, 'Sofia', 'Johnson', 'Agent', 47000.22);
insert into TravelAgents values (travelAgentID_seq.nextval, 'Jason', 'Elm', 'Junior Agent', 25250);

insert into Reservations values (reservationID_seq.nextval, 5, 1, 2,  '17-May-19' , null, 599);
insert into Reservations values (reservationID_seq.nextval, 8, 4, 5,  '11-Apr-19' , null, 1240.55);
insert into Reservations values (reservationID_seq.nextval, 15, 4, 1,  '6-Feb-19' , null, 1305.73);
insert into Reservations values (reservationID_seq.nextval, 4, 4, 4,  '31-Aug-19' , null, 800.15);
insert into Reservations values (reservationID_seq.nextval, 6, 1, 2,  '10-Apr-19' , null, 499.25);
insert into Reservations values (reservationID_seq.nextval, 14, 4, 6,  '29-Jul-18' , null, 800.15);
insert into Reservations values (reservationID_seq.nextval, 11, 2, 2,  '15-Mar-19' , null, 475.25);
insert into Reservations values (reservationID_seq.nextval, 7, 1, 10,  '28-Feb-19' , null, 799.95);
insert into Reservations values (reservationID_seq.nextval, 14, 3, 3,  '3-Jun-18' , null, 336.42);
insert into Reservations values (reservationID_seq.nextval, 12, 3, 9,  '15-Oct-18' , null, 271.89);
insert into Reservations values (reservationID_seq.nextval, 14, 2, 7,  '8-Mar-19' , null, 525.5);
insert into Reservations values (reservationID_seq.nextval, 5, 4, 7,  '24-Nov-18' , null, 1516.86);
insert into Reservations values (reservationID_seq.nextval, 9, 1, 1,  '3-Aug-19' , null, 799.95);
insert into Reservations values (reservationID_seq.nextval, 13, 1, 10,  '13-Dec-18' , null, 999);
insert into Reservations values (reservationID_seq.nextval, 5, 3, 7,  '9-Nov-18' , null, 160);
insert into Reservations values (reservationID_seq.nextval, 2, 4, 5,  '21-Jan-19' , null, 1616.42);
insert into Reservations values (reservationID_seq.nextval, 4, 2, 8,  '11-Dec-18' , null, 1225.4);
insert into Reservations values (reservationID_seq.nextval, 10, 3, 9,  '12-Aug-19' , null, 301.01);
insert into Reservations values (reservationID_seq.nextval, 5, 4, 8,  '22-Jun-19' , null, 1231);
insert into Reservations values (reservationID_seq.nextval, 1, 4, 3,  '1-Feb-19' , null, 1305.73);

/* Question a*/ 
update Reservations 
Set paymentDeadline = ( case 
	when travelDate > (Sysdate + 90)
	then travelDate - 90
	when travelDate - Sysdate <= 90 And travelDate - Sysdate >= 0
	then Sysdate
	end
); 

/*Question b*/
select cruiseName, departurePort, days, shipName 
from Cruises 
Where (days < 10 And shipName in (select shipName
		from Ships
		Where  (rating >= 4 And shipName like 'Norwegian%')
)); 

/* Question c */
select firstName ||' '|| lastName As FullName, sum (tipsPerDay* days + price) as totalPrice
from TravelAgents
Left outer join Reservations
on TravelAgents.travelAgentID = Reservations.travelAgentID
Left outer join Cruises
on Cruises.cruiseID = Reservations.cruiseID
Left outer join Ships
on Ships.shipName = Cruises.shipName
group by rollup (firstName, lastName)
having (lastName is not null) or (firstName is null)
order by firstName, lastName;  

/* question d*/
select firstName, lastName, sum(price)
from Reservations left outer join TravelAgents
on Reservations.travelAgentID = TravelAgents.travelAgentID
group by firstName, lastName
having sum(price) in (select max(sum(price)) from Reservations group by travelAgentID);

