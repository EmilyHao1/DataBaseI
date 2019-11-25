/*Haozhe Jiang & Emily Hao
    CS3431
Project1 phase 2*/


--Problem 1
create or replace view ClassTypeStats as
select classType, count(dateSubmitted) as Submitted, count(dateRejected) as Rejected, count(dateApproved) as Approved
from Wines inner join Forms
on Wines.wineID = Forms.wineID
group by classType;

select * from ClassTypeStats;

create or replace view RemainingCForms as
select classType, (Submitted - Rejected - Approved) as Remaining
from ClassTypeStats
where (classType like 'C%')
order by classType;

select * from RemainingCForms;


--Problem 2
set serveroutput on;

create or replace procedure FormsByAgents (AgentsName varchar2) IS 
    tempAgent varchar2(25);
    tempForm number; 
cursor name1 is
        select loginName 
        from Accounts 
        where Name = FormsByAgents.AgentsName;
begin 
    open name1;
    fetch name1 into tempAgent; 
    select count(loginName) INTO tempForm
    from Agents inner join Process 
    on Agents.TTBID = Process.TTBID
    where Agents.loginName = tempAgent; 
    dbms_output.put_line('Agent' || ' ' || AgentsName || ': ' || tempForm);
Exception 
    when NO_DATA_FOUND then 
    tempForm := 0; 
    dbms_output.put_line('Agent' || ' ' || AgentsName || ': ' || tempForm);
end FormsByAgents; 
/

---test cases return correct forms
exec FormsbyAgents('Mary Young'); 
--- test cases not in database: return 0 
exec FormsbyAgents ('Emily Hao');
--- test cases not a agent : return 0 
exec FormsbyAgents('James Williams'); 


--Problem 3
drop trigger InsertErrorDates;

create or replace trigger InsertErrorDates
after insert on Forms
for each row
begin
    if (:new.dateRejected < :new.dateSubmitted) then
        RAISE_APPLICATION_ERROR(-20003, 'INSERTED ROW ERROR: Rejection date must be after submission date');
    end if;
    if (:new.dateApproved < :new.dateSubmitted) then
        RAISE_APPLICATION_ERROR(-20003, 'INSERTED ROW ERROR: Approval date must be after submission date');
    end if;
    if (:new.dateRejected is not null and :new.dateApproved is not null) then
        RAISE_APPLICATION_ERROR(-20003, 'INSERTED ROW ERROR: There cannot be both a rejection date and an approval date');
    end if;
end;
/
-- testing if the trigger is working 
INSERT INTO Forms VALUES (formID_seq.nextval,'rejected',1964,'16-Mar-17', '20-Feb-10', NULL,109,100,103);
INSERT INTO Forms VALUES (formID_seq.nextval,'rejected',1964,'16-Mar-17', NULL, '20-Feb-10',109,100,103);
INSERT INTO Forms VALUES (formID_seq.nextval,'rejected',1964,'16-Mar-17', '20-Feb-18', '10-Feb-19',109,100,103);

--Problem 4
drop trigger InsertErrorDates;
drop trigger ExistingErrorDates;

INSERT INTO Forms VALUES (formID_seq.nextval,'rejected',1964,'16-Mar-17', '20-Feb-10', NULL,109,100,103);
INSERT INTO Forms VALUES (formID_seq.nextval,'rejected',1964,'16-Mar-17', NULL, '20-Feb-10',109,100,103);
INSERT INTO Forms VALUES (formID_seq.nextval,'rejected',1964,'16-Mar-17', '20-Feb-18', '10-Feb-19',109,100,103);

create or replace trigger ExistingErrorDates
before insert on Forms
for each row
declare
    cursor c1 is
        select dateSubmitted, dateRejected, dateApproved
        from Forms;
begin
    for formsRow in c1 loop
        if (formsRow.dateRejected < formsRow.dateSubmitted) then
            RAISE_APPLICATION_ERROR(-20002, 'EXISTING ROW ERROR: Rejection date must be after submission date');
        end if;
        if (formsRow.dateApproved < formsRow.dateSubmitted) then
            RAISE_APPLICATION_ERROR(-20002, 'EXISTING ROW ERROR: Approval date must be after submission date');
        end if;
        if (formsRow.dateRejected is not null and formsRow.dateApproved is not null) then
            RAISE_APPLICATION_ERROR(-20002, 'EXISTING ROW ERROR: There cannot be both a rejection date and an approval date');
        end if;
    end loop;
end;
/

INSERT INTO Forms VALUES (formID_seq.nextval,'rejected',1964,'01-Jan-97', '01-Feb-99', NULL,109,100,103);
delete from Forms where dateSubmitted = '16-Mar-17' and dateRejected = '20-Feb-10';
INSERT INTO Forms VALUES (formID_seq.nextval,'rejected',1964,'01-Jan-97', '01-Feb-99', NULL,109,100,103);
delete from Forms where dateSubmitted = '16-Mar-17' and dateApproved = '20-Feb-10';
INSERT INTO Forms VALUES (formID_seq.nextval,'rejected',1964,'01-Jan-97', '01-Feb-99', NULL,109,100,103);
delete from Forms where dateRejected = '20-Feb-18' and dateApproved = '10-Feb-19';
INSERT INTO Forms VALUES (formID_seq.nextval,'rejected',1964,'01-Jan-97', '01-Feb-99', NULL,109,100,103);

-- the test cases show that a new form cannot be inserted when there are EXISTING ROW ERROR in the table
-- but after deleting all 3 rows with errors the new row is finally able to be inserted
-- which means the trigger works


--Problem 5
drop trigger TooMuchWorkForAgents; 


create or replace trigger TooMuchWorkForAgents
after insert or update on Forms 
declare 
    tempFormID number; 
    cursor tempForm IS
        select currentReviewerID, count(formID) As tempFormID
        from Forms 
        group by currentReviewerID; 
begin 
    for EachAgent in tempForm loop
        if (EachAgent.tempFormID > 5) then 
        RAISE_APPLICATION_ERROR(-20009, 'TooMuchWorkForAgentsError: this agent has more than 5 forms');
        end if;
    end loop; 
end;
/
-- should be fine 
INSERT INTO Forms VALUES (formID_seq.nextval,'working',2017,'28-AUG-18', NULL, NULL,109,100,103);
INSERT INTO Forms VALUES (formID_seq.nextval,'working',2017,'29-AUG-18', NULL, NULL,109,100,103);
-- should raise the error 
INSERT INTO Forms VALUES (formID_seq.nextval,'working',2017,'30-AUG-18', NULL, NULL,109,100,103);


--Problem 6
drop trigger ChangeStatus; 

INSERT INTO Forms VALUES (formID_seq.nextval,'testing',6666,'01-Jan-99', '03-Jan-99', NULL,101,100,103);
INSERT INTO Forms VALUES (formID_seq.nextval,'testing',6666,'01-Jan-99', NULL, '03-Jan-99',101,100,103);


create or replace view currentStatus as 
    select formID, dateSubmitted, dateRejected, dateApproved, status
    from Forms;
select * from currentStatus;


create or replace trigger ChangeStatus
after insert or update on Forms
declare 
    cursor c6 is select * from currentStatus;
begin
    for f in c6 loop
        if (f.dateRejected is not null and f.status != 'rejected') then
            update Forms set status = 'rejected' where formID = f.formID;
        end if;
        if (f.dateApproved is not null and f.status != 'approved') then
            update Forms set status = 'approved' where formID = f.formID;
        end if;
    end loop;
end ChangeStatus;
/
select * from Forms; 
--- should change them into according status 
INSERT INTO Forms VALUES (formID_seq.nextval,'testing',6666,'01-Jan-99', '02-Jan-99', NULL,102,100,103);
INSERT INTO Forms VALUES (formID_seq.nextval,'testing',6666,'01-Jan-99', NULL, '02-Jan-99',103,100,103);
INSERT INTO Forms VALUES (formID_seq.nextval,'testing',6666,'10-Jan-99', NULL, '20-Jan-99',104,100,103);
--- shouldn't change anything 
INSERT INTO Forms VALUES (formID_seq.nextval,'testing',6666,'10-Jan-99', NULL, NULL,104,100,103);
INSERT INTO Forms VALUES (formID_seq.nextval,'rejected',1964,'16-Mar-17', '20-Feb-18', NULL,109,100,103);
--- only check for rejected or approved, shouldn't change anything if those two dates are both null 
INSERT INTO Forms VALUES (formID_seq.nextval,'rejected',1964,'16-Mar-17', Null, NULL,106,100,103);





