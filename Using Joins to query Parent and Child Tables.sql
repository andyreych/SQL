
/*You want to bring together data from parent and child tables. For example, you have a list of people in a parent
table named Person, and a list of phone numbers in a child table named PersonPhone. Each person may have
zero, one, or several phone numbers. You want to return a list of each person having at least one phone number,
along with all their numbers.*/

--Task1
--You want to return a list of each person having at least one phone number, along with all their numbers
--We have to go to the Person schema and visually inspect some of the tables there

Select PersonPhone.BusinessEntityID,FirstName,LastName,MiddleName,PhoneNumber
From person.person inner join person.personphone--This was an inner join, 
on Person.BusinessEntityID=PersonPhone.BusinessEntityID--The join was performed on the common
--field BusinessEntityID. We specified the table and the attribute from that table that was going to be
--used to complete the join
order by lastname,firstname,Person.BusinessEntityID;--We order by lastname,then firstname, and last BusinessEntityID

Select * from person.person
SELECT * FROM person.personphone
--Given the output we discussed our concerns about the person Kim Abercrombie and noted that:
--a.PhoneNumber records are different and it looks like the info is from different States
--b. The businessentityID is different which also made us think that it is the  same person 
--just playing different roles in the organization.

--Let us say that now we want to obtain the discount information of the product 'All-Purpose Bike Stand"
--Let us first inspect the Sales schema.
--We found out that we also need information from the Product table so we visited the Production schema
--In this problem there is a many-to-many relationship between Products and Special Offers. 
--The junction table is SpecialOfferProduct (SpecialOffers and Products)

Select p.Name,s.DiscountPct
from Sales.SpecialOffer s join Sales.SpecialOfferProduct o on s.SpecialOfferID=o.SpecialOfferID
join Production.Product p on o.ProductID=p.ProductID where p.Name='All-Purpose Bike Stand';

--The Product All-Purpose Bike Stand did not have a discount during the given (2010-11) period


Select p.Name,s.DiscountPct--Now we just want the Name and DiscountPct for the product Road Bottle Cage
from Sales.SpecialOffer s join Sales.SpecialOfferProduct o on s.SpecialOfferID=o.SpecialOfferID
join Production.Product p on o.ProductID=p.ProductID where p.Name='Road Bottle Cage';

Select *from Sales.SpecialOffer;--Here we just want to inspect every table that is part of the relationship (query)
Select *from Sales.SpecialOfferProduct;
Select *from Production.Product where ProductID='707';


--One example query
SELECT p.Name,
s.DiscountPct, s.SpecialOfferID
FROM Sales.SpecialOffer s
INNER JOIN Sales.SpecialOfferProduct o
ON s.SpecialOfferID = o.SpecialOfferID
INNER JOIN Production.Product p
ON o.ProductID = p.ProductID
WHERE p.ProductID = 707;--This query returned the discountPct and Name for Product 707(ProductID).

--Other example
--The query below returns Name and DiscountPct for every product with a discountpct different from zero or null.


SELECT P.Name,S.DiscountPct
FROM Sales.SpecialOffer S JOIN
Sales.SpecialOfferProduct SP ON S.SpecialOfferID=SP.SpecialOfferID
JOIN Production.Product P ON P.ProductID=SP.ProductID
WHERE DiscountPct<>0
ORDER BY 2 DESC;


--Let us find the Sales TaxRate and TaxType for every Region and State in which our products are sold.(Left join)
--We have information about TaxRates and TaxTypes in different country regions (Sales taxrates and taxtypes).

Select *from Person.StateProvince;--We first inspected the Person.StateProvince and Sales.SalesTaxRate tables
Select *from Sales.SalesTaxRate;

SELECT t.TaxRate, s.CountryRegionCode,--we executed a left outer join between the Person.StateProvince and Sales.SalesTaxRate
--tables. We want tax_rates and tax_types for every country country region and province whether products
--are taxed there (or even sold) or not.
s.StateProvinceID,
s.StateProvinceCode,
t.TaxType
FROM Person.StateProvince s--s is the alias for the Person.StateProvince table
LEFT OUTER JOIN Sales.SalesTaxRate t--t is the alias for the Sales.SalesTaxRate table
ON s.StateProvinceID = t.StateProvinceID;--the common field was StateprovinceID

--Let us now run a query using a cross join. A cross join operates in such a way that it returns
--all possible combinations of records in tables 1 and 2.

Select *from Sales.SalesTaxRate;
Select *from Person.StateProvince;

SELECT s.CountryRegionCode,
s.StateProvinceCode,
t.TaxType,
t.TaxRate
FROM Person.StateProvince s--This table has M records and Sales.SalesTaxRate has N records
CROSS JOIN Sales.SalesTaxRate t;--Web  just run a query that returned M*N records (Cartesian Product)

--The query below will return the PurchaseOrderNumber for every purchase where the unit price of each product was 
--between 1000 and 2000 dollars.
SELECT DISTINCT
s.PurchaseOrderNumber
FROM Sales.SalesOrderHeader s
INNER JOIN (SELECT SalesOrderID
FROM Sales.SalesOrderDetail
WHERE UnitPrice BETWEEN 1000 AND 2000
) d
ON s.SalesOrderID = d.SalesOrderID;


--You are querying the same data from two diferent sources. You wish to combine the two sets of results. For
--example, you wish to combine current with historical sales quotas.
SELECT BusinessEntityID,--In this case, BusinessEntityID is the Sales Person ID (EmployeeID)
GETDATE() QuotaDate,--We are using the alias QuotaDate for the date column
SalesQuota--Sales Quota
FROM Sales.SalesPerson--current sales data
WHERE SalesQuota > 0--The condition 
UNION ALL--It includes duplicates
SELECT BusinessEntityID,
QuotaDate,
SalesQuota
FROM Sales.SalesPersonQuotaHistory--Historical data on sales
WHERE SalesQuota > 0--The condition (filter)
ORDER BY SalesQuota DESC,--We order by salesquota desc and then by date
QuotaDate DESC;

SELECT * FROM Sales.SalesPerson
SELECT * FROM Sales.SalesPersonQuotaHistory
--Subtracting One Row Set from Another

--You want to subtract one set of rows from another. For example, you want to subtract component ID numbers
--from a list of product ID numbers to find those products that are at the top of the heap and are not themselves
--part of some larger product.

--Write a union query involving the EXCEPT operator. Subtract products that are components from the total list of
--products, leaving only those products that are not components. For example:

Select DISTINCT ComponentID from Production.BillOfMaterials;
Select DISTINCT ProductID from Production.Product;

SELECT P.ProductID
FROM Production.Product P
EXCEPT
SELECT BOM.ComponentID
FROM Production.BillOfMaterials BOM;

/*Exercise to work in breakout rooms

You are requested to retrieve, by Human Resources, the following information through queries.
-Business Entity ID
-Wage rate
-Marital status
-Gender
-Job candidate ID
You should display this information in 2 different ways
1- Display only the data that is common (table's intersection) for the tables involved*/
SELECT E.BusinessEntityID,E.Gender,E.MaritalStatus,P.Rate,C.JobCandidateID
FROM HumanResources.Employee as E join HumanResources.EmployeePayHistory as P
ON E.BusinessEntityID=P.BusinessEntityID JOIN HumanResources.JobCandidate as C
on P.BusinessEntityID=C.BusinessEntityID;


/*2- Display the data based on every record included in the Payment history of the company*/
SELECT E.BusinessEntityID,E.Gender,E.MaritalStatus,P.Rate,C.JobCandidateID
FROM HumanResources.Employee as E right outer join HumanResources.EmployeePayHistory as P
ON E.BusinessEntityID=P.BusinessEntityID left outer join HumanResources.JobCandidate as C
on P.BusinessEntityID=C.BusinessEntityID;



--Chapter 5
Select sum(i.Quantity) as Total_Inventory --We are using the aggregate function sum
--in order to find the total number of products in inventory. It will be displayed as Total_Inventory
from Production.ProductInventory i;--The data source, as we thought is the ProductInventory table
--from the Production schema. We use the alias i for the table Production.ProductInventory.
--The total number of items in inventory is 335974

/*For example, you want to report the total amount due by an order date from the sales table. There are many 
orders per day, and you want to report only the total per day.*/

Select orderdate,sum(TotalDue) as TotalDueByOrderDate--I want to retrieve the Total amount due by order date
from Sales.SalesOrderHeader--The data source is the Sales.SalesOrderHeader table
where OrderDate>='2011-07-04' and OrderDate<='2015-07-04'--I want the total amount due by orderDate between
--July fourth 2011 and July fourth 2015.
group by OrderDate;--Here we grouped by order date
--Since we used an aggregate function in the select statement then order date had to be the argument of
--the group by clause.

Select s.Name, count(w.WorkOrderId) as count from Production.ScrapReason s join Production.WorkOrder w
on s.ScrapReasonID=w.ScrapReasonID
group by s.Name
Having COUNT(*)>50
order by count desc;--Thermoform temperature too low is the main reason for failure

--I obtained the name of the most common (more than 50) scrap reasons(failure reasons).
--It seems to me that Thermoform temperature too low is the main reason for work orders to fail at this point.

/*Exercise to work in breakout rooms

Remember the exercise using the Tables Person.StateProvince and Sales.SalesTaxRate? 
How can we display only the State Province Code 
repeated in the Table Sales.SalesTaxRate, together with the count of repetitions*/

SELECT s.StateProvinceCode, count(t.StateProvinceID) count
FROM Person.StateProvince s
right outer join Sales.SalesTaxRate t 
on t.StateProvinceID=s.StateProvinceID
GROUP by s.StateProvinceCode
HAVING count(t.StateProvinceID)>1;

--Now let us use the cube argument after the group by clause to get the total number of items
--in inventory for each locationID (warehouse) accross the different shelves inside.
--The query below returns the number of items on each shelf for each warehouse (in order). It first
--returns the information for LocationID number one. It then produces a subtotal which is the total number
--of items in inventory in LocationID number one(Warehouse 1)
--Thereafter, it continues producing subtotal lines (total for each location id). 
--The group by clause with the cube argument makes sure that you get all possible combinations (Business wise)
-- between shelf and Location ID. In addition, it also returns a grand total ( @ NULL and NULL).
Select p.Shelf,p.LocationID,sum(p.quantity) as inventory_total from Production.ProductInventory p
group by Cube(p.Shelf,p.LocationID);

Select p.Shelf,p.LocationID,sum(p.quantity) as inventory_total from Production.ProductInventory p
group by Rollup(p.Shelf,p.LocationID);

--It also returns the subtotals for each attribute for location and for shelves. If we have null and location
--then we have subtotal for that location. If instead we have shelf and null, it is the subtotal for that shelf.
--Last, Null and Null will indicate the grand total.

--Below we will obtain a Hierarchical Summary
--We will obtain the different Names(Product Names) by each shelf in order A....Z and then subtotals
--Last we will obtain the grand total @ Null Null.
Select i.Shelf,p.Name,SUM(i.Quantity) as total from Production.ProductInventory i 
join Production.Product p
on i.ProductID=p.ProductID
Group by Rollup(i.Shelf,p.Name);--This query returned the items in inventory organized by shelf.
--It first returned shelf A and then the different Product Names in Shelf A in ascending order, then the subtotal.
--The process was the same for the other shelves (B,C,D,......Z)
--I was able to obtain a subtotal for each shelf and then the subtotal.







