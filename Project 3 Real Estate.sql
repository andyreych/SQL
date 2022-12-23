
/* Project 3*/ 

create database sample_2;-- We just created the database sample_2 in which we will create the 
--tables and their following columns, and values.

use sample_2; --We made succesful connection to the
--sample_2 database we just created.

/* In this case we are going to create tables for a real estate company with the following tables: Agents,
Properties, Customers, and Transactions*/
create table agents (emp_id char(12) primary key,--The primary key is employee id
agent_fname char(25) not null,
agent_lname char(25) not null,
contact_info char(14) not null);

create table customers( customer_id char(20) primary key,
customer_fname char(25) not null,
customer_lname char(25) not null,
zip_code int null,
contact_no char(14) not null,
emp_id char(12) not null,
constraint FK_sales_customer foreign key (emp_id) references Agents(emp_id));

create table properties( property_id char(20) primary key,
property_description char(25) not null,
property_city char(25) not null,
property_address varchar(25) null,
zip_code int null,
property_bedrooms int null,
property_bathrooms int null,
size_sqft varchar(14) not null,
property_enter_date date not null,
listed_price int not null,
emp_id char(12) not null,
constraint FK_sales_properties foreign key (emp_id) references Agents(emp_id));;

select *from properties; 

create table transactions (transaction_id int primary key,
customer_id char(20) not null,
property_id char(20) not null,
emp_id char(12) not null,
sales_price money not null,
enter_date datetime not null
constraint FK_customer_sales foreign key (customer_id) references customers(customer_id),
constraint FK_properties_sales foreign key (property_id) references properties(property_id),
constraint FK_agent_sales foreign key (emp_id) references Agents(emp_id));

select *from transactions;

insert into agents values ('R001','Barack','Obama','333-333-1234'),
('R002','George','Bush','333-333-1235'),('R003','Bill','Clinton','333-333-1236'),
('R004','Hillary','Clinton','333-333-1237'),('R005','Joe','Biden','233-333-1238'),
('R006','Saddam','Hussein','333-333-1239'),('R007','Hugo','Chavez','333-333-1240'),
('R008','Vladimir','Putin','333-333-1241'), ('R009','Donald','Trump','333-333-1242'),
('R010','Muammar','Al-Gaddafi ','333-333-1243');

select *from agents;

insert into customers values ('Cust001','Michelle','Obama',20500,'499-000-0011','R001'),
('Cust002','Laura','Bush',77032,'499-010-0011','R002'),('Cust003','Monica','Lewinsky',94016,'469-000-0011','R003'),
('Cust004','Norge','Pena',20473,'479-000-0011','R004'),('Cust005','Kamala','Harris',20173,'499-050-0011','R005'),
('Cust006','Nidal','Al-Hamdani',20174,'499-000-0111','R006'), ('Cust007','Cristina','Kirchner',20175,'499-000-3111','R007'),
('Cust008','Lyudmila','Ocheretnaya',20176,'499-000-1111','R008'),('Cust009','Melania','Trump',20177,'499-000-5111','R009'),
('Cust010','Safia','Farkash',20176,'499-200-1111','R010');

select *from customers;

select *from properties;
insert into properties values 
('P001', 'Apartment', 'Miami','1300 S Miami Ave',33130,'3','3','1281','11/2/2021','1040000','R001'),
('P002', 'Apartment', 'Miami','1300 Brickell Bay Dr',33131,'4','5','3273','12/14/2021','2919000','R002'),
('P003', 'Apartment', 'Miami','2127 Brickell Ave',33129,'3','4','2600','5/12/2015','1800000','R003'),
('P004', 'Apartment', 'Miami','465 Brickell Ave',33131,'3','3','1825','10/4/2021','1399000','R004'),
('P005', 'Apartment', 'North Miami Beach','18975 Collins Ave',33160,'3','4','2271','7/17/2021','3450000','R005'),
('P006', 'Apartment', 'North Miami Beach','17121 Collins Ave',33160,'4','5','2485','8/12/2021','3100000','R006'),
('P007', 'Apartment', 'North Miami Beach','18501 Collins Ave',33160,'3','5','3110','11/2/2021','4700000','R007'),
('P008', 'Apartment', 'North Miami Beach','15701 Collins Ave',33160,'3','4','2137','02/08/22','4359000','R008'),
('P009', 'Apartment', 'Miami Beach','450 Alton Rd',33139,'3','4','2145','1/7/2022','4100000','R009'),
('P010', 'Single Family', 'Miami Beach','1777 Daytonia Rd',33141,'4','3','3208','1/7/2022','3350000','R010');

select *from properties;

insert into transactions values 
('001', 'Cust001', 'P001','R001','1040000','12/2/2021'),
('002', 'Cust002', 'P002','R002','2627100','2/2/2022'),
('003', 'Cust003', 'P003','R003','1620000','2/2/2020'),
('004', 'Cust004', 'P004','R004','1259100','11/2/2021'),
('005', 'Cust005', 'P005','R005','3105000','2/2/2022'),
('006', 'Cust006', 'P006','R006','2790000','1/2/2022'),
('007', 'Cust007', 'P007','R007','4700000','1/28/2022'),
('008', 'Cust008', 'P008','R008','4359000','2/25/2022'),
('009', 'Cust009', 'P009','R009','4100000','1/25/2022'),
('010', 'Cust010', 'P010','R010','3350000','1/25/2022');

select * from transactions; 

select * from properties 
where listed_price between 3000000 and 4000000; 
/*By using the above query 
We get the results of all of the properties in which the listed price is between 3000000 and 4000000*/

SELECT transactions.transaction_id, transactions.customer_id, transactions.sales_price
FROM transactions JOIN properties
on transactions.property_id=properties.property_id
where listed_price=sales_price;
/*  In this query we are asking the database to gives us the transaction id, the customer_id , and 
the sales price from the transaction table joining the properties table in which 
the listed price equals the sales price*/ 

select  properties.property_description,properties.property_address,properties.listed_price, properties.property_enter_date
from properties join transactions
on properties.property_id=transactions.property_id
where listed_price=sales_price+(listed_price*0.10);
/* By using this query we are asking the database to select the properties description, 
address, listed price, and property enter date where the listed price is 10% above 
the sales price. By using this query we can come to the conclution which properties were sold 
at 10% less of the listed price*/ 

--First let us add the old_price column to the transactions table
alter table transactions 
add old_price int;

update transactions
set old_price=sales_price-(sales_price*0.20);

Select *from transactions;

select property_address, listed_price
into #propertytemp
from properties;

select *from #propertytemp;


