--Welcome to Lecture VII, Chapter V.

CREATE DATABASE MATTRESS;-- First we create the database in which we will work on that in this case is going to be 
--named MATTRESS

USE MATTRESS;-- This query is used to make sure we are connected to the database that we just created.

CREATE TABLE EMPLOYEES( -- Now we proceed with creating a table with the following columns: Employee_Id,Employe_FName, and Employee_Lname.
  	EMPLOYEE_ID INT PRIMARY KEY,
  	EMPLOYEE_FNAME CHARACTER(50),
              EMPLOYEE_LNAME CHARACTER(50));--use of not null for both fields

-- Insert data into the table EMPLOYEES

INSERT INTO EMPLOYEES (EMPLOYEE_ID, EMPLOYEE_FNAME,EMPLOYEE_LNAME)
VALUES (101,'George','Smith'),
  	   (102, 'Sarah','Young'),
  	   (103,'Paul','Rodriguez'); /* By using the query INSERT INTO we can proceed to add the values*/

select *from EMPLOYEES;

CREATE TABLE PRODUCTS(
PRODUCT_ID INT PRIMARY KEY,
PRODUCT_NAME CHARACTER(50) NOT NULL,
PRODUCT_PRICE MONEY NOT NULL);
--Add not null to both fields, product name and product price
/* We already changed the not null values into the column*/

select *from PRODUCTS;-- With this query we confirm that the columns were properly added into the table

/*The ALTER TABLE statement modifies the schema of a table. 
The Transact-SQL language allows the following types of alteration:  
   
Add or drop one or more columns    
Modify column properties     
Add or remove integrity constraints     
Enable or disable constraints     
Rename tables and other database objects 
 
Adding or Dropping a Column: You can use the ADD clause of the ALTER TABLE 
statement to add a new column to the existing table. Only one column can be 
added for each ALTER TABLE statement. */

USE MATTRESS;

ALTER TABLE PRODUCTS
ADD Business_no Char (10) not null;/* By using this query we succesfully added another column into the PRODUCTS table*/


/*Using a similar query I would like you to add another column 
to the table PRODUCTS. Make comments about your choice for the data type.*/

ALTER TABLE PRODUCTS
ADD Product_Size Char (20);

SELECT * FROM PRODUCTS;-- This query confirms that the columns were successfully added

/*The DROP COLUMN clause provides the ability to drop an existing column of 
the table. Let us now create a query to drop the column (Business_no) that we 
just added to the existing database.*/

Use MATTRESS;
Alter table PRODUCTS
Drop Column Business_no;
SELECT * FROM PRODUCTS-- By using this query we can confirm that we succesfully dropped the
-- Business_no column.

/*Using a similar query I would like you to drop the column that you had 
previously added to the table PRODUCTS table (Make this activity as a comment,
do not actually drop that column). 

/*
Use MATTRESS;
Alter table PRODUCTS
Drop Column Produce_Size;
*/

Modifying Column Properties 

The Transact-SQL language supports the ALTER COLUMN clause of ALTER TABLE 
to modify the properties of an existing column. The following column 
properties can be modified: 

 Data type    
 Nullability

Let us make use of the ALTER COLUMN clause:
*/

Use MATTRESS;

ALTER TABLE PRODUCTS
ADD Business_Name Char (10) not null;

Alter table PRODUCTS
Alter column BUSINESS_NAME CHARACTER(20) not null;

SELECT* FROM PRODUCTS;


/*Make comments about the error message and propose a solution

I did not receive an error message while running lines 85 - 89 because the table was not populated.

We have just changed the previous properties (CHAR(?), nullable?) of the 
Business_Name column of the PRODUCTS  table to new properties (CHAR(20), 
not nullable).

I would like you to create a similar query that alters  the column 
Products_Name. Make comments about your query and the changes made to 
the column.*/

ALTER TABLE PRODUCTS
Alter column Product_Name Char(30) not null;

/*So far we have two tables with multiple columns; therefore I would like you
all to create one or two tables to make this tables an actual relational
database.(hint:No inventory table)

Employees(I would add contact_info &.....)
Products (I would add product_cost,location,description,size,model and brand)

Good candidates for a third table would be:
Transactions and/or Customers.*/
CREATE TABLE Customers(
CUSTOMER_ID INT PRIMARY KEY,
CUSTOMER_NAME CHARACTER(50) NOT NULL,
CONTACT_INFO CHARACTER(50) NULL);
SELECT * FROM Customers;-- By 
--Using this query I can confirm I succesfully added the columns into the Customers Table that 
--I just created-- 

