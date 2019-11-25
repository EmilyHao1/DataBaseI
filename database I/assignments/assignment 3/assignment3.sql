/* question 1 */ 

drop table Players; 
drop table Association; 
drop table Tournament; 
drop table PlayersInTournament; 


create table Players (
    playerID number,
    fullName varchar2(30),
    handedness number,
    birthDate date,
    totalEarnings number,
    associationID number
); 

create table Association (
    acronym number, 
    associationName varchar2(30), 
    foundingYear number
); 

create table Tournament (
    tournamentName varchar2(30), 
    year number,
    startingDate date, 
    endingDate date, 
    prizeMoney number
); 

create table PlayersInTournament (
     tournamentName varchar2(30), 
     year number,
     playerID number
);

ALTER TABLE PlayersInTournament
ADD CONSTRAINT PT_Year
  FOREIGN KEY (year)
  REFERENCES Tournament(year)
  ON DELETE CASCADE; 
  
ALTER TABLE PlayersInTournament
ADD CONSTRAINT PT_tournamentName
  FOREIGN KEY (tournamentName)
  REFERENCES Tournament(tournamentName)
  ON DELETE CASCADE;  
  
  
ALTER TABLE PlayersInTournament
ADD Constraint PT_plater 
    Foreign Key (playerID) 
    References Players (playerID);
    
    
Alter table Players 
Add constraint P_associationID 
Foreign Key (associationID) 
References Association (acronym); 

/*question 2*/ 


drop table Authors; 
drop table SFBooks;
drop table NFBooks;
drop table Publishers; 
drop table Warehouses; 
drop table Stocks; 


Create table Authors(
    authorID number, 
    firstName number,
    lastName number, 
    birthDate date, 
    address varchar2(40)
    ); 
create table SFBooks(
    ISBN number, 
    title varchar2(40), 
    year number, 
    price number, 
    awardwinner varchar2(40), 
    publisherName varchar2(40), 
    authorID number
    ); 
create table NFBooks(
    ISBN number, 
    title varchar2(40), 
    year number, 
    price number, 
    awardwinner varchar2(40), 
    publisherName varchar2(40), 
    authorID number
    ); 
    
Create table Publishers (
    publisherName varchar2(30),
    city varchar2(30), 
    phone number
    ); 
Create table Warehouses (
    code varchar2(30),
    address varchar2(30), 
    city number
    ); 
    
Create table Stocks(
    warehouseCode varchar2(30), 
    ISBN number, 
    numberOfBooks number
    ); 
    
/*For each publisher, list the publisher name and city, 
and the average price of the science fiction books published 
after the year 2000 by that publisher. For this question, use natural joins.*/

Select publisherName, city avg(price) 
From SFBooks natural Join Publishers 
where year > 2000 
Group by city, publisherName; 


/*List the warehouse code and city, and the total number of books it contains for those warehouses that have more than 1000 books.*/ 

select warehouseCode, city, numberOfBooks 
From S inner Join S 
In S.warehouseCode = W.code 
Where numberOfBooks > 1000 
Group by rollup warehouseCode; 

/* For authors who published both science fiction and non-fiction books, 
list the author’s first name, last name, and how many books they wrote.*/ 

select authorID, firstName, lastName, count(authorID) 
from Authors natural join (select SFBooks.authorID
                    		    From SFBooks inner join  NFBooks 
                    			on SFBooks.authorID = NFBooks.authorID)
group by authorID, firstName, lastName
order by lastName,firstName;


/* For authors who published both science fiction and non-fiction books, 
list the author’s first name, last name, and how many books they wrote.*/ 
insert into Authors values (1, 'E', 'H', 2, 'fgte'); 
insert into Authors values (2, 'E2', 'H2', 21, 'fgte1'); 
insert into Authors values (3, 'E3', 'H3', 22, 'fgte2'); 
insert into Authors values (4, 'E4', 'H4', 23, 'fgte3'); 
insert into Authors values (5, 'E5', 'H5', 24, 'fgte4'); 

insert into SFBooks values (1, 'ff', 2001, 30, 'fw', 'sf', 1); 
insert into SFBooks values (12, 'ff1', 2002, 301, 'fw1', 'sf1', 1); 
insert into SFBooks values (13, 'ff2', 2003, 302, 'fw2', 'sf2', 2); 
insert into SFBooks values (14, 'ff3', 2004, 3033, 'f3w', 'sf3', 3); 
insert into SFBooks values (15, 'ff4', 2005, 304, 'fw4', 'sf4', 4); 

insert into NFBooks values (1, 'ff', 2001, 30, 'fw', 'sf', 1); 
insert into NFBooks values (12, 'ff1', 2002, 301, 'fw1', 'sf1', 1); 
insert into NFBooks values (13, 'ff2', 2003, 302, 'fw2', 'sf2', 2); 
insert into NFBooks values (14, 'ff3', 2004, 3033, 'f3w', 'sf3', 3); 
insert into NFBooks values (15, 'ff4', 2005, 304, 'fw4', 'sf4', 4); 

select authorID, firstName, lastName, count(authorID) from Authors natural join (select SFBooks.authorID
                                From SFBooks inner join  NFBooks 
                                on SFBooks.authorID = NFBooks.authorID)
                                group by authorID, firstName, lastName
                                order by lastName,firstName;

/* question 3*/ 
create table M1 (
    A number, 
    B number, 
    C varchar2(10), 
    D varchar2(10)
); 

create table N1 (
    X number, 
    Y varchar2(10), 
    B number
); 

insert into M1 values (14, 4, 'Henry', 'David'); 
insert into M1 values (8, 2, 'Mary', 'Helen'); 
insert into M1 values (2, 6, 'Jane', 'Susan'); 
insert into M1 values (61, 3, 'Tom', 'Paul'); 
insert into M1 values (2, 5, 'Lisa', 'Mary'); 
insert into M1 values (24, 9, 'Mark', 'John'); 
insert into M1 values (8, 1, 'Paul', 'Amy'); 
insert into M1 values (5, 2, 'Dan', 'Matt'); 

insert into N1 values (3, 'Matt', 5); 
insert into N1 values (2, 'Tom', 8); 
insert into N1 values (8, 'Mary', 61); 
insert into N1 values (8, 'Lisa', 2); 
insert into N1 values (5, 'John', 8); 
insert into N1 values (13, 'Tom', 42); 
insert into N1 values (42, 'Henry', 2); 

select A, B, C, D, Y as E
From M natural join N
where A * B > X; 



select C, D, sum(A + X) As SUM
From M inner join N 
On M.A = N.X; 



select R.X, R.Y, N.B 
From N inner join (select B As X, D As Y, A As B 
                    from M 
                    where A < B 
                    Union
                    Select * 
                    from N 
                    where X > 5 ) R 
On N.X = R.X And N.Y = R.Y ; 



