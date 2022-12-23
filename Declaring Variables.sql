/*Welcome to Lecture 2 (Chapter 2). We are going to start by declaring variables but in order to do so 
we have to first connect to the AdventureWorks2019 database. */ 
 
Use AdventureWorks2019; 
/*In our first query today we want to build a search string, then store that search string into a variable, and reference the string in the WHERE clause of a subsequent query. Run the query 
and explain the output.*/ 
DECLARE @AddressLine1 nvarchar(60) = 'Heiderplatz'; 
SELECT AddressID, AddressLine1 
FROM Person.Address 
WHERE AddressLine1 LIKE '%' + @AddressLine1 + '%'; 
--Saved string Heiderplatz in a variable @AddressLine1 and used it to filter Person.Address, the columns that are displayed are AddressID and AddressLine1

 
 
/*Now let us run a query that returns the two address lines for address #66 in the 
Person.Address table. Please explain in detail each line of code. */ 

DECLARE @AddressLine1 nvarchar(60); --Declare variable @AddressLine1 of type nvarchar with 60 character lenght
DECLARE @AddressLine2 nvarchar(60);  --Declare variable @AddressLine2 of type nvarchar with 60 character lenght
SELECT @AddressLine1 = AddressLine1, @AddressLine2 = AddressLine2 ----Assigning variables declared previously so @AddressLine1 = AddressLine1 (in table Person.Address) and @AddressLine2 = AddressLine2 (in table Person.Address)
FROM Person.Address WHERE AddressID=66; --The information is being taken from Person.Address only WHERE the AddressID is equal to 66
SELECT @AddressLine1 AS Address1, @AddressLine2 AS Address2; --The last select is to use the variables with an alias to name each column

/*What if instead we ran a similar query for the Production.Location table. Fix the syntax in 
case it was needed. Would you have done anything different in this exercise?*/ 
DECLARE @Name nvarchar(50); 
DECLARE @CostRate smallmoney; 
SELECT @Name = Name, @CostRate = CostRate 
FROM Production.Location
WHERE LocationID = 60; 
SELECT @Name AS Name, @CostRate AS CostRate; 
--There is nothing I would change in this case


/*Let us now start working with boolean operators and conditional paths. Let us run the query below.*/ 
DECLARE @QuerySelector int = 3; 
IF @QuerySelector = 1 BEGIN SELECT TOP 3 ProductID, Name, Color 
FROM Production.Product 
WHERE Color = 'Silver' 
ORDER BY Name 
END 
ELSE 
BEGIN 
SELECT TOP 3 ProductID, Name, Color 
FROM Production.Product 
WHERE Color = 'Black' 
ORDER BY Name 
END; 

/*Now, let us interpret every single line of code as well as the syntax of the whole query. Report 
results and interpret the output. */ 
DECLARE @QuerySelector int = 1;--Declaring a variable named @QuerySelector of type int and assigning the value 1
IF @QuerySelector = 1 --Conditional statement that if met (which in this case it does not) then the code after the first Begin and before the first end will run
BEGIN 
SELECT TOP 3 BusinessEntityID, PersonType, Title-- We are selecting the BusinessEntityId, PersonType, and Title
FROM Person.Person-- from the Person.Person table
WHERE Title = 'Ms.' -- Where the Title is 'Ms.'
ORDER BY PersonType-- In addition, we ordering the output by PersonType
END --End of this part of the query
ELSE -- The else acts as If not in this case if the @queryselector was not =1 the output would be the following
BEGIN --Begin the conditional statement
SELECT TOP 3 BusinessEntityID, PersonType, Title--We are selecting the BusinessEntityId, PersonType, and Title
FROM Person.Person--from the Person.Person table 
WHERE Title = 'Mr.'-- Where the Title is 'Mr.'
ORDER BY PersonType 
END; 

/*Please explain the output as well as the syntax used in the query above. */ 
/* In the query above we were selecting BusinessEntityID, PersonType, and Title 
and the output was ordered by the Persontype and the records selected satisfied the
statement in which if the @queryselector is =1 the records retrieved must be where the title is 'Ms'*/

/*Writing a simple case expression has proven to be very useful for cases when we want to specify an 
output value for each possible single input value. Let us run the query below and 
interpret the output. */

SELECT DepartmentID AS DeptID, Name, GroupName, 
CASE GroupName 
WHEN 'Research and Development' THEN 'Room A' 
WHEN 'Sales and Marketing' THEN 'Room B' 
WHEN 'Manufacturing' THEN 'Room C' 
ELSE 'Room D' 
END AS ConfRoom 
FROM HumanResources.Department; 
/* In this query we are setting a new alias for the column DepartmentID as DeptID. In addition, we are
creating contents of ConfRoom column  based on conditions which are :'Research and Development' would be assigng to the column ConfRoom "Room A", 
'Sales and Marketing' assigned to Conf Room "Room B",and 'Manufacturing' assigned to ConfRoom "Room C" 
and all the other ones will be assigned to "Room D" from the HumanResources.Department Table*/



/*Let us now run a query that has multiple purposes. Interpret it.*/

SELECT DepartmentID, Name, 
CASE WHEN Name = 'Research and Development' THEN 'Room A' 
WHEN (Name = 'Sales and Marketing' OR DepartmentID = 10) THEN 'Room B'
WHEN Name LIKE 'T%'THEN 'Room C' 
ELSE 'Room D' END AS ConferenceRoom 
FROM HumanResources.Department; 

/* We are selecting DepartmentID, Name and ConferenceRoom based on contents of the Name and DepartmentID columns.
Room A is determined by Name= ' Research and Development', Room B is determined by Name = 'Sales and Marketing'
or DepartmentID='10' , Room C is determined by Name field in which 'T' is the first character, and room D determined for  
all of the other values that don't satisfy the previous conditions.*/ 


/*Welcome to (Chapter III). A NULL value represents the absence of data, in other words, data that is missing or unknown. 
When coding queries, stored procedures, or any other T-SQL, it is important to keep in mind the nullability of data because 
it will affect many aspects of your logic. For example, the result of any operator (for example, +, -, AND, and OR)
when either operand is NULL is NULL.

NULL + 10 = NULL
NULL OR TRUE = NULL
NULL OR FALSE = NULL
*/


/*Table 3-1. NULL Functions

Function    	Description
ISNULL:     	ISNULL validates whether an expression is NULL and, if so, replaces the NULL value with an alternate value.
COALESCE:   The COALESCE function returns the first non-NULL value from a provided list of expressions.
NULLIF:     	NULLIF returns a NULL value when the two provided expressions have the same value. Otherwise, the first expression is returned.
*/

/*(Replacing NULL with an Alternate Value) In the query below we are going to use the ISNULL function in such a way that when the record for 
credit approval shows null, the system displays "No Approval". The reason being that the table we are querying shows credit approval codes, 
and we want to make sure non approval is also listed there, instead of NULL which is absence of data.*/

Use AdventureWorks2019;-- We are connecting to the AdventureWorks2019 database
SELECT h.SalesOrderID, -- We are selecting the SalesOrderID and the CredictCardApprovalCode	
h.CreditCardApprovalCode,	
CreditApprovalCode_Display = ISNULL(h.CreditCardApprovalCode, '**NO APPROVAL**')-- If the CreditApprovalCode_Display will return the value '**NO APPROVAL**' if the expression is null.
FROM  Sales.SalesOrderHeader h;-- We are selecting the values fro the Sales.SalesOrderHeader table

/*Exercise 1 - Please make comments about the query we just executed, line by line, and accomplish a similar task using a different table. 
Please, be creative and explain the reasons behind your choice. Report results. Point out some information that you consider of interest 
for yourself and/or  for the class.*/

SELECT ProductID, BusinessEntityID, StandardPrice,
OnOrderQty=ISNULL(OnOrderQty,'0')
from Purchasing.ProductVendor; 
/* In this query we are retrieving the ProductID, BusinessEntityID, StandardPrice
columns from the Purchasing.ProductVendor table. In addition, we are creating a column named OnOrderQty in which 
everytime the OnOrderQty has a Null value the the specified return value would be '0'*/ 



/*Exercise 2 You have a table with a nullable column. You would like to return rows where that column is NULL or where the column is not NULL. 
In order to do so, we are going to create first a query that returns all the null values in the table HumanResources.Employee.*/

Select * from HumanResources.Employee
where OrganizationNode is null; 


/*Exercise 3- Now, I would like you select the same columns and the top 5 records from the HumanResources.Employee in which the column OrganizationNode is non null. 
Explain the query you are creating to complete this task. Interpret results.*/

Select top 5 NationalIDNumber, LoginID,OrganizationNode,OrganizationLevel,JobTitle
FROM HumanResources.Employee
WHERE OrganizationNode is not null;

/* In this query we are retrieving the top 5 values from the NationalIDNumber, LoginID, OrganizationNode,
OrganizationLevl, JobTitle columns from The HumanResources.Employee table where 
the OrganizationNode is not null*/ 


/*Exercise 4- Now, generate a query for all the items in the table Production.Product that the weight 
are measured in grams in which you create a new column called 
Cargo details. This new column is going to be filled in this order of priority 
1-Size
2-Color
3-"No cargo details available" 
Together with the new column generated, retrieve the columns ProductID, Name and List Price*/

SELECT ProductID,Name, ListPrice, 
CargoDetails = COALESCE(Size,Color, 'No cargo details available')
FROM Production.Product
WHERE WeightUnitMeasureCode = 'G'; 



/*Exercise 5 In the Sales.SalesOrderDetail table retrieve the data grouped by SalesOrderID and estimating 
the average unit price as a new column
considering only the items that don't have quantity equal to 1. Based your analysis comparing the columns
Line Total and Unit Price using the NULLIF Function*/

SELECT SalesOrderID,
AVG_Price= AVG(NULLIF(UnitPrice,LineTotal))
FROM Sales.SalesOrderDetail
WHERE OrderQty<>1
GROUP BY SalesOrderID;



