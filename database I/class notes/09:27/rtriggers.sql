-- Row-level trigger examples

-- Row-level trigger, same as previous statement-level trigger
-- Notice mutating table
--- bad--- need to change into before insert
select * from SFBooks;
create or replace trigger IncreasePrices
after insert on SFBooks
for each row 
begin 
    update SFBooks
    set price = price + 100
    where copyright < 1970; 
end;
/

insert into SFBooks values('0345284270', 'Anne', 'McCaffrey', 'Dragonbane 3', 1969, 16.75, 102);
select * from SFBooks;

-- Change after to before to fix the mutating table error

insert into SFBooks values('0345284268', 'Anne', 'McCaffrey', 'Dragonbane', 1969, 16.75, 102);
select * from SFBooks;

/* Row level trigger using new variables */

create or replace trigger IncreasePrices 
before insert on SFBooks
for each row
when (new.copyright < 1970)
begin 
    update SFBooks
    set price = price + 100
    where copyright < 1970; 
end; 
/
delete from SFBooks where ISBN = '1442005831'; 
insert into SFBooks values ('1442005831', 'Heinlein', 'Robert', 'Stranger in a Strange Land', 1961, 32, 110);
select * from SFBooks;

/* Row level trigger using :new.Price
   Note the difference in the changed rows!
   Only the inserted record is affected
 */
create or replace trigger IncreasePrices 
before insert on SFBooks 
for each row 
begin 
    if (:new.copyright < 1970) then 
        :new.price := :new.price + 500; 
    end if; 
end;
/

insert into SFBooks values('425036987', 'Frank', 'Herbert', 'Dune', 1965, 18.42, 103);
select * from SFBooks;

drop trigger logInsert; 
