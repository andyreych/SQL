-- In this Lecture we will continue querying databases, in particular the database created at the beginning of chapter one.
--First, let us work with the IN and BETWEEN operators
-- Let us first "create" the Database

CREATE DATABASE Chapter7; -- Now we created the database named "Chapter7"
USE Chapter7; -- By using this query we make sure we are connected to Chapter7 database.

CREATE TABLE employee  (emp_no INTEGER NOT NULL,-- The column emp_no has integer data type and does not allow null values
                    	emp_fname CHAR(20) NOT NULL,-- The column emp_fname has char data type limited to 20 characters and does not allow null values
                    	emp_lname CHAR(20) NOT NULL,-- The column emp_lname has a char data type limited to 20 characters and does not allow null values
                    	dept_no CHAR(4) NULL);-- The column dept_no has a char data type limited to 4 characters and does allow null values.
CREATE TABLE department(dept_no CHAR(4) NOT NULL,--The column dept_no has a char data type limited to 4 characters and does not allow null values.
                    	dept_name CHAR(25) NOT NULL,-- The column dept_name has a char data type limited to 25 characters and does not allow null values
                    	location CHAR(30) NULL);-- The column location has a char data type limited to 30 characters and does allow null values
CREATE TABLE project   (project_no CHAR(4) NOT NULL,-- The column project_no has a char data type limited to 4 characters and does not allow null values
                    	project_name CHAR(15) NOT NULL,-- The column project_name has a char data type limited to 15 characters and does not allow null values
                    	budget FLOAT NULL); -- The budget column has a float data type and does allow null values.
CREATE TABLE works_on (emp_no INTEGER NOT NULL,-- The emp_no has interger data type and does not allow null values.
                    	project_no CHAR(4) NOT NULL,-- The project_no has a char data type limited to 4 characters and does not allow null values.
                    	job CHAR (15) NULL, -- The job column has a char data type limited to 15 characters 
                    	enter_date DATE NULL); -- The enter_date column has a date data type and does allow null values.
insert into employee values(25348, 'Matthew', 'Smith',	'd3');
insert into employee values(10102, 'Ann', 	'Jones',	'd3');
insert into employee values(18316, 'John',	'Barrimore','d1');
insert into employee values(29346, 'James',   'James',	'd2');
insert into employee values(9031,  'Elke',	'Hansel',   'd2');
insert into employee values(2581,  'Elsa',	'Bertoni',  'd2');
insert into employee values(28559, 'Sybill',  'Moser',	'd1');
insert into department values ('d1', 'Research',   'Dallas');
insert into department values ('d2', 'Accounting', 'Seattle');
insert into department values ('d3', 'Marketing',  'Dallas');
insert into project values ('p1', 'Apollo', 120000.00);
insert into project values ('p2', 'Gemini', 95000.00);
insert into project values ('p3', 'Mercury', 186500.00);
insert into works_on values (10102, 'p1',  'Analyst', '2006.10.1');
insert into works_on values (10102, 'p3',  'Manager', '2008.1.1');
insert into works_on values (25348, 'p2',  'Clerk', '2007.2.15');
insert into works_on values (18316, 'p2',  NULL, '2007.6.1');
insert into works_on values (29346, 'p2',  NULL, '2006.12.15');
insert into works_on values (2581,  'p3',  'Analyst', '2007.10.15');
insert into works_on values (9031,  'p1',  'Manager', '2007.4.15');
insert into works_on values (28559, 'p1',  NULL, '2007.8.1');
insert into works_on values (28559, 'p2',  'Clerk', '2008.2.1')
insert into works_on values (9031,  'p3',  'Clerk', 	'2006.11.15'); 
insert into works_on values (29346, 'p1',  'Clerk', '2007.1.4');
--Now let us get full details  for every employee whose employee number equals 29346,28559, or 25348

--The idea of this exercise is to be able to use the IN and BETWEEN operators
USE Chapter7;
select emp_no,emp_fname,emp_lname
from employee
where emp_no in (29346,28559,25348);
/* By using the IN function we get the emp_no,emp_fname, and emp_lname where the emp_no is 29346, 28559,
and 25348. As a result, we get the names Matthew Smith, James James, and Sybill Moser*/ 
-- Now I want you to obtain the first and last name for every employee whose id number equals 9031 or 18316
USE Chapter7;
select emp_no,emp_fname,emp_lname
from employee
where emp_no in (9031,18316);
/* In this case, we use the IN function to get the emp_fname, and emp_lname whose emp_no is 9031 and 18316.
The results are John Barrimore, and Elke Hansel*/ 

--In addition (in a different query), i would like you to 
--get the project number for every employee that is either an analyst or a Manager.
Use Chapter7;
select distinct project_no 
FROM works_on
where job in ('Analyst','Manager'); 
--I would like you to make comments on the output and to talk about 
--the importance (if any) of using the Distinct clause in this query.
/* By using the Distinct clause in this query we are able to see the project_no without duplicates  for 
every employee that is either an Analyst or a Manager*/
-- Now let us combine the IN operator and the Boolean operator NOT

--Let us get the first name and the department number for every employee whose emp_no is neither 25348 nor 29346:
Use Chapter7;
select emp_fname,dept_no
from employee
where emp_no NOT in (25348,29346);

-- I would like you to obtain the budget amount and the project 
--number for a project whose name is neither Gemini nor Mercury.

Use Chapter7;
select budget,project_no
from project
where project_name not in ('Gemini','Mercury')
/* By using the not in clause in this query we get the budget amount which is 120000 and 
project_no which is p1*/

--Now we are interested in determining a range (bounds)so it is time to start working with the  BETWEEN operator
--Let us get the employee last names for everyone whose employee number is between 10000 and 20000:

Use Chapter7;
select emp_lname
from employee
where emp_no between 10000 and 20000;
/* By using the between clause in this query we are able to see the emp_lname whose emp_no is between 10000
and 20000 which is Jones Barrimore*/ 
--I would like you to obtain the name of every project whose budget is between 50000 and 100000
Use Chapter7;
select project_name
from project
where budget between 50000 and 100000;
/* By using the between clause in this query we are able to select the project_name of the 
project table in which the budget is between 50000 and 100000*/ 

--Create a query that gives you the same output like the one you just created without using the BETWEEN clause
Use Chapter7;
Select project_name 
from project 
where budget>=50000 and budget<=100000;
/* By using the operators we are able to create a range from greater or equal than 50000
and less or equal than 100000 which give us the project_name of the previous output which is Gemini*/ 

--Now I will determine the last name for every employee whose employee number is NOT between 10000 and 20000:

Use Chapter7;
select emp_lname
from employee
where emp_no Not between 10000 and 20000;

--Do we have strong evidence to sustain that the employee ID is related to the last names alphabetical order?
Use Chapter7;
Select *from employee order by emp_no; 
/* No we don't have strong evidence to sustain the claim that the emp_no is related to the 
last names of the employees in alphabetical order because as we select all of the values of the employee table 
and we organize it by emp_no we can see that the emp_no don't follow a specific order related to aplhabetical
order of the emp_lname of the employees. For example, as we order the values by emp_no the First value of emp_lname is Bertoni with an employe_no of 2581, 
following that value we have of emp_lname is Hansel with an emp_no 9031.*/

--Is it possible to create a query that gives us  the employees last names ordered in descending order? Explain.
-- Yes it is possible, as I mentioned in the previous query we can order the results of the output by using 
-- order by clause. For example: 
Use Chapter7;
Select *from employee order by emp_lname; 

--Now let us start working with the NULL operator.
--Let us get the employee number for employees with unknown jobs who work on project p1:
use chapter7;
select emp_no,project_no
from works_on
where project_no ='p1'
and job is null;

--Does the fact that the job is Null means something in particular 
--about the role of that person in the company?Explain.
/* No, what it means is that the job title is undefined, unknown or the column job has a 
null value.*/ 

--Obtain the date that all employees that worked on project p1 started the project if 
--the job category is unknown. Explain results.
Use Chapter7;
select enter_date
from works_on
where project_no='p1'
and job is null;
/* By using the is null clause in this query we get the dates in which all 
the employees who worked on project p1 that the job is a null value. Which in this case is only one 
date which is 2007-08-01*/ 
--Now let us have the column task  where we will specify that Null means Job unknown

--Also we will introduce the ISNULL system function (make comments about it)

use Chapter7;
select emp_no,ISNULL (job,'Job unknown') as task
from works_on
where project_no ='p1';
/* In this query we are asking the system to return a specific value if the expression is NULL.
In this case the specified value is 'Job unknown' if the value is null in the job column, and 
we rename the job column into task.*/

-- Now obtain a table displaying as much information as possible 
--about every employee who falls under the category 'job unknown'.

use Chapter7;
select *, ISNULL(job,'Job unknown') as job_category
from works_on
where job is null; 

/* As we can see the Job unknown category refers to the job in which there is a null value.
In addition, by using the "*" and the "is null" clause 
in this query we are selecting all of the values about every 
employee who falls under the category of 'job unknown'*/

--Now we are going to start working with the LIKE operator, as the number suggests is used for pattern matching.

--The wildcard characters % specifies any sequence of zero or more characters.

--The wildcards character _ specifies any single character.
--Let us then find the first and last name of all employees whose last name 
--contains the letter s as the third character:
use Chapter7;
select emp_fname,emp_lname
from employee
where emp_lname like '__s%';
--Make some comments about the query we just used.
/* By using the like clause and the wildcard character % and adding two underscores "__" we are specifying 
the emp_lname that cointains "s" as a third character which in this case is Moser*/ 

--Now create a query to find the employee first name and ID number for every employee 
--with a 3 as the third character in the emp_no (ID).

Use Chapter7;
select emp_fname,emp_no
from employee
where emp_no like '__3%';

/* As we can see, the output of this query gave us the following results: Matthew, John, James, and Elke. 
This is because they all share 3 as a third character in the emp_no (ID).*/ 

--Now let us get the department name and location for all departments whose location 
--has the second character in the range A through D:

use Chapter7;
select dept_name,location
from department
where location like '_[A-D]%';
/* As we can se by using the brackets [A-D]% we are establishing a range between A and D 
for the second character of our location value*/ 

--Now run a similar query to obtain first name, last name, and employee number for every employee 
--whose first character in the ID number is between 1 and 4.

use Chapter7;
select emp_fname,emp_lname,emp_no
from employee
where emp_no like '[1-4]%';

--Let us make this more interesting, let us get the employee numbers and last names for all employees whose 
--last name does not  begin with the letter B or S.

use Chapter7;
select emp_fname,emp_lname
from employee
where emp_lname like '[^BS]%';

--Make some comments about the clause and operators used in the query above.
/* By using the like operator with the where clause in the query we are looking for a specific pattern, which 
in this case we are using the brackets [^BS]% to specify wich character not to look for, which in this case is
to look for the last names of all employees whose last name does not begin with the letter B or S*/ 

--Can you obtain a table that displays the employee ID as well as the first and last name for every employee 
--whose id is not in the range 1-5?
use Chapter7;
select emp_no,emp_fname,emp_lname
from employee
where emp_no like '[^1-5]%';
/* Yes, as long as we specify inside the brackets following by the ^ the range in which we will like to exclude the 
results. Which, in this case the range we would like to exclude the emp_no is from 1-5. As a result, 
we get the following output: emp_no 9031, emp_fname Elke, and emp_lname Hansel*/

--Can you also create a query that displays the first and last name for every employee 
--whose first name does not begin with the letters A,B,C or D?

use Chapter7;
select emp_no,emp_fname,emp_lname
from employee
where emp_fname like '[^A-B-C-D]%';

--Please make some comments about the queries you just created and list what the most common error could be.
/* The most common problem in my opinion could be confusing the amount of underscores "_" to determine the position
of the character we are using to substitute or to find a pattern.*/

--As a database administrator, what could be done to confirm that a specific 
--employee queried the database properly for these particular exercises.
/* One of the querys I would use to confirm the employee queried the database properly would be 
 to query the opposite values to check none of those values are repeated. For example, 
 to see if the employee queried the employee first names that do not start with the letters A,B,C, and D
 would be to use the not like clause in '[A-B-C-D]%' . In addition, I would check the values of the tables 
 too look for any discrepancies.*/

--Now let us get full details of all employees whose last name does not end with the character m:

use Chapter7;
select emp_no,emp_fname,emp_lname
from employee
where emp_lname not like '%m';

--Now create a query to obtain full details of every employee whose first name does end with an s.

use Chapter7;
select emp_no,emp_fname,emp_lname
from employee
where emp_lname like '%s';

--In addition, let us obtain the location and department name of every department whose name does end with a g.

Use Chapter7;
select dept_name,location
from department
where dept_name like '%g'; 

 --Now let us do a couple of queries using the GROUP BY clause
 --The GROUP BY clause defines one or more columns as a group such that all rows within any group have the same values for those columns.
 --Let us go to the table works_on and obtain all starting dates for the projects:

 Use chapter7;
 select enter_date
 from works_on
 group by enter_date;

 --What if I asked you to obtain all project numbers from the table project?
 
 Use chapter7;
 select project_no
 from project
 group by project_no;
 --Let us get more creative now and obtain an output that is basically the combination of two columns
 --I want to obtain the first and last name of every employee so I will query the table employee
Use chapter7;
 select emp_fname,emp_lname
 from employee
 group by emp_fname,emp_lname;

--Now I would like you to query the table works_on and obtain project number and Job category only.

Use Chapter7
select project_no,job
from works_on
group by project_no,job;

























