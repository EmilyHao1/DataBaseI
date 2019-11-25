drop trigger PDate
drop trigger CheckBus
drop trigger SeniorSalary
drop trigger NoDoubleShift

/* Trigger 1
   When a booked tour is created, the
   PurchaseDate is automatically set to 90 days
   after the creation date, i.e., D + 90 days.
 */	
 
 create or replace trigger PDate 
 before insert on BookedTour
 For Each Row 
 declare 
    tempDate date; 
Begin 
    select sysdate into tempDate from Dual; 
    :new.purchaseDate := tempDate + 90; 
END;
/

INSERT INTO BookedTour VALUES(8, null, '3-Sep-16', 0, 3, 3, 'D4P', 4);
select * 
from bookedtour
where bookedtourid = 8;

/* Trigger 2  
   Buses must be made in 2010 or newer
 */

create or replace trigger CheckBus 
before insert or update on vehicle 
For Each Row
declare 
    cursor bus1 IS
        Select vehicleType, year 
        from vehicle; 
Begin 
    --- tests any recors being inserted 
    if (:new.vehicleType = 'bus' AND :new.year < 2010) then 
        RAISE_APPLICATION_ERROR( -20003, 'Insreted row error: Bus must be newer than 2010'); 
    end if; 
    
    ---- tests every existing records in the table 
    for vehicleRow in BUS1 loop
        if (vehicleRow.vehicleType = 'bus' AND vehicleRow.year < 2010) then 
            RAISE_APPLICATION_ERROR( -20003, 'Existing row error: Bus must be newer than 2010'); 
        end if; 
    end loop; 
END;
/

INSERT INTO Vehicle VALUES('S7M', 'bus', 'VW', 'Microbus', 2008, 10);
INSERT INTO Vehicle VALUES('L1Z', 'bus', 'Honda', 'Megabus', 2004, 30);

/* Trigger 3
   Senior guides must have a salary of at least $50,000
 */

create or replace trigger SeniorSalary 
before insert or update on Guide 
For Each Row 
declare
    tempTitle varchar2(15); 
    tempSalary number (5); 
    cursor S1 IS
        select title, salary
        from Guide; 
Begin 
    if (:new.title = 'Senior Guide' AND :new.salary < 50000) then 
         RAISE_APPLICATION_ERROR( -20001, 'Inserting row error: Senior Guide will starve'); 
    end if; 
    
    for guideRow in S1 loop
        if ( guideRow.title = 'Senior Guide' AND guideRow.salary < 50000) then 
         RAISE_APPLICATION_ERROR( -20001, 'Existing row error: Senior Guide will starve'); 
         end if; 
    end loop; 
End; 
/
    
    
    
INSERT INTO Guide VALUES(11, 'Maria', 'Martinez', 5088314993, 'car', 'Senior Guide', 48000, '23-Mar-16');

/* Trigger 4 
   A tour guide cannot be assigned to more than one booked tour in the same day.
 */	
 
create or replace trigger NoDoubleShift
before insert on BookedTour
for each row
declare
    tempDate date;
    tempGuide number(3);
    cursor b1 is
        select driverLicense, TravelDate
        from BookedTour;
begin
    tempDate := :new.travelDate;
    tempGuide := :new.driverLicense;
    for bookedtourRow in B1 loop
        if (bookedtourRow.driverLicense = tempGuide and bookedtourRow.travelDate = tempDate) then
            RAISE_APPLICATION_ERROR(-20007, 'Error: Tour guide already assigned on that date!');
        end if;
    end loop;
end;
/


INSERT INTO BookedTour VALUES(10, '19-Feb-16', '3-Jun-16', 0, 2, 4, 'A1K', 3);

