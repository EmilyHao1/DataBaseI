/* Haozhe Jiang Emily Hao */
/* CS3431 */
/* Project 1 phase 1 */


drop sequence formID_seq;
drop table WineLabelForms;
drop sequence wineID_seq;
drop table Wines;
drop table WineRepresentativeLogin;
drop table GovernmentAgentLogin;
drop sequence repID_seq;
drop table WineRepresentatives;
drop sequence ttbID_seq;
drop table GovernmentAgents;
drop table Accounts;

create table Accounts (
    loginName varchar2(25),
    password varchar2(25),
    role varchar2(25),
    constraint Accounts_PK primary key (loginName),
    constraint Accounts_UQ unique (loginName, role),
    constraint roleVal check (role in ('Agent', 'Representative'))
);

create table GovernmentAgents (
    ttbID number,
    loginName varchar2(25),
    superAgentID number,
    email varchar2(50),
    phone varchar2(15),
    name varchar2(25),
    constraint GovernmentAgents_PK primary key (ttbID),
    constraint GovernmentAgents_UK Unique (ttbID, loginName), 
    constraint GovernmentAgents_FKself foreign key (superAgentID) references GovernmentAgents(ttbID), 
    constraint GovernmentAgents_loginName_FK foreign key (loginName) references Accounts (loginName) On Delete Set Null
);
create sequence ttbID_seq start with 100 increment by 1;

create table WineRepresentatives (
    repID number,
    loginName varchar2(25),
    companyName varchar2(25),
    email varchar2(50),
    phone varchar2(15),
    name varchar2(25),
    constraint WineRepresentatives_PK primary key (repID),
    constraint WineRepresentatives_UK Unique (repID, loginName),
    constraint WineRepresentatives_loginName_FK foreign key (loginName) references Accounts (loginName) On Delete Set Null
);
create sequence repID_seq start with 100 increment by 1;

create table GovernmentAgentLogin (
    loginName varchar2(25),
    password varchar2(25),
    role varchar2(20) default 'Agent' not null,
    ttbID number,
    constraint GovernmentAgentLogin_PK primary key (loginName),
    constraint GovernmentAgentLogin_FK foreign key (loginName, role) references Accounts (loginName, role) on delete Cascade,
    constraint GovernmentAgentLogin_FK1 foreign key (ttbID) references GovernmentAgents (ttbID) on delete cascade,
    constraint roleVal_Agent check (role in ('Agent'))
);

create table WineRepresentativeLogin (
    loginName varchar2(25),
    password varchar2(25),
    role varchar2(20) default 'Representative' not null,
    repID number,
    constraint WineRepresentativeLogin_PK primary key (loginName),
    constraint WineRepresentativeLogin_FK foreign key (loginName, role) references Accounts (loginName, role) on delete cascade,
    constraint WineRepresentativeLogin_FK1 foreign key (repID) references WineRepresentatives (repID) on delete cascade,
    constraint roleVal_Representative check (role in ('Representative'))
);

create table Wines (
    wineID number,
    brandName varchar2(25),
    class varchar2(25),
    bottlerName varchar2(25),
    netContent number(5, 1),
    alchoholContent number(3, 1),
    appelation varchar2(25),
    constraint Wines_PK primary key (wineID)
);
create sequence wineID_seq start with 100 increment by 1;

insert into Wines values(wineID_seq.nextval, 'Metamorphosis', 'zinfandel', 'Metamorphosis', 750, 12.0, 'sonoma-county, california');
insert into Wines values(wineID_seq.nextval, 'Nickel & Nickel', 'cabernet sauvignon', 'Nickel & Nickel', 750, 10.0, 'napa valley, california');
insert into Wines values(wineID_seq.nextval, 'Radius', 'cabernet sauvignon', 'Radius', 750, 9.0, 'columbiaValley-washington');
insert into Wines values(wineID_seq.nextval, 'Mascota Vineyards', 'cabernet sauvignon', 'Mascota Vineyards', 1500, 11.0, 'mendoza, argentina');
insert into Wines values(wineID_seq.nextval, 'Meiomi', 'pinot noir', 'Meiomi', 750, 8.0, 'sonoma county, california');
insert into Wines values(wineID_seq.nextval, 'Radius', 'merlot', 'Radius', 750, 9.0, 'columbiaValley-washington');
insert into Wines values(wineID_seq.nextval, 'Apothic', 'red blend', 'Apothic', 750, 10.0, 'california');
insert into Wines values(wineID_seq.nextval, 'Oak Ridge Winery', 'zinfandel', 'Oak Ridge Winery', 750, 13.0, 'lodi, california');
insert into Wines values(wineID_seq.nextval, 'DAutrefois', 'pinot noir', 'DAutrefois', 1500, 10.0, 'vin de pays, france');
insert into Wines values(wineID_seq.nextval, 'red blend', 'zinfandel', 'San Antonio', 750, 12.0, 'california');

create table WineLabelForms (
    formID number,
    currentReviewerID number,
    ttbID number,
    repID number,
    dateSubmitted date,
    dateRejected date,
    dateApproved date,
    status varchar2(25),
    wineID number,
    vintage number(4),
    comments varchar2(100),
    beginDate date,
    constraint WineLabelForms_PK primary key (formID),
    constraint WineLabelForms_ttbID_FK foreign key (ttbID) references GovernmentAgents (ttbID),
    constraint WineLabelForms_repID_FK foreign key (repID) references WineRepresentatives (repID),
    constraint WineLabelForms_year_Check Unique (wineID, vintage),
    constraint WineLabelForms_wineID_FK foreign key (wineID) references Wines (wineID),
    constraint vintageVal check (vintage <= 2018)
);
create sequence formID_seq start with 100 increment by 1;

insert into Accounts values('ann', 'hi', 'Agent');
insert into Accounts values('bob', 'hi', 'Agent');
insert into Accounts values('cat', 'hi', 'Agent');
insert into Accounts values('don', 'hi', 'Agent');
insert into Accounts values('emm', 'hi', 'Agent');
insert into Accounts values('fra', 'hi', 'Agent');
insert into Accounts values('gor', 'hi', 'Agent');
insert into Accounts values('har', 'hi', 'Agent');
insert into Accounts values('ian', 'hi', 'Agent');
insert into Accounts values('jay', 'hi', 'Agent');

insert into Accounts values('anna', 'ho', 'Representative');
insert into Accounts values('boba', 'ho', 'Representative');
insert into Accounts values('cata', 'ho', 'Representative');
insert into Accounts values('dona', 'ho', 'Representative');
insert into Accounts values('emma', 'ho', 'Representative');
insert into Accounts values('fraa', 'ho', 'Representative');
insert into Accounts values('gora', 'ho', 'Representative');
insert into Accounts values('hara', 'ho', 'Representative');
insert into Accounts values('iana', 'ho', 'Representative');
insert into Accounts values('jaya', 'ho', 'Representative');

insert into GovernmentAgents values(ttbID_seq.nextval, 'ann', ttbID_seq.nextval, 'ann@wpi.edu', '1111', 'Ann');
insert into GovernmentAgents values(ttbID_seq.nextval, 'bob', 100, 'bob@wpi.edu', '2222', 'Bob');
insert into GovernmentAgents values(ttbID_seq.nextval, 'cat', 100, 'cat@wpi.edu', '3333', 'Cathy');
insert into GovernmentAgents values(ttbID_seq.nextval, 'don', 100, 'don@wpi.edu', '4444', 'Don');
insert into GovernmentAgents values(ttbID_seq.nextval, 'emm', 100, 'emm@wpi.edu', '5555', 'Emma');
insert into GovernmentAgents values(ttbID_seq.nextval, 'fra', 102, 'fra@wpi.edu', '6666', 'Frank');
insert into GovernmentAgents values(ttbID_seq.nextval, 'gor', 102, 'gor@wpi.edu', '7777', 'Gordon');
insert into GovernmentAgents values(ttbID_seq.nextval, 'har', 102, 'har@wpi.edu', '8888', 'Harry');
insert into GovernmentAgents values(ttbID_seq.nextval, 'ian', 102, 'ian@wpi.edu', '9999', 'Ian');
insert into GovernmentAgents values(ttbID_seq.nextval, 'jay', 102, 'jay@wpi.edu', '1010', 'Jay');

insert into WineRepresentatives values(repID_seq.nextval, 'anna', 'Diageo', 'anna@wpi.edu', '11111', 'Anna');
insert into WineRepresentatives values(repID_seq.nextval, 'boba', 'Diageo', 'boba@wpi.edu', '22222', 'Boba');
insert into WineRepresentatives values(repID_seq.nextval, 'cata', 'Treasury Wine Estates', 'cata@wpi.edu', '33333', 'Cathilina');
insert into WineRepresentatives values(repID_seq.nextval, 'dona', 'Pernod Ricard', 'dona@wpi.edu', '44444', 'Dona');
insert into WineRepresentatives values(repID_seq.nextval, 'emma', 'Treasury Wine Estates', 'emma@wpi.edu', '55555', 'Emmaily');
insert into WineRepresentatives values(repID_seq.nextval, 'fraa', 'Trinchero Family Estates', 'fraa@wpi.edu', '66666', 'Franka');
insert into WineRepresentatives values(repID_seq.nextval, 'gora', 'Pernod Ricard', 'gora@wpi.edu', '77777', 'Gordona');
insert into WineRepresentatives values(repID_seq.nextval, 'hara', 'Pernod Ricard', 'hara@wpi.edu', '88888', 'Harrya');
insert into WineRepresentatives values(repID_seq.nextval, 'iana', 'Trinchero Family Estates', 'iana@wpi.edu', '99999', 'Iana');
insert into WineRepresentatives values(repID_seq.nextval, 'jaya', 'Trinchero Family Estates', 'jaya@wpi.edu', '10100', 'Jaya');



insert into GovernmentAgentLogin values('ann', 'hi', 'Agent', 100);
insert into GovernmentAgentLogin values('bob', 'hi', 'Agent', 101);
insert into GovernmentAgentLogin values('cat', 'hi', 'Agent', 102);
insert into GovernmentAgentLogin values('don', 'hi', 'Agent', 103);
insert into GovernmentAgentLogin values('emm', 'hi', 'Agent', 104);
insert into GovernmentAgentLogin values('fra', 'hi', 'Agent', 105);
insert into GovernmentAgentLogin values('gor', 'hi', 'Agent', 106);
insert into GovernmentAgentLogin values('har', 'hi', 'Agent', 107);
insert into GovernmentAgentLogin values('ian', 'hi', 'Agent', 108);
insert into GovernmentAgentLogin values('jay', 'hi', 'Agent', 109);

insert into WineRepresentativeLogin values('anna', 'ho', 'Representative', 100);
insert into WineRepresentativeLogin values('boba', 'ho', 'Representative', 101);
insert into WineRepresentativeLogin values('cata', 'ho', 'Representative', 102);
insert into WineRepresentativeLogin values('dona', 'ho', 'Representative', 103);
insert into WineRepresentativeLogin values('emma', 'ho', 'Representative', 104);
insert into WineRepresentativeLogin values('fraa', 'ho', 'Representative', 105);
insert into WineRepresentativeLogin values('gora', 'ho', 'Representative', 106);
insert into WineRepresentativeLogin values('hara', 'ho', 'Representative', 107);
insert into WineRepresentativeLogin values('iana', 'ho', 'Representative', 108);
insert into WineRepresentativeLogin values('jaya', 'ho', 'Representative', 109);



insert into WineLabelForms values (formID_seq.nextval, 103， 101， 104， '01-Jan-18', '01-Feb-18', '01-Mar-18', 'Approved', 101, 1988, 'working on it', '01-Feb-18'); 
insert into WineLabelForms values (formID_seq.nextval, 104， 103， 100， '01-Jan-90', '01-Feb-99', '01-Mar-05', 'Rejected', 101, 1998, 'so bad', '01-Feb-99'); 
insert into WineLabelForms values (formID_seq.nextval, 102， 102， 100， '01-Jan-97', '01-Feb-99', '01-Mar-04', 'Approved', 102, 1990, 'not too bad', '01-Feb-99'); 
insert into WineLabelForms values (formID_seq.nextval, 101， 105， 101， '01-Jan-96', '01-Mar-99', '01-Mar-03', 'Approved', 103, 1950, 'pretty old', '01-Feb-99'); 
insert into WineLabelForms values (formID_seq.nextval, 105， 104， 105， '01-Jan-10', '01-Feb-11', '01-Mar-15', 'Rejected', 104, 1930, 'wow', '01-Feb-10'); 
insert into WineLabelForms values (formID_seq.nextval, 106， 106， 106， '01-Jan-11', '01-Feb-15', '01-Mar-17', 'Approved', 105, 1944, 'unblievable', '01-Feb-14'); 
insert into WineLabelForms values (formID_seq.nextval, 107， 107， 108， '01-Jan-06', '01-Feb-10', '01-Mar-12', 'Approved', 106, 1945, 'OMG', '01-Feb-09'); 
insert into WineLabelForms values (formID_seq.nextval, 108， 108， 102， '01-Jan-05', '01-Feb-08', '01-Mar-10', 'Approved', 103, 1932, 'so old', '01-Feb-07'); 
insert into WineLabelForms values (formID_seq.nextval, 106， 109， 109， '01-Jan-16', '01-Feb-17', '01-Mar-18', 'Approved', 103, 2000, 'pretty new, not that good', '01-Feb-16'); 
insert into WineLabelForms values (formID_seq.nextval, 109， 100， 101， '01-Jan-08', '01-Feb-10', '01-Mar-12', 'Approved', 106, 2001, 'it is alright', '01-Feb-09'); 
insert into WineLabelForms values (formID_seq.nextval, 101， 102， 100， '01-Jan-14', '01-Feb-15', '01-Mar-17', 'Approved', 107, 2005, 'why', '01-Feb-14'); 

insert into WineLabelForms values (formID_seq.nextval, 102， 103， 104， '01-Aug-18', '01-Nov-18', '01-Dec-18', 'Approved', 102, 1918, 'working on it still', '01-May-18'); 
insert into WineLabelForms values (formID_seq.nextval, 101， 102， 100， '01-Aug-90', '01-Nov-99', '01-Dec-05', 'Rejected', 107, 1928, 'so bad do not drink', '01-May-99'); 
insert into WineLabelForms values (formID_seq.nextval, 102， 101， 100， '01-Aug-97', '01-Nov-99', '01-Dec-04', 'Approved', 108, 1930, 'not too bad okey to drink', '01-May-99'); 
insert into WineLabelForms values (formID_seq.nextval, 106， 105， 102， '01-Aug-96', '01-Nov-99', '01-Dec-03', 'Approved', 109, 1940, 'pretty old sell good money', '01-May-99'); 
insert into WineLabelForms values (formID_seq.nextval, 107， 103， 101， '01-Aug-10', '01-Nov-11', '01-Dec-15', 'Rejected', 102, 1950, 'wow good wine', '01-May-10'); 
insert into WineLabelForms values (formID_seq.nextval, 108， 106， 103， '01-Aug-11', '01-Nov-15', '01-Dec-17', 'Approved', 104, 1964, 'unblievablely bad', '01-May-14'); 
insert into WineLabelForms values (formID_seq.nextval, 104， 107， 108， '01-Aug-06', '01-Nov-10', '01-Dec-12', 'Rejected', 104, 1975, 'OMG sell it now', '01-May-09'); 
insert into WineLabelForms values (formID_seq.nextval, 101， 108， 102， '01-Aug-05', '01-Nov-08', '01-Dec-10', 'Approved', 103, 1982, 'so old good money', '01-May-07'); 
insert into WineLabelForms values (formID_seq.nextval, 106， 109， 100， '01-Aug-16', '01-Nov-17', '01-Dec-18', 'Approved', 100, 2010, 'pretty new, not that good', '01-May-16'); 
insert into WineLabelForms values (formID_seq.nextval, 109， 100， 106， '01-Aug-08', '01-Nov-10', '01-Dec-12', 'Rejected', 109, 2011, 'it is alright to drink', '01-May-09'); 
insert into WineLabelForms values (formID_seq.nextval, 101， 102， 100， '01-Aug-14', '01-Nov-15', '01-Dec-17', 'Approved', 101, 2015, 'why both', '01-May-14'); 

select * from Accounts;
select * from GovernmentAgents;
select * from WineRepresentatives;
select * from WineRepresentativeLogin; 
select * from GovernmentAgentLogin; 
select * from Wines;
select * from WineLabelForms;


