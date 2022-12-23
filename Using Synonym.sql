use AdventureWorks2019;
create synonym PriceHistory for Production.ProductListPriceHistory; 
/* Interpret the syntax and the output. In your own words explain the needs for us to create a synonym for this table.
 Due to the fact that the table Production.ProductListPriceHistory 
 of this table refers to the Price History of the product, it's far 
 easier to create a synonym such as PriceHistory to refer to this table*/ 

 /*Now, please run a similar query that creates a synonym for 
 the Production.ProductModelProductDescriptionCulture table in the Production schema.*/
 CREATE SYNONYM Prod_model2 for Production.ProductModelProductDescriptionCulture; 
 select * from Prod_model2

 /* Let us create the data type zip based on the standard data type SMALLINT. 
 This user-defined data type can now be used as a data type of a table column*/

 Use sample;-- First we connect to the sample database
Create type zip from smallint not null;/*By using the Create type zip we are creating a data type named zip based of 
 the smallint data, this is because we are going to use this data type for the zip_code column of the customer table.
 In addition, we set the data type not null so no blank values are permitted.
 Furthermore, The smallint data type stores small whole numbers that range from –32,767 to 32,767. 
 By creating the data type zyp from the smallint we can store whole numbers
 from that range to store the zip codes of the customer table below.*/

--Interpret the syntax and the output. Next, 
--drop the customer table (Drop table customer)from the sample database and thereafter run the query below:
-- First I'm going to create the customer table because it is not existent in our sample database

Use sample;-- First we connect to the sample database to create the table customer
create table customer
   	(cust_no int not null,
	cust_name char(20) not null,
	city char(20),
	zip_code  zip,-- As we can see the data type of the zip_code column is zip the one we created previously.
	check (zip_code Between 601 and 99950));-- By using the check constraint we limit the values of the zip_code 
	-- column from 601 to 99950. 

-- Now I will proceed by drop the table customer that I just created. 
DROP table customer;-- By using the DROP table command we delete the table permanently.
/*Interpret the syntax and the output. In addition, recreate a similar case scenario to the one 
found in the two queries above. In other words, 
run two queries that approach a critical problem similar to the one listed in the queries above. */
use AdventureWorks2019;
CREATE SYNONYM Product_Photo for Production.ProductPhoto;/* By creating a synonym for the Production.ProductPhoto
we can refer to this table by using a shorter reference such as "Product_Photo" */ 
SELECT * FROM Product_Photo;-- As we can see the synonym was created successfully--

Use sample;-- We are going to connect to the sample database to approach a critical problem similar to the one above

Create type StateID from char(2) not null; /* First we are going to create a data type named StateID from the char(2) 
data type so we can only use 2 characters which are the StateProvinceID of each state such as FL for Florida, CA for 
California, and so forth. In addition, we use the not null command so there is no blank spaces permitted in the column*/

create table customer_address
   	(AddressID int not null,
	AddressLine1 nvarchar(60) not null,
	City nvarchar(30),
	StateProvinceID StateID, -- As we can see the Data type StateID was recognized for the database and will only allow 2 characters
	-- In addition, the not null command will not allow blank spaces in the column.
	zip_code zip ,-- The data type "zip" is already created so the zip_code column will follow the procedure we used before.
	check (zip_code Between 786 and 33178));-- By using the check constrain we limit the values of the zip_code
	-- from 786 to 33178

Select * from customer_address; -- As we can see the table was created successfully















