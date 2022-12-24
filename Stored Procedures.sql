/*Financing Department is trying to find out which type of credit card is more popular among the people registered in the Database. You should write a general stored procedure
that retrieves the quantity of people that use each credit card when the type of credit card is used as  reference in the execution of the stored procedure*/

CREATE PROCEDURE Use_CreditCard
@CardType NVARCHAR(50)   	
AS   	
SELECT   COUNT(s.BusinessEntityID) as count, p.CardType  
FROM 	Sales.PersonCreditCard s
Join Sales.CreditCard p
ON s.CreditCardID=p.CreditCardID
WHERE	 p.CardType= @CardType   	
GROUP by p.CardType   	


EXEC Use_CreditCard 'SuperiorCard';


/*Financing Department wants to retrieve a list with Tax Type, Tax Rate, and Name of the State Province when a country is given as an Input. You are requested to create a 
stored procedure to retrieve that information. Consider each row retrieved in the list per each country as the number of provinces/states. Using the info related to tax 
type and tax rate Display the quantity of states/province in the message panel.*/

CREATE PROCEDURE StateTaxRatePerCountry
@Name nvarchar (50),
@StateQty INT OUTPUT
AS   	
	SELECT   TaxType,TaxRate,p.Name   
	FROM Sales.SalesTaxRate s
	JOIN Person.StateProvince p
	ON s.StateProvinceID=p.StateProvinceID
	JOIN Person.CountryRegion q
	ON p.CountryRegionCode=q.CountryRegionCode
	WHERE	q.Name = @Name
	ORDER BY TaxType,TaxRate;    	
	SELECT   @StateQty = @@ROWCOUNT;

DECLARE @StateQty INT
EXEC StateTaxRatePerCountry 'United States',
@StateQty OUTPUT;
PRINT @StateQty;

/*The same department wants to narrow the possibilities, and they realized that input should be given based on two parameters:
Country name and Tax Type. 
Now there is no need to display in a message the quantity of states/provinces. Modify the procedure previously created*/

ALTER PROCEDURE StateTaxRatePerCountry
@Name nvarchar (50),
@TaxType INT 
AS   	
	SELECT   TaxType,TaxRate,p.Name   
	FROM Sales.SalesTaxRate s
	JOIN Person.StateProvince p
	ON s.StateProvinceID=p.StateProvinceID
	JOIN Person.CountryRegion q
	ON p.CountryRegionCode=q.CountryRegionCode
	WHERE	q.Name = @Name AND s.TaxType=@TaxType
	ORDER BY TaxType,TaxRate;    	
	

EXEC StateTaxRatePerCountry 'Canada', '1'
