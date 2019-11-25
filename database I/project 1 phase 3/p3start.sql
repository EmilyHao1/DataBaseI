-- Since all IDs are number sequences, they are unique attributes

drop table Process cascade constraints;
drop table Forms cascade constraints;
drop table Agents cascade constraints;
drop table Reps cascade constraints;
drop table Accounts cascade constraints;
drop table Wines cascade constraints;

drop sequence ttbID_seq;
drop sequence repID_seq;
drop sequence formID_seq;
drop sequence wineID_seq;


create table Accounts (
	loginName varchar2(25),
	Role varchar2(10),
	password varchar2(25),
	phone varchar2(15),
	email varchar2(50),
	name varchar2(25),
	constraint Accounts_PK primary key (loginName),
	constraint Accounts_UQ unique (loginName, Role),
	constraint AccountsRoleVal check (Role in ('Agent', 'Rep'))
);

create table Agents(
	loginName varchar2(25),
	Role varchar2(10) default 'Agent' not null,
	ttbID number,
	isSuperAgent number(1),
	constraint Agents_PK primary key (loginName),
	constraint AgentsRoleVal check (Role = 'Agent'),
	constraint Agents_UQ unique (ttbID),
	constraint AgentsSuperVal check (isSuperAgent in (0, 1)),
	constraint Agents_FK foreign key (loginName, Role) references Accounts(loginName, Role)
);

create sequence ttbID_seq
start with 100
increment by 1;

create table Reps(
	loginName varchar2(25),
	Role varchar2(10) default 'Rep' not null,
	repID number,
	companyName varchar2(25),
	constraint Reps_PK primary key (loginName),
	constraint RepsRoleVal check (Role = 'Rep'),
	constraint Reps_UQ unique (repID),
	constraint Reps_FK foreign key (loginName, Role) references Accounts (loginName, Role)
);

create sequence repID_seq
start with 100
increment by 1;

create table Wines (
	wineID number,
	brand varchar2(25),
	classType varchar2(25),
	alcohol number(4,1),
	appellation varchar2(25),
	netContent number(6,1),
	bottlerName varchar2(25),
	constraint Wines_PK primary key (wineID),
	constraint WinesAlcoholVal check (alcohol <= 100 and alcohol >= 0)
);
--Note: because of ambiguity in the instructions,
--      netContent number (5,1)
--      will also be marked correct

create sequence wineID_seq
start with 100
increment by 1;

create table Forms(
	formID number,
	status varchar2(25),
	vintage number(4),
	dateSubmitted date,
	dateRejected date,
	dateApproved date,
	currentReviewerID number,
	repID number,
	wineID number,
	constraint Forms_PK primary key (formID),
	constraint Forms_FK1 foreign key (currentReviewerID) references Agents (ttbID),
	constraint Forms_FK2 foreign key (repID) references Reps (repID),
	constraint Forms_FK3 foreign key (wineID) references Wines (wineID)
);

create sequence formID_seq
start with 100
increment by 1;

create table Process (
	ttbID number,
	formID number,
	processDate date,
	processComment varchar2(100),
	constraint Process_PK primary key (ttbID, formID),
	constraint Process_FK1 foreign key (ttbID) references Agents (ttbID),
	constraint Process_FK2 foreign key (formID) references Forms (formID)
);

-- Accounts Data --------------------------------------------

INSERT INTO Accounts 
VALUES ('JWilliam', 'Rep', 'she5sdg', '1234', 'JWilliam@gallo.com', 'James Williams');

INSERT INTO Accounts 
VALUES ('MYoung', 'Agent', 'se5dth', '3452', 'MYoung@ttb.gov', 'Mary Young');

INSERT INTO Accounts 
VALUES ('JKing', 'Agent', 'e465y7g', '4565', 'JKing@ttb.gov', 'John King');

INSERT INTO Accounts 
VALUES ('RWright', 'Rep', 'xfdt756k', '3457', 'RWright@calera.com', 'Robert Wright');

INSERT INTO Accounts 
VALUES ('PReed', 'Rep', 'l97sage5', '8552', 'PReed@trio.com', 'Patricia Reed');

INSERT INTO Accounts 
VALUES ('LCook', 'Agent', 'f6udr;ghiu', '3425', 'LCook@ttb.gov', 'Linda Cook');

INSERT INTO Accounts 
VALUES ('MColeman', 'Agent', 'd457dxhe', '8206', 'MColeman@ttb.gov', 'Michael Coleman');

INSERT INTO Accounts 
VALUES ('BPerry', 'Rep', 'w456cfjh', '5188', 'BPerry@thirstyowl.com', 'Barbara Perry');

INSERT INTO Accounts 
VALUES ('ELong', 'Agent', 'es56guow3', '4583', 'ELong@ttb.gov', 'Elizabeth Long');

INSERT INTO Accounts 
VALUES ('WHughes', 'Rep', '3568dfghj56', '9093', 'WHughes@martignetti.com', 'William Hughes');

INSERT INTO Accounts 
VALUES ('SGreen', 'Rep', 'w356hgfe4', '2375', 'SGreen@purplewine.com', 'Susan Green');

INSERT INTO Accounts 
VALUES ('CAdams', 'Agent', 'ryjxb,fjyer', '4623', 'CAdams@ttb.gov', 'Charles Adams');

INSERT INTO Accounts 
VALUES ('JTaylor', 'Agent', 'ew457xfd', '7854', 'JTaylor@ttb.gov', 'John Taylor');

INSERT INTO Accounts 
VALUES ('LMurphy', 'Rep', 'e568ghms', '3462', 'LMurphy@creamwine.com', 'Linda Murphy');

INSERT INTO Accounts 
VALUES ('RBell', 'Agent', '456cfh5h', '8456', 'RBell@ttb.gov', 'Robert Bell');

INSERT INTO Accounts 
VALUES ('TKing', 'Rep', 'testtest', '6342', 'TKing@accolade.com', 'Thomas King');

INSERT INTO Accounts 
VALUES ('LRoss', 'Agent', 'badpasswd', '4509', 'LRoss@ttb.gov', 'Lisa Ross');

INSERT INTO Accounts 
VALUES ('HBarnes', 'Rep', 'w345sdg', '3674', 'HBarnes@constellation.com', 'Helen Barnes');

INSERT INTO Accounts 
VALUES ('CReed', 'Agent', 'carol', '6100', 'CReed@ttb.gov', 'Carol Reed');

INSERT INTO Accounts 
VALUES ('GBrown', 'Rep', 'w356xdgf', '1530', 'GBrown@penaflor.com', 'George Brown');

select * from Accounts;

-- Agents Data -------------------------------------

INSERT INTO Agents VALUES ('MYoung', 'Agent', ttbID_seq.nextval, 0);
INSERT INTO Agents VALUES ('JKing', 'Agent', ttbID_seq.nextval, 0);
INSERT INTO Agents VALUES ('LCook', 'Agent', ttbID_seq.nextval, 0);
INSERT INTO Agents VALUES ('MColeman', 'Agent', ttbID_seq.nextval, 1);
INSERT INTO Agents VALUES ('ELong', 'Agent', ttbID_seq.nextval, 0);
INSERT INTO Agents VALUES ('CAdams', 'Agent', ttbID_seq.nextval, 0);
INSERT INTO Agents VALUES ('JTaylor', 'Agent', ttbID_seq.nextval, 1);
INSERT INTO Agents VALUES ('RBell', 'Agent', ttbID_seq.nextval, 0);
INSERT INTO Agents VALUES ('LRoss', 'Agent', ttbID_seq.nextval, 0);
INSERT INTO Agents VALUES ('CReed', 'Agent', ttbID_seq.nextval, 0);

select * from Agents;

-- Reps Data ----------------------------------------

INSERT INTO Reps VALUES ('JWilliam', 'Rep', repID_seq.nextval, 'Gallo');
INSERT INTO Reps VALUES ('RWright', 'Rep', repID_seq.nextval, 'Calera');
INSERT INTO Reps VALUES ('PReed', 'Rep', repID_seq.nextval, 'Trio');
INSERT INTO Reps VALUES ('BPerry', 'Rep', repID_seq.nextval, 'Thirsty Owl');
INSERT INTO Reps VALUES ('WHughes', 'Rep', repID_seq.nextval, 'Martignetti');
INSERT INTO Reps VALUES ('SGreen', 'Rep', repID_seq.nextval, 'Purple Wine');
INSERT INTO Reps VALUES ('LMurphy', 'Rep', repID_seq.nextval, 'Cream Wine');
INSERT INTO Reps VALUES ('TKing', 'Rep', repID_seq.nextval, 'Accolade');
INSERT INTO Reps VALUES ('HBarnes', 'Rep', repID_seq.nextval, 'Constellation');
INSERT INTO Reps VALUES ('GBrown', 'Rep', repID_seq.nextval, 'Penaflor');

select * from Reps;

-- Wines -----------------------------------------

INSERT INTO Wines VALUES 
(wineID_seq.nextval,'Meiomi','Pinot Noir',13.7,'California',750,'Meiomi Wines');

INSERT INTO Wines VALUES 
(wineID_seq.nextval,'Ruffino','Chianti',13,'Italy',750,'Ruffino Pontassieve');

INSERT INTO Wines VALUES 
(wineID_seq.nextval,'Cooks'' Brut','Champagne',12.7,'California',1500,'Cook''s Champagne');

INSERT INTO Wines VALUES 
(wineID_seq.nextval,'Meiomi','Chardonnay',13.9,'California',750,'Meiomi Wines');

INSERT INTO Wines VALUES 
(wineID_seq.nextval,'Nobilo','Sauvignon Blanc',12.5,'New Zealand',750,'Constellation Imports');

INSERT INTO Wines VALUES 
(wineID_seq.nextval,'King Estate','Pinot Gris',13.5,'Willamette Valley',750,'King Estate Winery');

INSERT INTO Wines VALUES 
(wineID_seq.nextval,'Red Goliath','Pinot Noir',12.5,'American',750,'HRM Rex-Goliath Winery');

INSERT INTO Wines VALUES 
(wineID_seq.nextval,'Napa Valley','Cabernet Sauvignon',15,'Napa Valley',750,'Robert Mondavi Winery');

INSERT INTO Wines VALUES 
(wineID_seq.nextval,'Estancia','Cabernet Sauvignon',13.5,'Paso Robles',750,'Estancia Winery');

INSERT INTO Wines VALUES 
(wineID_seq.nextval,'Hogue','Cabernet Sauvignon',13.8,'Columbia Valley',750,'Hogue Cellars');

select * from Wines;

-- Forms ------------------------------------------------
INSERT INTO Forms VALUES (formID_seq.nextval,'rejected',1964,'16-Mar-17', '20-Feb-18', NULL,109,100,103);
INSERT INTO Forms VALUES (formID_seq.nextval,'working',2018,'05-Jan-18', NULL,NULL,103,105,109);
INSERT INTO Forms VALUES (formID_seq.nextval,'approved',2002,'23-Nov-17', NULL,'24-Dec-17', 106,104,107);
INSERT INTO Forms VALUES (formID_seq.nextval,'working',1997,'07-Sep-18', NULL,NULL,100,106,108);
INSERT INTO Forms VALUES (formID_seq.nextval,'approved',2017,'31-Jul-18', NULL,'02-Aug-18', 109,108,105);
INSERT INTO Forms VALUES (formID_seq.nextval,'approved',2016,'09-Jan-17', NULL,'28-Feb-17', 105,106,101);
INSERT INTO Forms VALUES (formID_seq.nextval,'working',2008,'16-Apr-18', NULL,NULL,101,103,100);
INSERT INTO Forms VALUES (formID_seq.nextval,'rejected',1992,'23-Aug-18', '09-Sep-18', NULL,106,106,101);
INSERT INTO Forms VALUES (formID_seq.nextval,'working',2010,'15-Dec-15', NULL,NULL,102,108,105);
INSERT INTO Forms VALUES (formID_seq.nextval,'working',2016,'03-Jul-18', NULL,NULL,102,103,102);
INSERT INTO Forms VALUES (formID_seq.nextval,'working',1989,'02-May-18', NULL,NULL,101,104,107);
INSERT INTO Forms VALUES (formID_seq.nextval,'approved',2013,'20-Jan-17', NULL,'11-Apr-18', 107,101,106);
INSERT INTO Forms VALUES (formID_seq.nextval,'rejected',2018,'14-Nov-16', '02-Jan-17', NULL,103,106,101);
INSERT INTO Forms VALUES (formID_seq.nextval,'approved',2017,'01-Feb-18', NULL,'25-Jul-18', 107,106,101);
INSERT INTO Forms VALUES (formID_seq.nextval,'working',2018,'03-Jul-18', NULL,NULL,104,104,107);
INSERT INTO Forms VALUES (formID_seq.nextval,'approved',2000,'02-Feb-16', NULL,'22-Jan-17', 103,104,107);
INSERT INTO Forms VALUES (formID_seq.nextval,'working',2016,'30-May-17', NULL,NULL,104,103,102);
INSERT INTO Forms VALUES (formID_seq.nextval,'rejected',2018,'06-Jun-15', '08-Oct-17', NULL,108,100,103);
INSERT INTO Forms VALUES (formID_seq.nextval,'rejected',1999,'14-Feb-16', '03-Apr-16', NULL,109,109,104);
INSERT INTO Forms VALUES (formID_seq.nextval,'working',2017,'28-Aug-18', NULL,NULL,105,103,102);
select * from Forms;

-- Process -----------------------------------------------

INSERT INTO Process 
VALUES (109, 100, '20-Feb-18', 'problem with the alcohol percentage');

INSERT INTO Process 
VALUES (102, 100, '04-Apr-17', 'worked on the main label');

INSERT INTO Process 
VALUES (103, 101, '07-Jan-18', 'checked the appellation');

INSERT INTO Process 
VALUES (106, 102, '24-Dec-17', 'company rep fixed remaining problems');

INSERT INTO Process 
VALUES (100, 102, '25-Nov-17', 'checked list of ingredients');

INSERT INTO Process 
VALUES (101, 102, '02-Dec-17', 'alcohol and contents are correct');

INSERT INTO Process 
VALUES (100, 103, '07-Nov-18', 'label is ripped');

INSERT INTO Process 
VALUES (109, 104, '02-Aug-18', 'everything is fine');

INSERT INTO Process 
VALUES (101, 104, '01-Aug-18', 'appellation, alcohol, contents look good');

INSERT INTO Process 
VALUES (105, 105, '28-Feb-17', 'company rep fixed remaining problems');

INSERT INTO Process 
VALUES (101, 106, '23-Aug-18', 'checked the vintage');

INSERT INTO Process 
VALUES (106, 107, '09-Sep-18', 'rejected');

INSERT INTO Process 
VALUES (103, 107, '30-Aug-18', 'main label is fine');

INSERT INTO Process 
VALUES (102, 108, '12-May-17', 'appellation is not on the approved list');

INSERT INTO Process 
VALUES (102, 109, '14-Sep-18', 'finished working on the main label');

INSERT INTO Process 
VALUES (106, 109, '07-Jul-18', 'looked up contact information');

INSERT INTO Process 
VALUES (100, 109, '22-Jul-18', 'confirmed alcohol percentage');

INSERT INTO Process 
VALUES (101, 110, '05-Jun-18', 'working');

INSERT INTO Process 
VALUES (107, 111, '11-Apr-18', 'everything is fine');

INSERT INTO Process 
VALUES (103, 112, '02-Jan-17', 'typo in the ingredient list');

INSERT INTO Process 
VALUES (107, 113, '25-Jul-18', 'approved');

INSERT INTO Process 
VALUES (102, 113, '08-Feb-18', 'list of ingredients approved');

INSERT INTO Process 
VALUES (108, 113, '23-Mar-18', 'alcohol and contents are correct');

INSERT INTO Process 
VALUES (101, 113, '14-Jun-18', 'main label is fine');

INSERT INTO Process 
VALUES (104, 114, '17-Jul-18', 'font is hard to read');

INSERT INTO Process 
VALUES (103, 115, '22-Jan-17', 'all label information is there');

INSERT INTO Process 
VALUES (104, 116, '31-Dec-17', 'working');

INSERT INTO Process 
VALUES (108, 117, '08-Oct-17', 'wine was recalled');

INSERT INTO Process 
VALUES (100, 117, '24-Jan-16', 'main label is fine');

INSERT INTO Process 
VALUES (109, 118, '03-Apr-16', 'font is too small');

INSERT INTO Process 
VALUES (105, 119, '01-Sep-18', 'looking up contact information for company rep');

select * from Process;