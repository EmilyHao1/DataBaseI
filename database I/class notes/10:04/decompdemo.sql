select * from bookpub;

select * from bookLit; 
select * from Publisher; 

create table book1
 as
   select distinct copyright, isbn, firstname, lastname, title, price

   from bookpub;
   

select * from book1 
order by lastname, firstname, title;


create table pub1 as

    select distinct copyright, pubid, name, city, country

    from bookpub;
    

select * from pub1 
order by name;


select *
 from book1 natural join pub1;

create table book2 as
   select distinct isbn, firstname, lastname, title, copyright, price
   from bookpub;
select * from book2 
order by lastname, firstname, title;

create table pub2 as
   select distinct isbn, pubid, name, city, country
   from bookpub;

select * from pub2 
order by name;


select * from book2 natural join pub2;


create table book3 as
   select distinct pubid, isbn, firstname, lastname, title, copyright, price
   from bookpub;
select * from book3 
order by lastname, firstname, title;

create table pub3 as
   select distinct pubid, name, city country
   from bookpub;

select * from pub3 
order by name;


select * from book3 natural join pub3;


