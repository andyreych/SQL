
/*Create a view with Encryption that contains the following information:
1-Business Entity ID --[HumanResources].[Employee]
2-Employee First Name--[Person].[Person]
3-Employee Last Name,--[Person].[Person]
4-Person Type--[Person].[Person]
5-Job Title --[HumanResources].[Employee]
6-Marital Status -- [HumanResources].[Employee]
7-Gender -- [HumanResources].[Employee]
8-Department they have worked for [HumanResources].[Department] / [HumanResources].[EmployeeDepartmentHistory]*/

CREATE VIEW dbo.Employee_Information 
with encryption 
AS
SELECT  pp.BusinessEntityID AS BusinessID,
        pp.FirstName AS First_Name,
        pp.LastName AS Last_name,
		pp.PersonType AS PersonType,
		hre.JobTitle AS JobTitle,
		hre.MaritalStatus as MaritalStatus,
		hre.Gender as Gender,
		hd.Name as Department
FROM [Person].[Person] pp
JOIN [HumanResources].[Employee] hre
ON pp.BusinessEntityID=hre.BusinessEntityID
JOIN [HumanResources].[EmployeeDepartmentHistory] hred
ON hre.BusinessEntityID=hred.BusinessEntityID
JOIN [HumanResources].[Department] hd
ON hd.DepartmentID=hred.DepartmentID;
GO



Select * from dbo.Employee_Information;
EXEC sp_helptext dbo.Employee_Information;


/*Why are we getting more quantity of rows than the number of records of the table Employee?
Display Name and last name of the employees that are repeated in the View*/

SELECT First_Name, Last_name, COUNT(BusinessID) as COUNT from dbo.Employee_Information
GROUP BY First_Name, Last_name
HAVING COUNT(BusinessID)>1