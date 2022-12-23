/*Welcome to CTS 2433 (SQL Implementation). 
Let us start by connecting to the AdventureWorks2017 database we downloaded in our SQL Administration class.*/

USE AdventureWorks2019; -- By using this command we are connecting to the AdventureWorks2019 database.

/*Let us now use the SELECT statement to retrieve data from the AdventureWorks2019 training database
to run the following query.*/
SELECT NationalIDNumber,LoginID,JobTitle FROM HumanResources.Employee; 
/* By using this query we are selecting the followings columns from the Human.Resources.Employee Table: NationalIDNumber,
LoginID, and Job Title*/ 

/*I would like you to briefly explain the output of the query ran above. In addition,let us run a query that displays 
all the columns from the HumanResources.Employee table.*/

SELECT * FROM HumanResources.Employee; -- By using the SELECT * from command we are selecting all of the
-- columns of the HumanResources.Employee table.
/*Let us make sure now that we specify the rows that we want to be returned. 
What is the expected output in the query we are going to run below?*/

SELECT Title,  FirstName,  LastName FROM Person.Person WHERE Title= 'Ms.';
/* By using this command we are selecting the Title, First Name, and Last Name 
from the Person.Person table only of the records where the Title= Ms*/

/*Let us now retrieve the first and last name of every element in the Person.Person 
table where the person's title is 'Mr.'*/

SELECT Title,  FirstName,  LastName FROM Person.Person WHERE Title= 'Mr.';
/* By using this query we are retrieving the Title, First Name, and 
Last name of all the records from the Person.Person Table where the Title is 'Mr'*/ 

/*Now I would like you to create a similar query (similar syntax) to retrieve information from a different table.
Explain your query and report results.*/

SELECT  BusinessEntityID, PayFrequency, Rate FROM HumanResources.EmployeePayHistory WHERE Rate Between 30 and 40;
/* By using this query we are retrieving the BusinessEntityID, PayFrequency, and Rate from the 
HumanResources.EmployeePayHistory where the rate is between 30 and 40.*/ 

/*From the following operator table I would like you to inspect every definition and to incorporate one of these operators to the simplest query you have in mind.
Please explain the results.*/

/*Table 1-1. Operators
Operator	Description
!=	Tests two expressions not being equal to each other.
!>	Tests whether the left condition is less than or equal to (i.e., not greater than) the condition on the right.
!<	Tests whether the left condition is greater than or equal to (i.e., not less than) the condition on the right.
<	Tests the left condition as less than the right condition.
<=	Tests the left condition as less than or equal to the right condition.
<>	Tests two expressions not being equal to each other.
=	Tests equality between two expressions.
>	Tests the left condition being greater than the expression to the right.
>=	Tests the left condition being greater than or equal to the expression to the right.*/

SELECT  BusinessEntityID,PayFrequency, Rate FROM HumanResources.EmployeePayHistory WHERE Rate>40;
/* By using the operator > (greater than) we are retrieving the BusinessEntityID, Pay Frequency and Rate 
where the Rate is greater than 40*/ 

/*Run the query below and explain the output. In addition, let us create a similar query using a different table. 
It is important that we explain the query we are creating as well as the output in detail.*/

SELECT BusinessEntityID AS "Employee ID", VacationHours AS "Vacation", SickLeaveHours AS "Sick Time"
FROM HumanResources.Employee; /*By using this query we are renaming the columns Business EntityID as 
"Employee ID", VacationHours as "Vacation", and SickLeaveHours as "Sick Time" from the HumanResources.Employee.*/ 

SELECT CarrierTrackingNumber AS "Tracking Number", UnitPriceDiscount AS "Discount per Unit" , SalesOrderID AS "Order ID"
FROM Sales.SalesOrderDetail; /* By using this query we are renaming the columns CarrierTrackingNumber as "Tracking Number",
 UnitPriceDiscount as "Discount per Unit", and SalesOrderID as "Order ID" from the Sales.SalesOrderDetail */

 /*Let us now create a column from an expression. We are creating a column by adding two columns from the HumanResources.
 Employee table in the AdventureWorks2019 database.*/
 SELECT BusinessEntityID AS EmployeelD, VacationHours + SickLeaveHours AS AvailableTimeOff FROM HumanResources.Employee;
 /*Now I would like you to run a similar query (syntactically speaking) and perform a similar task using a different table.*/
 SELECT SalesOrderID AS OrderID, UnitPrice + UnitPriceDiscount AS FullPrice FROM Sales.SalesOrderDetail; 
/* By using this query we are creating a column by adding the Unit Price and the Unit Price Discount 
from the Sales.SalesOrderDetail*/ 
/*Now let us use the Not operator in a search condition to basically reverse description and obtain what we want.*/
 
SELECT Title,  FirstName,	LastName
FROM Person.Person
WHERE NOT (Title = 'Ms.' OR Title = 'Mrs.');
/* The query above is retrieving the Title, First Name, and LastName 
from the Person.Person table where the Title is NOT 'Ms' or 'Mrs'. So in this 
case only the records where the Title is Mr and Sr were retieved*/

/*Please explain the query above in detail. In addition, create a similar query to 
retrieve critical information from another table.
If possible, use a different operator and explain your choice in detail.*/

SELECT SalesOrderID,CarrierTrackingNumber, OrderQty, UnitPrice
FROM Sales.SalesOrderDetail
WHERE NOT (CarrierTrackingNumber='NULL'); 
/* In this case we are using the not operator to retrieve the SalesOrderID, 
CarrierTrackingNumber, OrderQty, and Unit Price all of the records from the 
Sales.SalesOrderDetail in which the CarrierTrackingNumber is not Null*/ 

/*Let us now start dealing with null values. We know from last semester the importance of understanding 
the information contained in a column, especially when there are null values. Let us run a query 
that will return any row for which the value of the product's weight is unknown.*/
SELECT ProductID, Name, Weight FROM Production.Product
WHERE Weight IS NULL;

/*Create a similar query to retrieve critical information from a different table.
I encourage you to be as creative as possible and to report results.
Assume you are reporting results to the project's sponsor.*/

SELECT ProductID, Name,ListPrice FROM Production.Product
WHERE DiscontinuedDate IS NULL; 
/* In this query we are retrieving the ProductID, Name, and ListPrice from the Production.Product table 
in which the DiscontinuedDate is null.In other words , the product has not been discontinued yet*/ 

/*Wildcard	Usage
%	The percent sign. Represents a string of zero or more characters.
The underscore. Represents a single character.


[... ]	A list of characters enclosed within square brackets. Represents a single character from among any in the list.
You may use the hyphen as a shorthand to translate a range into a list. For example, 
[ABCDEF]-flat can be written more succinctly as[A-F]-flat.You can also mix and match single characters and ranges. 
The expressions[A-CD-F]-flat, [A-DEF]-flat, and [ABC-F]-flat all mean the same thing and ultimately resolve to [ABCDEF]-flat.*/
 
/*[A   ]	A list of characters enclosed within square brackets and preceded by a caret. 
Represents a single character from among any not in the list.*/

/*The following example demonstrates using the LIKE operator with the% and underscores wildcards, 
searching for any product with the letter B as the second character.*/

SELECT ProductID, Name
FROM Production.Product WHERE Name LIKE '_B%';
/* In this query we are retrieving the ProductId, Name from the Production.Product Where Name has values where
B is a second character. The role of the underscore wildcard (_) is to specify what character must follow after that, which in 
this case is the letter B as a second character*/ 

/*Please explain the output obtained after running the query above and list the role of the underscore wildcard in this query if any.
In addition, run an identical query (ProductCategoryID,Name) 
but this time retrieving information from the table Production.ProductCategory,
please explain the output and make corrections in case there was a potential error.*/
SELECT ProductCategoryID, Name 
FROM Production.ProductCategory WHERE Name Like '_O%'; -- In this case the output was the ProductCategoryID, and the Name 
-- of all the records from the Production.ProductCategory table in which O is the second character. In this case is components.

/*Let us now go to the Production.ProductDescription table and change the description of the High-Density Rubber whose ID is 909 ,then let us add to the description that the inventory for this product is very low.*/

UPDATE Production.ProductDescription
SET Description= 'High-density rubber. Very low inventory' WHERE ProductDescriptionID = 909;

/*Now I invite you to add information to the description of any other product in the same table. 
Explain the design of your query as well as the output. 
In addition, use again the wildcard characters to retrieve information from the table mentioned above.*/
 
UPDATE Production.ProductDescription
SET Description= 'Wide Link Design' WHERE ProductDescriptionID = 2010; 
-- As I could observe before retrieving the records, the product description of the productdescription id'2010'
--was in Chinese and I decided to update the description in english.

SELECT ProductDescriptionID,Description
FROM Production.ProductDescription WHERE Description LIKE '_i%';
