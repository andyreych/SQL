--Chapter 6
--In the query below we want to return the different hiring dates per the Employee table from the Human
--Resources schema
Select distinct HireDate --I am using distinct to eliminate duplicates
from HumanResources.Employee 
order by HireDate;--We ordered by HireDate ascending (default)

--Let us now solve the same problem running quite a different query

Select HireDate 
from HumanResources.Employee 
group by HireDate --Here we are using the Group By clause to eliminate duplicates
order by HireDate;--Again we ordered by HireDate ascending

Select City 
from Person.Address 
Group by City 
order by City;


--Let us say that now we want to obtain the last five dates in which any employee was hired
--We are querying the Employee table since this is information about employees.
Select top(5) HireDate --The top(5) clause returns only the first five records. In this case
--the last 5 dates (order by desc) in which the company hired employees.
from HumanResources.Employee 
group by HireDate 
order by HireDate desc;

Select top(20) percent --We used the select statement with the top()clause. In this case we used it as top(20)percent
--We are querying the ProductInventory table (ModifiedDate column)
Modifieddate from
Production.ProductInventory
Group by ModifiedDate--We use the Group By clause to remove duplicates
Order by ModifiedDate desc;--We order by ModifiedDate in descending order to get the most recent dates first.

--Now let us see an example in which we retrieved the top(5) % of HireDate.

SELECT TOP (5) PERCENT HireDate--Select statement with the top() clause.
FROM HumanResources.Employee--The data source is the employee table
GROUP BY HireDate--Group by to remove duplicates
ORDER BY HireDate DESC;

Declare @FirstHireDate date,@LastHireDate date;--First we declared both variables using the  standard format
--Declare @Variable_Name data_type;
Select @FirstHireDate=Min(HireDate),@LastHireDate=MAX(HireDate) from HumanResources.Employee;
--Thereafter, We assigned a value to each declared variable (Min and Max). First, we assigned the Minimum (Oldest) HireDate  
--and then the Max (most recent) HireDate.
Select @FirstHireDate as FirstHireDate,@LastHireDate as LastHireDate;--Now we just retrieve the min and max.

--Let us inspect the table Sales.CurrencyRate
Select *from Sales.CurrencyRate;

--Display the most undervalued currency at a limit greater than 1495.00 points of exchange with the USD.
Select *from Sales.CurrencyRate Where AverageRate>=1495.00;


--Retrieving Data Directly into Variables
Declare @AverageRate money,@EndOfDayRate money;
Select @AverageRate=(AverageRate), @EndOfDayRate=(EndOfDayRate)  from Sales.CurrencyRate   
where ToCurrencyCode like 'GBP';
Select @AverageRate as AverageRate,@EndOfDayRate as EndOfDayRate;

--6-12. Reusing Common Subqueries in a Query
/*Now let us run a query that retrieves information about about the daily purchasing value out of "PurchaseOrderDetail" table. 
 Note that we are using a table expression.*/

DECLARE @MaxPurchasingValueDay float,
@MinPurchasingValueDay float;

WITH cte as
(
SELECT SUM(LineTotal) as total from Purchasing.PurchaseOrderDetail 
Group by CAST(ModifiedDate as date)
)

SELECT @MaxPurchasingValueDay=MAX(total),
@MinPurchasingValueDay=MIN(total)
FROM cte;

SELECT @MaxPurchasingValueDay AS PurchasingRecordDay,
@MinPurchasingValueDay AS WorstPurchasingDay;

SELECT * FROM  Purchasing.PurchaseOrderDetail 


--Let us start discussing chapter 7


--We are already connected to AdventureWorks2017
--Let us run the first query. The first example in Chapter 7
--consists of calculating the average ratings of the products
--in the AdventureWorks2017 database.
SELECT AVG(Rating) As avg
     
FROM [AdventureWorks2019].[Production].[ProductReview]
--Let us use the AVG function to determine the average
--But first, let us take a look at the data source (ProductReview
--table). This table stores Customer reviews of products they have 
--purchased, being a very valuable table for any data 
--analysts/database developer working with the AdventureWorks2017
--database (Marketing or Management team).

--Let us inspect the table again but this time using T-SQL
Select * from Production.ProductReview;

--The query run above returned only four records. I am personally wondering if this is
--a good tool to assess the quality of our products. I have only four review.

--Let us finally calculate the average

SELECT ProductID,
AVG(Rating) AS AvgRating
FROM Production.ProductReview
GROUP BY ProductID;

--The products with ProductID 709 and 798 returned an average rating of 5 (only one review each)
--.The rating for ProductID 937 was 3(Two reviews only).

--Let us now see another example of the utility of aggregate functions

--Let us find the Avg Tax-Rate by Tax-Type
--Let us inspect the SalesTaxRate table.

--1 = Tax applied to retail transactions, 2 = Tax applied to wholesale transactions, 
--3 = Tax applied to all sales (retail and wholesale) transactions.
--Let us run a couple of queries to have a better understanding of the Tax Type
--category

Select * from sales.SalesTaxRate
where TaxType=3;--In the where clause I specify that I want to return Tax Type 3

Select *from sales.SalesTaxRate
where TaxType!=3;--We want to return Tax Types 1 & 2

Use AdventureWorks2019;
SELECT TaxType,   	
AVG(TaxRate) AS AvgTaxRate
FROM   Sales.SalesTaxRate
GROUP  BY TaxType--
order by AvgTaxRate desc;--

--After running the query above we observe that Tax Type 3 transactions show the highest Tax 
--Rate. Tax Type 3 is the way to label foreign transactions.


--We want to see the number of products we have in inventory on each 
--shelf for our first five shelves (A-E). Let us take a look at the 
--Production schema, ProductInventory table. This table stores
--product inventory information.

--Let us utilize the COUNT and COUNT_BIG function to return the count of rows in the ProductID
--attribute.
--
SELECT TOP (5)--We select the top 5 for the shelf column
Shelf,
COUNT(ProductID) AS ProductCount,--Let us get the Product count using count()
COUNT_BIG(ProductID) AS ProductCountBig--Let us get the Product count using count_big()
FROM Production.ProductInventory--The data source is the ProductInventory table
GROUP BY Shelf--We group by Shelf, no duplicates
ORDER BY Shelf;--We ordered by Shelf

--As we expected the query returned the product count for shelves A-E
--There is no difference in the output of columns two and three because we are not expecting bigint as a result. 
--You’ll need to use COUNT_BIG() if you expect its results to be larger than 2,147,483,647 


--Now we want to see the total due by account number for orders placed.

SELECT TOP (5)--We select the the top 5 accounts with a TotalDue
--Explain why do you think we taargeted the top 5 accounts
AccountNumber,
SUM(TotalDue) AS TotalDueByAccountNumber--We are summing the TotalDue
FROM Sales.SalesOrderHeader--The data source is SalesOrderHeader, schema Sales
GROUP BY AccountNumber
ORDER BY AccountNumber;--We group and order by Account Number. No duplicates.
--We noticed from the output that Account Number 10-4020-000004
--has the biggest delinquent amount among the the top 5 account numbers.
--What do you think account number is related to?

--I do not think that the query run above achieved anything relevant
--Instead, we want to see what the top 5 delinquent accounts are.
--The query below will order by TotalDue (TotalDueByAccountNumber)

SELECT TOP (5)--We select the the top 5 accounts with a TotalDue
--Explain why do you think we targeted the top 5 accounts
AccountNumber,
ROUND(SUM(TotalDue),2) AS TotalDueByAccountNumber--We are summing the TotalDue
FROM Sales.SalesOrderHeader--The data source is SalesOrderHeader, schema Sales
GROUP BY AccountNumber--We need to group by account number in order to eliminate duplicates
ORDER BY TotalDueByAccountNumber desc;--We order by TotalDueByAccountNumber because
--the amount is more relevant than the actual account number.

--Let us say that we want to obtain the actual cost  by ProductID from the "Production.
--TransactionHistory" table. This table has records of each purchase order, sales order, or 
--work order transaction year to date.

SELECT TOP (5)
   	ProductID,   	
	SUM(ActualCost) AS TotalCostByProductID--we used an alias for ActualCost because
	FROM   Production.TransactionHistory
	GROUP BY ProductID
	ORDER BY TotalCostByProductID desc;--we sorted descending because.....


--From the output we conclude that ProductID 782 is the most expensive product according
--to the transactions history table..........


--We want to see the highest and lowest ratings given on our products.
--Let us use the Max and Min aggregate functions

SELECT MIN(Rating) MinRating,--We apply the Min function to the column Rating
MAX(Rating) MaxRating--We apply the aggregate function Max to the column Rating
FROM Production.ProductReview;--Our data source once again is the table ProductReview

--The query returned a Min rating of 2 and a Max rating of 5. Once again, we think that 
--the output is not enough information to make a decision given the limited number of records

/*The VAR and VARP functions return the statistical variance of all the values in the 
specified expression. VAR returns the value based upon a sample of the data population; 
VARP returns the value based upon the entire data population.
When utilizing the VAR or VARP functions, the expression parameter must be one of the exact 
or approximate numeric data types, except for the bit data type. */

SELECT ROUND(VAR(TaxAmt),2) AS Variance_Sample,--We are selecting the sample variance for the TaxAmt value
ROUND(VARP(TaxAmt),2) AS Variance_EntirePopulation--We are selecting the population variance for the TaxAmt
FROM Sales.SalesOrderHeader;--The data source is the Sales.SalesOrderHeader table

SELECT * FROM Sales.SalesOrderHeader

--Can you determine if this a high value of variance only by seeing the result?

SELECT VAR(TaxAmt) AS Variance_Sample,--We are selecting the sample variance for the TaxAmt value
VARP(TaxAmt) AS Variance_EntirePopulation,--We are selecting the population variance for the TaxAmt
AVG(TaxAmt) AS Mean,--We are selecting the population mean
MAX(TaxAmt) AS MaxValue,--We are selecting the population maximum value
MIN(TaxAmt) AS MinValue--We are selecting the population minimum value
FROM Sales.SalesOrderHeader;

--Now you have a better idea of the behavior of th data in this column. It has a great value of variance

--We would like to find out how spread the UnitPrice is. First, we take the sample
--approach and assume that adventureWorks is one of many samples and our goals is to
--measure UnitPrice accross the United States. Thereafter, we are calculating how spread the
--UnitPrice is in the AdventureWorks 2019 Population. The different between both methods
--is basically an N-1 in the denominator of the STDEV formula. 

--First,let us inspect the data source (SalesOrderDetail). This table stores information
--for individual products associated with a specific sales order. 

Select *from Sales.SalesOrderDetail;
Select AVG(UnitPrice) from Sales.SalesOrderDetail;

--...........

SELECT ROUND(STDEV(UnitPrice),2) AS StandDevUnitPrice,--
ROUND(STDEVP(UnitPrice),2) AS StandDevPopUnitPrice
FROM Sales.SalesOrderDetail;

--The query above returned that the Unit price for the sample case scenario(assuming
--AdventureWorks2019 is a sample) is spread by $751.89, whereas the value for the population
--case scenario was $751.88.


--Standar deviation looks at how spread out a group of numbers is from the mean
--by looking at the square root of the variance. The variance measures the average difference
--between an observed (or collected) data point and the mean.

--We are going to use the Rank function to rank our sales associates
--The table Sales.SalePersonQuotaHistory stores sales performance tracking information about sales.

Select BusinessEntityID,
QuotaDate,
SalesQuota,
Rank() over (order by SalesQuota desc) as rank
from Sales.SalesPersonQuotaHistory
where QuotaDate between '10-01-2012' and '10-01-2014';

