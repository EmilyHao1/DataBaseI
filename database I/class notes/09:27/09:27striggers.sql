-- Statement Level Triggers 
 
-- Create a log table
drop table logBooks;
create table logBooks (
   logDateTime timestamp,
   logDescription varchar2(25));
   
create or replace trigger logBookInsert 
after insert on SFBooks 
begin 
    insert into logBooks values (systimestamp, 'Inserted a book'); 
end;
/

insert into SFBooks values ('1442005831', 'Heinlein', 'Robert', 'Stranger in a Strange Land', 1961, 32, 110);
select * from SFBooks;
select * from logBooks;
-- Example 2: performing a regular update statement

create or replace trigger IncreasePrices 
after insert on SFBooks
Begin 
    update SFBooks
    set price = price + 100
    where copyright < 1970; 
End; 
/
    
insert into SFBooks values('0345284268', 'Anne', 'McCaffrey', 'Dragonbane', 1969, 16.75, 102);
select * from SFBooks;

-- Example 3: be careful not to create an infinite trigger loop
-- recursive trigger loop

---- bad example
create or replace trigger logInsert 
before insert on logBooks
Begin 
    insert into logBooks values (systimestamp, 'Inserted a book'); 
end;
/
insert into SFBooks values('0345284269', 'Anne', 'McCaffrey', 'Dragonbane 2', 1969, 16.75, 102);



