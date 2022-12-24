/*Welcome to Lecture IX (Chapter XIII, Managing Tables). Almost every database has one
thing in common: they all use tables to store data. In this chapter, I’ll present recipes that
demonstrate table creation and manipulation. Tables are used to store data in the database,
and they are the central unit upon which most SQL Server database objects depend. Tables are
uniquely named within a database and schema and contain one or more columns. Each column
has an associated data type that de?nes the kind of data that can be stored within it. First, we
are going to start by running a query that creates a new table.*/

Use AdventureWorks2019;
CREATE TABLE dbo.Person (
PersonID INT IDENTITY CONSTRAINT PK_Person PRIMARY KEY CLUSTERED,
--We selected PersonID as our primary key of this table with a data type of integer
--By using the IDENTITY CONSTRAINT property set in PersonID  this column is autopopulated and has a clustered primary key constraint
--Therefore, the personid is set to not null
--The term clustered means that a clustered index defines the order in which data is physically stored in a table. 
BusinessEntityId INT NOT NULL
--We have a second column named BusinessEntityID with integer data type and does not allow null values
CONSTRAINT FK_Person REFERENCES Person.BusinessEntity --BusinessEntityID is a foreign key
--that refers to the BusinessEntityID in the Person table.	
(BusinessEntityID),
First_Name VARCHAR(50) NOT NULL)
--In addition we have a third column named First_Name with a VARCHAR data type with limit of 50 characters and does not null values;

/*Now I would like you to make comments about the syntax we used in the query above as well
as the output (if any). Run a similar query that executes a similar task recreating a totally
different case scenario. Be as creative as possible and make comments about your choice.*/
Use AdventureWorks2019;
CREATE TABLE dbo.Product(
Product_ID INT IDENTITY CONSTRAINT PK_Product PRIMARY KEY CLUSTERED,
ProductCategoryID INT NOT NULL CONSTRAINT FK_Product REFERENCES [Production].[ProductCategory]([ProductCategoryID]),
Product_Name varchar(50)NOT NULL
);
/* In this query we created a table named dbo.Product in which we have Product_ID as primary key with a integer data type with indentity constraint to 
autopopulate the column. In addition, we cretaed a second column named ProductCategoryID that is being used as a foreign key 
that references the ProductCategory column from the Production.ProductCategory. Finally, we created a third column named Product_name with a varchar data type up to 
50 characters*/

/*Now let us add a new column to the existing table we created in the example above.*/

ALTER TABLE dbo.Person ADD Last_Name VARCHAR(50) NULL;
-- In this query we alter the table we created previously dbo.Person and we added fourth column named Last_Name with a varchar data type up to 50 characters which makes sense because 
--we needed the last name of the person of the previous table

/*Make comments about the query above and explain the impact of such a query in the existing
table. Thereafter, add a new column to the table you just created above. Explain your choice.*/

ALTER TABLE dbo.Product ADD Price int not null;
/* In this query we are adding a column named price with a integer data type in which we are describing
the price of the product which was missing in the previous query*/

/*Let us now create a computed column using an existing table from our training database.*/

ALTER TABLE Production.TransactionHistory

ADD CostPerUnit AS (ActualCost/Quantity);
-- In this query we are creating a new computed column named CostPerUnit in which we divided the ActualCost with the Quantity to calculated the Cost per Unit


CREATE TABLE HumanResources.CompanyStatistic
--We are creating a new table named HumanResources.CompanyStatistic
( CompanylD int NOT NULL,-- We are creating a new column named CompnayID with an integer datatype and it does not allow null values
StockTicker char(4) NOT NULL,-- We are creating a column named StockTicker with a char data type limited to 4 charcters and does not allow null values
SharesOutstanding int NOT NULL,-- We are creating a column named SharesOutstanding with a integer data type and does not allow null values.
Shareholders int NOT NULL,-- We are creating a column named Shareholders with a integer data type and does not allow null values
AvgSharesPerShareholder AS (SharesOutstanding/Shareholders) PERSISTED);-- We are creating a computed column named AvgSharesPerShareholder in which we divide the previous columns
-- SharesOutstanding by the Shareholders to calculate the AvgSharesPerShareholder. In addition, we using the persisted clause to store the computed values in the table, and update the values when any other columns on which the computed column depends are updated.

/*I would like you to make comments about the syntax as well as the effect of the query above
on the HumanResources.CompanyStatistic table. Thereafter, execute a similar task using a
different case scenario in our AdventureWorks2017 database. Explain the query as well
as the results.*/

CREATE TABLE Students( -- We are creating a table named Students in which:
Student_ID int not null PRIMARY KEY,-- The Student_ID is a columnthat  has a integer data type and it's going to be our primary key in this table and does not allow null values
Student_Name varchar not null,-- Here we created a column name the Student_name using a varchar data type and does not allow null values
Course_Category char(3) not null,-- Here we created a column named Course Category using a char data type and limited to 3 characters as used to categorize courses and does not allow null values
Course_Code int not null,-- We created a column named Course_code to further specify which class of the course category the student is taking and does not allow null values
GPA_Units int not null,-- We created a column named GPA_Units with a integer data type to calculate the GPA_Units of each class
Points_Earned int not null,-- We created a column named Points_Earned to calculate the points earned for each class 
Term_GPA AS (Points_Earned/GPA_Units) PERSISTED
-- Finally, we created a computed calculated column named Term_GPA diving the two previous columns: Points_Earned by GPA_Units as well as using the PERSISTED function 
--  to store the computed values in the table, and update the values when any other columns on which the computed column depends are updated.
);


/*Now using example 13.6 from the book I would like you to remove a column of your choice
from the table dbo.Person.Next, run a different query to actually drop the table dbo.Person.*/
ALTER TABLE dbo.Person DROP COLUMN Last_Name
DROP TABLE dbo.Person

/*You need to ensure that if you don’t specify a column when inserting data into the table, a
default value is used to populate that column. For*/


