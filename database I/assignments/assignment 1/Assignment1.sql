/* Emily Hao */
/* CS3431 */
/* Assignment 1 */

/* drop tables */

drop table Reservations;
drop sequence reservationID_seq; 
drop table Cruises;
drop sequence cruiseID_seq; 
drop table TravelAgents;
drop sequence travelAgentID_seq; 
drop table Company;
drop table Customers;
drop sequence customerID_seq; 

/* create tables */
CREATE TABLE Customers (
   customerID number,
   firstName varchar2(15),
   lastName varchar2(20),
   address varchar2(30),
   phone number,
   age number, 
   Constraint Customers_PK Primary Key (customerID)
);

create sequence customerID_seq
start with 1
increment by 1; 

CREATE TABLE Company (
  companyName varchar2(25), 
  phone char(10), 
  website varchar2(40), 
  Constraint Companies_PK Primary Key (companyName),
  Constraint Companies_UK Unique (phone),
  Constraint Companies_NotNull check (phone IS NOT NULL)
);

CREATE TABLE TravelAgents (
  travelAgentID number,
  firstName varchar2(15),
  lastName varchar2(20),
  title varchar2(15),
  salary number(7,2),
  Constraint TravelAgents_PK Primary Key (travelAgentID),
  Constraint check_title Check (title IN ('Agent', 'Junior Agent', 'Senior Agent'))); 

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
    Constraint CompanyName_FK Foreign Key (companyName) References Company(companyName) On Delete Cascade
);

create sequence cruiseID_seq
start with 1
increment by 1;

CREATE TABLE Reservations (
    reservationID number,
    customerID number,
    cruiseID number,
    travelAgentID number,
    travelDate date,
    price number(8,2),
    Constraint Reservations_PK Primary Key (reservationID),
    Constraint Customer_FK Foreign Key (customerID) References Customers(customerID) On Delete Set Null,
    Constraint cruise_FK Foreign Key (cruiseID) References Cruises(cruiseID) On Delete Set Null,
    Constraint travelAgent_FK Foreign Key (travelAgentID) References TravelAgents(travelAgentID) On Delete Set Null
);

create sequence reservationID_seq
start with 1
increment by 1;


/* insert tables */

insert into Customers values(customerID_seq.nextval, 'Michael', 'Davis', '8711 Meadow St.', 2497873464, 67 );
insert into Customers values(customerID_seq.nextval, 'Lisa', 'Ward', '17 Valley Drive', 9865553232, 20 );
insert into Customers values(customerID_seq.nextval, 'Brian', 'Gray', '1212 8th St.', 4546667821, 29 );
insert into Customers values(customerID_seq.nextval, 'Nicole', 'Myers', '9 Washington Court', 9864752346, 18 );
insert into Customers values(customerID_seq.nextval, 'Kelly', 'Ross', '98 Lake Hill Drive', 8946557732, 26 );
insert into Customers values(customerID_seq.nextval, 'Madison', 'Powell', '100 Main St.', 8915367188, 57 );
insert into Customers values(customerID_seq.nextval, 'Ashley', 'Martin', '42 Oak St.', 1233753684, 73 );
insert into Customers values(customerID_seq.nextval, 'Joshua', 'White', '1414 Cedar St.', 6428369619, 18 );
insert into Customers values(customerID_seq.nextval, 'Tyler', 'Clark', '42 Elm Place', 1946825344, 22 );
insert into Customers values(customerID_seq.nextval, 'Anna', 'Young', '657 Redondo Ave.', 7988641411, 25 );
insert into Customers values(customerID_seq.nextval, 'Justin', 'Powell', '5 Jefferson Ave.', 2324648888, 17 );
insert into Customers values(customerID_seq.nextval, 'Bruce', 'Allen', '143 Cambridge Ave.', 5082328798, 45 );
insert into Customers values(customerID_seq.nextval, 'Rachel', 'Sanchez', '77 Massachusetts Ave.', 6174153059, 68 );
insert into Customers values(customerID_seq.nextval, 'Dylan', 'Lee', '175 Forest St.', 2123043923, 19 );
insert into Customers values(customerID_seq.nextval, 'Austin', 'Garcia', '35 Tremont St.', 7818914567, 82 );

insert into Company values('Celebrity', '8887517804', 'http://www.celebritycruises.com');
insert into Company values('NCL', '8662347350', 'http://www.ncl.com');
insert into Company values('Princess', '8007746237', 'http://www.princess.com');
insert into Company values('Carnival', '8007647419', 'http://www.carnival.com');

insert into TravelAgents values(travelAgentID_seq.nextval, 'Emily', 'Williams', 'Senior Agent', 54000.5 );
insert into TravelAgents values(travelAgentID_seq.nextval, 'Ethan', 'Brown', 'Junior Agent', 30500.75 );
insert into TravelAgents values(travelAgentID_seq.nextval, 'Chloe', 'Jones', 'Senior Agent', 27044.52 );
insert into TravelAgents values(travelAgentID_seq.nextval, 'Ben', 'Miller', 'Junior Agent', 32080.9 );
insert into TravelAgents values(travelAgentID_seq.nextval, 'Mia', 'Davis', 'Agent', 49000 );
insert into TravelAgents values(travelAgentID_seq.nextval, 'Noah', 'Garcia', 'Agent', 22000.5 );
insert into TravelAgents values(travelAgentID_seq.nextval, 'Liam', 'Rodriguez', 'Junior Agent', 31750 );
insert into TravelAgents values(travelAgentID_seq.nextval, 'Mason', 'Wilson', 'Senior Agent', 45000 );
insert into TravelAgents values(travelAgentID_seq.nextval, 'Olivia', 'Smith', 'Junior Agent', 25025.95 );
insert into TravelAgents values(travelAgentID_seq.nextval, 'Sofia', 'Johnson', 'Agent', 47000.22 );
insert into TravelAgents values(travelAgentID_seq.nextval, 'Jason', 'Elm', 'Junior Agent', 25250 );


insert into Cruises values( cruiseID_seq.nextval, 'Bermuda', 'Boston', 7, 'NCL', 'Norwegian Gem' );
insert into Cruises values( cruiseID_seq.nextval, 'New England', 'New York', 7, 'NCL', 'Norwegian Dawn' );
insert into Cruises values( cruiseID_seq.nextval, 'Western Caribbean', 'Miami', 4, 'Celebrity', 'Equinox' );
insert into Cruises values( cruiseID_seq.nextval, 'Alaska', 'San Francisco', 10, 'Princess', 'Grand Princess' );


insert into Reservations values(reservationID_seq.nextval, 5, 1, 2,  TO_DATE( '17-May-19' , 'DD-MON-YY'), 599 );
insert into Reservations values(reservationID_seq.nextval, 8, 4, 5,  TO_DATE('11-Apr-19', 'DD-MON-YY'), 1240.55 );
insert into Reservations values(reservationID_seq.nextval, 15, 4, 1,  TO_DATE('6-Feb-19', 'DD-MON-YY'), 1305.73 );
insert into Reservations values(reservationID_seq.nextval, 4, 4, 4,  TO_DATE('31-Aug-19', 'DD-MON-YY'), 800.15 );
insert into Reservations values(reservationID_seq.nextval, 6, 1, 2,  TO_DATE('10-Apr-19', 'DD-MON-YY'), 499.25 );
insert into Reservations values(reservationID_seq.nextval, 14, 4, 6,  TO_DATE('29-Jul-18', 'DD-MON-YY'), 800.15 );
insert into Reservations values(reservationID_seq.nextval, 11, 2, 2,  TO_DATE('15-Mar-19', 'DD-MON-YY'), 475.25 );
insert into Reservations values(reservationID_seq.nextval, 7, 1, 10,  TO_DATE('28-Feb-19', 'DD-MON-YY'), 799.95 );
insert into Reservations values(reservationID_seq.nextval, 14, 3, 3,  TO_DATE('3-Jun-18', 'DD-MON-YY'), 336.42 );
insert into Reservations values(reservationID_seq.nextval, 12, 3, 9,  TO_DATE('15-Oct-18', 'DD-MON-YY'), 271.89 );
insert into Reservations values(reservationID_seq.nextval, 14, 2, 7,  TO_DATE('8-Mar-19', 'DD-MON-YY'), 525.5 );
insert into Reservations values(reservationID_seq.nextval, 5, 4, 7,  TO_DATE('24-Nov-18', 'DD-MON-YY'), 1516.86 );
insert into Reservations values(reservationID_seq.nextval, 9, 1, 1,  TO_DATE('3-Aug-19', 'DD-MON-YY'), 799.95 );
insert into Reservations values(reservationID_seq.nextval, 13, 1, 10,  TO_DATE('13-Dec-18', 'DD-MON-YY'), 999 );
insert into Reservations values(reservationID_seq.nextval, 5, 3, 7,  TO_DATE('9-Nov-18', 'DD-MON-YY'), 160 );
insert into Reservations values(reservationID_seq.nextval, 2, 4, 5,  TO_DATE('21-Jan-19', 'DD-MON-YY'), 1616.42 );
insert into Reservations values(reservationID_seq.nextval, 4, 2, 8,  TO_DATE('11-Dec-18', 'DD-MON-YY'), 1225.4 );
insert into Reservations values(reservationID_seq.nextval, 10, 3, 9,  TO_DATE('12-Aug-19', 'DD-MON-YY'), 301.01 );
insert into Reservations values(reservationID_seq.nextval, 5, 4, 8,  TO_DATE('22-Jun-19', 'DD-MON-YY'), 1231 );
insert into Reservations values(reservationID_seq.nextval, 1, 4, 3,  TO_DATE('1-Feb-19', 'DD-MON-YY'), 1305.73 );

/* write SQL commands */

/* Question a */
Update Reservations
Set price = price - price * 0.1
Where travelDate > '01-Jan-19';

/* Question b */

Select Distinct firstName, lastName
From Cruises NATURAL JOIN Reservations NATURAL JOIN Customers
Where departurePort = 'San Francisco' Or price < 300
Order By lastName, firstName;


/* Question c */

Select Reservations.travelDate, TravelAgents.firstName ||' '|| TravelAgents.LastName As bookingAgent, Cruises.shipname, Cruises.CRUISENAME
From Cruises Inner Join Reservations
On Cruises.cruiseID = Reservations.cruiseID
Inner Join TravelAgents
On Reservations.travelAgentID = TravelAgents.travelAgentID
Where title = 'Senior Agent' And days = 7
Order By CRUISENAME, bookingAgent;

/* Question d */

Select Distinct Customers.firstName, Customers.lastName, shipname
From Customers Full Outer Join Reservations
On Customers.customerID = Reservations.customerID
Full Outer Join Cruises
On Reservations.cruiseID = Cruises.cruiseID
Where age < 65
Order By lastName, firstName, ShipName;
