drop table Books;
drop table Authors;
drop sequence authorID_seq;

create table Authors (
   authorID number,
   firstName varchar2(15),
   lastName varchar2(15),
   city varchar2(20),
   state char(2),
   Constraint Authors_PK Primary Key (authorID)
);

create sequence authorID_seq
start with 1
increment by 1;

insert into Authors values (authorID_seq.nextval, 'Robert', 'Silverberg', 'Brooklyn', 'NY');
insert into Authors values (authorID_seq.nextval, 'Anne', 'McCaffrey', 'Cambridge', 'MA');
insert into Authors values (authorID_seq.nextval, 'Robert', 'Heinlein', 'Kansas City', 'MO');
insert into Authors values (authorID_seq.nextval, 'Stephen', 'Donaldson', 'Cleveland', 'OH');
insert into Authors values (authorID_seq.nextval, 'Arthur', 'Clarke', 'Minehead', 'UK');
insert into Authors values (authorID_seq.nextval, 'Isaac', 'Asimov', 'New York City', 'NY');
insert into Authors values (authorID_seq.nextval, 'John', 'Varley', 'Austin', 'TX');
insert into Authors values (authorID_seq.nextval, 'Kurt', 'Vonnegut', 'Indianapolis', 'IN');

select * from Authors;

create table Books (
   ISBN char(10),
   authorID number,
   title varchar2(30) Not Null,
   copyright number(4),
   price number(6,2),
   Constraint Books_PK Primary Key (ISBN),
   Constraint Books_UQ Unique(Title),
   Constraint Books_authorID_FK Foreign Key (authorID) References Authors (authorID)
	On Delete Cascade,
   Constraint Books_copyrightVal check(copyright > 1800)
);

insert into Books values('0553144286', 1, 'Lord Valentines Castle', 1979, 23.99);
insert into Books values('0345284267', 2, 'Dragonflight', 1968, 14.75);
insert into Books values('0345281950', 3, 'Tunnel in the Sky', 1955, 2.32);
insert into Books values('0450005739', 3, 'Starship Troopers', 1959, 0.88);
insert into Books values('0345305507', 4, 'The One Tree', 1982, 41);
insert into Books values('0345291972', 5, 'Rendezvous With Rama', 1973, 75.02);
insert into Books values('0380009145', 6, 'Foundation', 1951, 1316.84);
insert into Books values('0345315715', 6, 'The Robots of Dawn', 1983, 33.5);
insert into Books values('0553288091', 6, 'The End of Eternity', 1955, 17.85);
insert into Books values('0425086704', 7, 'Titan', 1979, 50);
insert into Books values('0440111498', 8, 'Cats Cradle', 1963, 89.25);

select * from Books;


/* set copyright to null -> when doing count copyright, only count 10 instead of 11 */ 
update Books set copyright = null
where authorid = 7; 
select * from Books; 

select count (*) from Books; 
select count (copyright) from Books; 

/* exercise */ 
select max(price) from Books;
select avg(price) from Books;
select median(price) from Books;

select to_char(price, '9,999.99')
from Books; 

select to_char(price, '0,999.99')
from Books; 

select copyright, count(*)
from Books 
group by copyright 
order by copyright desc; 

select authorID, count(*)
from Books 
group by rollup (authorID); 


select firstName, lastName, count(A.authorID) 
from Authors A join Books B
on A.authorID = B.authorID
group by lastName, firstName 
having count(A.authorID) > 1 
order by lastName, firstName; 

select firstName, lastName, to_char(sum(price), '9,999.99') As SumPrice
from Authors A join Books B
on A.authorID = B.authorID 
group by rollup (lastName, firstName)
having count(A.authorID) > 1
order by lastName, firstName;


/* no data found */
select * from Books 
where copyright = null;
/* cannot do this comparison */ 
/* can only do this: */
select * from Books 
where copyright is null;


select title from Books 
where copyright = 1955 or copyright is null;

/* nvl -> give null element a number so we can use it for comparison */
select title from Books 
where nvl(copyright, 9999) < 1965; 

select title from Books 
where nvl(copyright, 0) < 1965; 

select copyright, sum(price) from Books 
group by copyright
order by copyright desc nulls last; 

/* update tables*/ 
update Books set price = price + 100
where authorID in 
    (select authorID
    from Authors 
    where state = 'NY'
    ); 
    
select * from Books;


/* select in select */ 
select * 
from Books 
where price In (
        select max(price) 
        from Books
        );


/* select on select on select */
select authorID, count(*) as BookCount
from Books
group by authorID; 

select max(BookCount) as MaxCount 
from (select authorID, count(*) as BookCount
        from Books
        group by authorID); 
        
        
select firstName, lastName, count(title)
from Authors A join Books B
    on A.authorID = B.authorID
group by firstName, lastName;

    
select firstName, lastName, count(title)
from Authors A join Books B
    on A.authorID = B.authorID
group by firstName, lastName
having count(title) in
    (select max(BookCount) as MaxCount 
        from (select authorID, count(*) as BookCount
        from Books
        group by authorID));    