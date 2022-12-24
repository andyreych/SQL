/*Welcome to Lecture VII , today we are going to be working with Dates and Times. SQL Server
has several different date and time data types, with varying levels of range and precision (and
a corresponding varying levels of storage requirement space). SQL Server also has numerous
functions to retrieve, modify, and validate the data from these data types in various formats.
This chapter focuses on these functions*/

/*Let us say that now we want to convert date/time since we are in a different time zone (a
hypothetical case scenario)*/

SELECT SWITCHOFFSET('2007-06-12T07:43:25-05:00', '+03:00');
/* In the query above we are using the SWITCHOFFSET function in which we adjust the date,hours, and minutes as needed 
to convert a datetimeoffset value to a new time zone. In this case, we are adding 3 hours into the new time zone.*/

/*I would like you to briefly explain what we just did as well as to interpret the line of code that
we just ran. In addition, create a query to simulate a similar case scenario.*/

SELECT SWITCHOFFSET('2021-04-05T01:45:25','+04:00');

/*Let us say that now I want to convert the system's current date/time value to the current time in
the Eastern Time Zone (without DST adjustments) and displays both the time and the current
system time in a datetimeoffset format.*/

SELECT TODATETIMEOFFSET(GETDATE(), '-05:00') AS [Eastern Time Zone Time],
SYSDATETIMEOFFSET() [Current System Time];

/*Interpret the output and run a query simulating a similar case scenario.*/

/* In the query above the function TODATETIMEOFFSET is converting a datetime value 
into a datetimeoffset, in this case is Eastern Time Zone Time.In addition, we are selecting another column 
displaying the current system using the SYSDATETIMEOFFSET function*/

SELECT TODATETIMEOFFSET(GETDATE(), '-03:00') AS [Pacific Time Zone Time],
SYSDATETIMEOFFSET() [Current System Time];

/*Let us say that now we want to add an interval to a date or time portion of a date/time value.
Please after running the query below explain under what circumstances this task would be
useful in a company. In addition, run a similar query solving a different case scenario and
briefly explain the syntax as well as the output.*/

SELECT DATEADD(Month, -2, '2009-04-02T00:00:00');
/* In this query we are using the DATEADD function to add or substract quantity in dates, in this case we are substracting two months (-2), to modify the 
first paremeter of the string which is month. As a result, the output instead of being '2009-04-02' is actually
'2009-02-02'. In addition, this function is useful to a company in which we want to modify date values in a column from a table.For example,
substracting 1 year from a ReleaseDate column of a Table Product that the company plans to release one year earlier of what was planned such 
as a model of a Car for a AutoManufacturer for example..*/


/*Let us say that now we need to calculate the difference between two dates. For instance,
there is a project that is scheduled to finish on a certain date and instead it takes a little longer.
Same thing with a credit card payment that is not made by the due date. In those
circumstances, you always want to know the amount of days the account was delinquent or
the project was late.*/

Use AdventureWorks2019;
SELECT ProductID, DueDate,EndDate,-- We are selecting ProductID, DueDate, EndDate 
DATEDIFF(Day, DueDate,EndDate) AS Elapseddays-- In addition, we are using Datediff to calculate the difference between the DueDate and the EndDate in Days
FROM Production.WorkOrder WHERE EndDate IS NOT NULL; -- from the Production.WorkOrder where the EndDate is not null

/* The results of the output of the query above is the ProductID,DueDate,EndDate, and the Elapseddays which is the Alias
of the DATEDIFF function that is being used to calculate the Differences in between the DueDate and the EndDate to calculate 
how many days was the project Late or the credit card deliquent.*/

/*I would like you to assess the quality of the query run above using example 10-5 from the
book. What are the differences between both queries? In addition, interpret the output as well as
the syntax of the query above. Thereafter, run a query that executes a similar task but using a
different table (not the one in example 10-5).*/
-- Example 10-5
SELECT TOP(5)
ProductID,
GETDATE() AS Today,
EndDate,
DATEDIFF(MONTH,EndDate,GETDATE()) AS ElapsedMonths
FROM Production.ProductCostHistory
WHERE EndDate IS NOT NULL;
/* The difference between the 2 queries as we can see is that we are using the DATEDIFF function to 
calculate the difference between today's date and EndDate  by Months and not Days like in the previous query. 
In addition, We are using ElapsedMonths as alias for the DATEDIFF function and using the where clause 
to specify to only retrieve the results in which the EndDate is not null. By using the GETDATE function in our string we 
are able to see Today's time and name it Today for reference. Finally, we are only selecting the Top 5 results of our ProductID*/


/*Let us say that now we need to separate a date into different columns for year, month,
and date.In order to do so, we are going to use the DATEPART function to retrieve the
datepart specied from a date as an integer. I would like you to make some comments about
the
query below (syntax and output) and thereafter to create a similar query to execute a critical
task using a different table.*/

SELECT ProductID, EndDate,
DATEPART(YEAR, EndDate) AS [Year],
DATEPART(MONTH, EndDate) AS [Month],
DATEPART(DAY, EndDate) AS [Day] FROM Production.WorkOrder
WHERE EndDate IS NOT NULL
order by 2 desc;
/* In the query above we are selecting the ProductID, EndDate, and we are using the DATEPART function to separate 
the EndDate in different columns which are Year,Month, and Day. In addition, we are specifying in our output only to retrieve the 
results in which the EndDate is not null*/
SELECT ProductID, ModifiedDate,
DATEPART(YEAR, ModifiedDate) AS [Year],
DATEPART(MONTH, ModifiedDate) AS [Month],
DATEPART(DAY, ModifiedDate) AS [Day] FROM [Sales].[SpecialOfferProduct]
WHERE [ModifiedDate] IS NOT NULL
order by Year desc;
/* In the query above we are selecting the ProductID,ModifiedDate and using the DATEPART function to separate the Year
, Month, and Day from the ModifiedDate of the Sales.SpecialOfferProduct Table and ordering the results by year in descending order.*/
