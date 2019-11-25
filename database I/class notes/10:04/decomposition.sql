drop table BookLit cascade constraints; 
drop table Publisher cascade constraints;

create table Publisher (
   PubID number(3) Primary Key,
   Name varchar2(50),
   City varchar2(25),
   Country varchar2(25)
);

insert into Publisher values(100, 'Penguin Group', 'London', 'United Kingdom');
insert into Publisher values(101, 'Bloomsbury Publishing', 'London', 'United Kingdom');
insert into Publisher values(102, 'Greenleaf Book Group', 'Austin', 'United States');
insert into Publisher values(103, 'Wordsworth Editions', 'Hertfordshire', 'United Kingdom');
insert into Publisher values(104, 'Verlag Antje Kunstmann', 'Munich', 'Germany');
insert into Publisher values(105, 'Ouroboros Press', 'Seattle', 'United States');
insert into Publisher values(106, 'Grup 62', 'Barcelona', 'Spain');
insert into Publisher values(107, 'Rhemalda Publishing', 'Moses Lake', 'United States');
insert into Publisher values(108, 'Antonio Machado Libros', 'Madrid', 'Spain');
insert into Publisher values(109, 'Simon and Schuster', 'La Jolla', 'United States');
insert into Publisher values(110, 'MIT Press', 'Cambridge', 'United States');
insert into Publisher values(111, 'Scholastic', 'Markham', 'Canada');
insert into Publisher values(112, 'Scholastic', 'New York', 'United States');

create table BookLit (
   ISBN char(10) Primary Key,
   FirstName varchar2(15),
   LastName varchar2(15),
   Title varchar2(50) Not Null,
   copyright number(4,0),
   price number(5,2),
   PubID number(3) References Publisher(PubID)
);

insert into BookLit values('0679783261', 'Jane', 'Austen', 'Pride and Prejudice', 1813, 15.24, 100);
insert into BookLit values('0061120081', 'Harper', 'Lee', 'To Kill a Mockingbird', 1960, 7.43, 106);
insert into BookLit values('0142437204', 'Charlotte', 'Bronte', 'Jane Eyre', 1847, 22.1, 111);
insert into BookLit values('0743273567', 'F. Scott', 'Fitzgerald', 'The Great Gatsby', 1925, 45.12, 109);
insert into BookLit values('0393978893', 'Emily', 'Bronte', 'Wuthering Heights', 1847, 23.99, 111);
insert into BookLit values('0141439661', 'Jane', 'Austen', 'Sense and Sensibility', 1811, 46.17, 103);
insert into BookLit values('0316769177', 'J.D.', 'Salinger', 'The Catcher in the Rye', 1951, 87.25, 101);
insert into BookLit values('0451529308', 'Louisa', 'Alcott', 'Little Women', 1868, 17.95, 104);
insert into BookLit values('0451524934', 'George', 'Orwell', '1984', 1949, 16, 110);
insert into BookLit values('0743477111', 'William', 'Shakespeare', 'Romeo and Juliet', 1595, 29.54, 104);
insert into BookLit values('0142437263', 'Nathaniel', 'Hawthorne', 'The Scarlet Letter', 1850, 16.32, 107);
insert into BookLit values('0142000671', 'John', 'Steinbeck', 'Of Mice and Men', 1937, 34.99, 109);
insert into BookLit values('0192833596', 'Charles', 'Dickens', 'Great Expectations', 1861, 37.56, 107);
insert into BookLit values('0140283331', 'William', 'Golding', 'Lord of the Flies', 1954, 41.32, 106);
insert into BookLit values('0452284244', 'George', 'Orwell', 'Animal Farm', 1945, 4.22, 108);
insert into BookLit values('0141439602', 'Charles', 'Dickens', 'A Tale of Two Cities', 1859, 75.02, 105);
insert into BookLit values('0142437174', 'Twain', 'Mark', 'The Adventures of Huckleberry Finn', 1840, 10.44, 112);
insert into BookLit values('0375751513', 'Oscar', 'Wilde', 'The Picture of Dorian Gray', 1890, 88.76, 104);
insert into BookLit values('0143039954', '', 'Homer', 'The Odyssey', -800, 99.99, 111);
insert into BookLit values('0393970124', 'Bram', 'Stoker', 'Dracula', 1897, 1.25, 102);
insert into BookLit values('0143058142', 'Fyodor', 'Dostoyevsky', 'Crime and Punishment', 1866, 61.06, 107);
insert into BookLit values('1561797464', 'Charles', 'Dickens', 'A Christmas Carol', 1843, 32.14, 109);
insert into BookLit values('0007491565', 'Ray', 'Bradbury', 'Fahrenheit 451', 1953, 8.41, 109);
insert into BookLit values('0441788386', 'Robert', 'Heinlein', 'Stranger in a Strange Land', 1961, 92.13, 103);
insert into BookLit values('0140275363', '', 'Homer', 'Iliad', -800, 15.26, 107);

create table bookpub as

   select *
   from booklit natural join publisher;


select * from bookpub;
