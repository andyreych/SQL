-- Final Project--.
CREATE DATABASE Marketing_Project;-- First we start by creating the database which in this case is named Marketing Project
USE Marketing_Project;

CREATE TABLE CUSTOMERS (
LOCATION_ID INT PRIMARY KEY NOT NULL,
CUSTOMER_ID INT NOT NULL ,
MARKETING_REP_ID INT NOT NULL ,
STRATEGY_ID INT NOT NULL ,
CUSTOMER_NAME VARCHAR(30) NOT NULL,
PRICE INT NOT NULL,
);



INSERT INTO CUSTOMERS(LOCATION_ID, CUSTOMER_ID, MARKETING_REP_ID, STRATEGY_ID, CUSTOMER_NAME, PRICE)
VALUES
('3321','1','1002', '2048','Birmingham City Hospital',300),
('2140','3','1003','1243','Nashville City Hospital',100),
('4020','7','1007' ,'3328','Fulton City Hospital',250),
('1212','5','1005', '4446','Memphis Baptist City Hospital',250),
('3704','2','1001', '0508','Palm Beach Hospital',400),
('2121','6','1006' ,'9967','Tampa Public County Hospital',250),
('1125','4','1004' , '5677','Augusta Hospital',400);

CREATE TABLE EVENT_HISTORY (
LOCATION_ID INT PRIMARY KEY NOT NULL,
MARKETING_REP_ID INT NOT NULL ,
EVENT_DATE  DATE NOT NULL ,
EVENT_CITY VARCHAR(255) NOT NULL ,
NUMBER_OF_PATIENTS_REGISTERED INT NOT NULL,
);



INSERT INTO EVENT_HISTORY( LOCATION_ID, MARKETING_REP_ID, EVENT_DATE, EVENT_CITY, NUMBER_OF_PATIENTS_REGISTERED)
VALUES
('3321', '1002', '11-20-2020', 'ATLANTA', '10'),
('2140','1003', ' 04-29-2020' , 'MEMPHIS', '7'),
('4020', '1007', '11-25-2021', ' ATLANTA', '15'),
('1212', '1005' , '12-03-2021' , 'NASHVILLE', '3'),
('3704', '1001' , '01-04-2021' ,'PALM_BEACH_GARDENS', '5'),
('2121', '1006', '01-21-2020', 'TAMPA' , '13'),
('1125', '1004', ' 02-08-2020', 'AGUSTA', '8');

CREATE TABLE MARKETING_STRATEGIES (
STRATEGY_ID INT PRIMARY KEY NOT NULL,
STRATEGY_NAME VARCHAR(255)  NOT NULL ,
DESCRIPTION_NAME VARCHAR(255) NOT NULL ,
EFFECTIVNESS VARCHAR(50)
);

INSERT INTO MARKETING_STRATEGIES(STRATEGY_ID, STRATEGY_NAME, DESCRIPTION_NAME, EFFECTIVNESS)
VALUES
('508', 'INTERNAL_MAKETING', 'ONLINE_LANDING_PAGE SHORT_TALK_PODCAST', 'EXTREMELY HIGH'),
('1243', ' MESSAGING APPS', ' TEXT_MESSAGE WHATSAPP FACEBOOK MESSENGER', 'MEDIUM'),
('2048', 'LEAD_BUCKETS', ' TYPE OF EXCHANGE WITH POTENTIAL PATIENTS', 'HIGH'),
('3328', ' DIGITAL SIGNAGE' , 'TELEVISION','HIGH' ),
('4446', 'INFLUENCER', 'INDIVIDUALS THAT BUILD UP A COMMUNITY OR AUDIENCE', 'HIGH'),
('5677', 'VIDEO MARKETING' , 'YOUTUBE BLOG_POSTS SOCIAL_MEDIA', 'EXTREMELY HIGH'),
('9967', 'SOCIAL MEDIA', 'FACEBOOK TWITTER LINKEDIN INSTAGRAM', 'HIGH');

CREATE TABLE LOCATIONS (
LOCATION_ID INT PRIMARY KEY NOT NULL,
MARKETING_REP_ID INT NOT NULL ,
MARKETING_REP_NAME VARCHAR(255) NOT NULL ,
STATE_NAME VARCHAR(55) NOT NULL ,
REGION VARCHAR(30) NOT NULL,
CITY VARCHAR(55) NOT NULL,
COUNTY VARCHAR(55)
);



INSERT INTO LOCATIONS(LOCATION_ID, MARKETING_REP_ID, MARKETING_REP_NAME, STATE_NAME, REGION, CITY, COUNTY)
VALUES
('3704','1001','MICHELLE_CONNORS','FLORIDA','SOUTH', 'WEST_PALM_BEACH', 'PALM BEACH COUNTY'),
('3321', '1002', 'MICHALE_SMITH', 'ALABAMA', 'SOUTH_EAST', 'ATLANTA', 'BALDWIN'),
('2140', '1003', 'LESLIE_JACKSON', 'TENESSEE', 'NORTH_WEST', 'MEMPHIS', 'HARDIN'),
('1125', '1004', 'ROSE_LOPEZ', 'GEORGIA', 'NORHT', 'AUGUSTA' , 'RICHMOND'),
('1212', '1005', 'BELLA_BLUE', 'TENNESSEE', 'CENTRAL', 'NASHVILLE', 'DAVIDSO'),
('2121', '1006', 'JORGE_GARMAS', 'FLORIDA', 'CENTRAL', 'TAMPA', 'HILLSBOROUGH'),
('4020', '1007', 'ALEX_LEON', 'GEORGIA', 'SOUTH', 'VALDOSTA', 'MONROE');

---1- Add a constraint to a column in any of the tables. (Example: add constraint minimum_date check(Transaction_date >='01.01.2019')...)

/* In this part we will add a constraint in the Customers table in which we will use the CHECK constraint to set a minimun set of values in the price column
from our CUSTOMERS table in which we will set a minimum price of 100.*/ 

ALTER TABLE CUSTOMERS
ADD CONSTRAINT Min_Price CHECK( Price>=100)

/* In addition we will Test the constraint by inserting a new record that violates it.*/
INSERT INTO CUSTOMERS (LOCATION_ID, CUSTOMER_ID, MARKETING_REP_ID, STRATEGY_ID, CUSTOMER_NAME, PRICE)
VALUES ('0000','0','0000' , '0000','Sample Hospital',50);-- As we can see for our example we set the price to be under the minimum price constraint which is 100.
--As a result, the output is that the insert statement conflicted with the CHECK constraint "Min_Price" that we created earlier so the statement has been terminated.

/*2- Run at least three queries: 
2.1- One query should involve at least three different tables. 
2.2- In at least one of them, Join operators must be used. 
2.3- In at least one of the queries you should use the HAVING clause.*/

SELECT c.CUSTOMER_NAME,l.MARKETING_REP_NAME,l.STATE_NAME,l.CITY, m.STRATEGY_NAME,c.PRICE
-- We are selecting the Customer Names, Marketing Representative Names, the State Name, The Cities, The Strategy name and the Price from 3 different tables which are:
from CUSTOMERS c-- The Customers Table using Alias c
JOIN LOCATIONS l-- Joining the Locations table using alias l
on c.LOCATION_ID=l.LOCATION_ID-- Joining the two tables together using the LOCATION_ID from both Customers and Location Table
JOIN MARKETING_STRATEGIES m-- As well as joining the MARKETING_STRATEGIES using alias m 
ON m.STRATEGY_ID=c.STRATEGY_ID-- joining using the Strategy_ID column from the Marketing_Strategies table and the Customer Table
GROUP BY c.CUSTOMER_NAME,l.MARKETING_REP_NAME,l.STATE_NAME,l.CITY,m.STRATEGY_NAME,c.PRICE-- In addition we group the output by the columns we selected previously
HAVING SUM(PRICE)>=200-- In which we added the HAVING clause to only retrieve the results in which the price is greater or equal than 200
--using the aggregate function of SUM(PRICE)
Order by c.PRICE desc; -- And Ordering the results in desceding order by the price from largest to shortest

SELECT MIN(PRICE) as Min_Price, MAX(PRICE) as Max_Price-- In this query we are retrieving the Minimun and Maximum Price of the table Customers using the MIN and MAX aggregate function
FROM CUSTOMERS;

SELECT c.CUSTOMER_NAME,l.STATE_NAME,m.STRATEGY_NAME,e.EVENT_DATE,c.price
--In this query we are selecting the Customer Names, the State name, the Strategy_Name , the Event Date, and the price joining the following tables:
FROM CUSTOMERS c-- From the Customers table using c as an alias
JOIN LOCATIONS l-- Using inner join to join the Customer table with the Location table using l alias.
ON c.LOCATION_ID=l.LOCATION_ID-- using the LOCATION_ID from both of the previous tables
JOIN EVENT_HISTORY e-- Joining the EVENT_HISTORY table alias e
ON l.LOCATION_ID=e.LOCATION_ID-- Using LOCATION_ID from both tables
JOIN MARKETING_STRATEGIES m-- In addition, we join the Marketing_Strategies tables using alias m
ON m.STRATEGY_ID=c.STRATEGY_ID-- with Strategy_ID from the Marketing_Strategies and the Customers table
WHERE e.EVENT_DATE BETWEEN '2021-01-01' AND '2021-12-30'
-- In which we only are  using the WHERE clause in which the Event is between January 1st of 2021 until December 30th of 2021 to specify the range of the events
-- to only retrieve results from 2021
ORDER BY e.EVENT_DATE asc;-- Finally, we order the results in ascending order to see the events from Earliest to Latest in 2021.

--3- Update a column based on a condition that needs to be met using the where clause.

UPDATE CUSTOMERS -- In this query we are updating the customers tables to set the price to 300 (previously it was 250)
SET PRICE=300
WHERE STRATEGY_ID=9967;-- Where the STRATEGY_ID equals 9967

/* Retrieve data with a query directly into a variable. The variables must be initially declared. 
The final query must return the minimum and maximum values through the variables previously declared. 
Find out more information in Chapter 6 of the book and assignments related to it.*/

DECLARE @FirstEventDate DATE,
        @LastEventDate DATE;
-- In this query we are declaring the variables @FirstEventDate and @LastEventDate with a Date data type.

SELECT @FirstEventDate = MIN(EVENT_DATE),
       @LastEventDate = MAX(EVENT_DATE)
FROM EVENT_HISTORY;
--This query retrieves the first and the last event dates and populates the variables with these values.

SELECT @FirstEventDate AS FirstEventDate,
       @LastEventDate  AS LastEventDate;
-- Finally this query returns these variables to be displayed.

/* You must create a procedure that returns full details of one of the tables of your choosing based on a given condition using the WHERE clause. 
Check chapter 17 and Video uploaded in Blackboard.
Example:
Create procedure procedure_name
AS
SELECT Columns
FROM table name
WHERE condition
EXEC procedure_name*/

CREATE PROCEDURE dbo.TOP_EVENTS
AS
SELECT TOP 3(NUMBER_OF_PATIENTS_REGISTERED),c.CUSTOMER_NAME,e.EVENT_DATE,m.STRATEGY_NAME, l.MARKETING_REP_NAME
FROM MARKETING_STRATEGIES m
JOIN CUSTOMERS c 
ON m.STRATEGY_ID=c.STRATEGY_ID
JOIN EVENT_HISTORY e 
ON c.LOCATION_ID=e.LOCATION_ID
JOIN LOCATIONS l
ON e.LOCATION_ID=l.LOCATION_ID
WHERE e.NUMBER_OF_PATIENTS_REGISTERED>5
ORDER BY e.NUMBER_OF_PATIENTS_REGISTERED desc
EXEC dbo.TOP_EVENTS;

/*In this query we are creating a new procedure named Top Events to see the top 3 Events with the highest amount of patients registered, the 
customer name, the event date, the strategy that was used, and the marketing representative in charge of the event. As we can see, we joing 4 different tables
such as: CUSTOMERS(alias c), MARKETING_STRATEGIES (alias m), EVENT_HISTORY(alias e), and LOCATIONS (alias l). As we can see from the syntax, we used the TOP  function
in the NUMER_OF_PATIENTS_REGISTERED column from the EVENT_HISTORY to only retrieve the TOP 3 events with the highest amount of patients. In addition, we used the WHERE clause 
to specify only the events in which the NUMBER_OF_PATIENTS_REGISTERED is greater than 5 and order the results in descending order
to retrieve the results from highest to lowest number of patients registered. As we can see from the results, the event with the highest amount of patients registered was from 
the customer named Fulton City Hospital, using a DIGITAL SIGNAGE strategy, event celebrated on the 25th of November of 2021 and managed by the marketing representative Alex Leon*/