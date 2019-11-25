select * 
from SFBook;

create or replace trigger ChangePrices 
after insert on SFBook
Begin 
    update SFBook
    set Price = price + 100
    where copyright < 1970; 
End;
/

-- only SF books with a copyright before 1970 was updated ( entire table)
select * from sfbook;
insert into SFBook values('0345284268', 'Anne', 'McCaffrey', 'Dragonbane', 1965, 16.75, 102);
select * from sfbook;

-- row level trigger 
create or replace trigger changePrices
before insert on SFBook 
For Each Row 
When (new.copyright < 1970)
Begin 
    update SFBook
    set Price = Price + 200; 
End;
/

select * from sfbook;
insert into SFBook values('0345284269', 'Anne', 'McCaffrey', 'Dragonbane 2', 1966, 17, 102);
select * from sfbook;

-- thrid example

create or replace trigger changePrices
before insert on SFBook 
For Each Row 
Begin 
    :new.price := :new.price + 100; 
End;
/

select * from sfbook;
insert into SFBook values('0345284290', 'Anne', 'McCaffrey', 'Dragonbane 3', 1966, 17, 102);
select * from sfbook;