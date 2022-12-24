/*HR wants to schedule the interview for the prospective employees. You were asked to assign random integer values, using the same procedure as the problem 11-13 of the book.
Set the min and max in a range between 10 and 100. HR wants the list with two columns, JobCandidateID together with the numbers generated sortd in a descending order*/
DECLARE @jmin as int, @jmax as int;
SET @jmin = 10;
SET @jmax = 100;
SELECT JobCandidateID, CAST(RAND(CHECKSUM(NEWID()))*(@jmax-@jmin) AS INT)+@jmin as 'Interview Order' FROM HumanResources.JobCandidate
ORDER BY 2;


/*Purchasing Department is buying a shipment with a net value of 100K USD. They have to pay in advance for the full amount at the time of the order. Supplier is ready to ship two months 
after the company places the order. They would like to know the finacial cost of this purchase. Consider financial cost using an annual rate of 10%, use the query in the example of the home loan*/
Declare @order decimal (8,2)=100000.00
DECLARE @cost decimal(8,2)
SET @COST = @order *(.10/12*2)
select @COST AS 'Financial Cost';


/*HR just realized that they can't interview the whole list of prospective employees in one day, they could only interview the 75% of the list you reported in the first exercise. 
They are asking for the number of job candidates that should be interviewed. For this exercise, use one aggregated function to find the number of candidates and one of the functions ceiling or floor as required.
Consider the reason of HR request the lack of time to finish the whole list*/
SELECT FLOOR(COUNT(JobCandidateID)*.75) AS 'Number of Candidates We Can Interview' FROM HumanResources.JobCandidate;

/*After you reported the number, they are not convinced of the result and they are asking you to report in one query the proportion applied on the list. Hint(Select TOP....)
Compare the quantity of records obtained with the number you reported previously*/

DECLARE @jmin as int, @jmax as int;
SET @jmin = 10;
SET @jmax = 100;
SELECT TOP 75 PERCENT JobCandidateID,
CAST(RAND(CHECKSUM(NEWID()))*(@jmax-@jmin) AS INT)+@jmin as 'Interview Order' FROM HumanResources.JobCandidate
ORDER BY 2;