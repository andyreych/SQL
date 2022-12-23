use master;
CREATE DATABASE Chapter6;-- We just created the database "Chapter6" in which we will use to create the tables
USE Chapter6;-- By using this query we make sure we are in the Chapter6 Database that we just created.
CREATE TABLE employee  (emp_no INTEGER NOT NULL, -- The column emp_no has interger data type and does not allow null values.
                    	emp_fname CHAR(20) NOT NULL, -- The column emp_fname has char data type up to 20 characters and does not allow null values.
                    	emp_lname CHAR(20) NOT NULL,-- The column emp_lnae has char data type up to 20 characters and does not allow null values.
                    	dept_no CHAR(4) NULL);--The column dept_no has a char data type up to 4 characters and does allow null values.  
/* We just created the table "employee" with the following columns: emp_no,emp_fname,dept_no*/
CREATE TABLE department(dept_no CHAR(4) NOT NULL,-- The column dept_no has a char data type up to 4 characters and does not allow null values.
                    	dept_name CHAR(25) NOT NULL,-- The column dept_name has a char data type up to 25 characters and does not allow null values
                    	location CHAR(30) NULL);-- The column location has a char data type up to 30 characters and does allow null values.
/* We just created the table "department" with the following columns: dept_no,dept_name, and location*/
CREATE TABLE project   (project_no CHAR(4) NOT NULL, -- The column project_no has a char data type up to characters and does not allow null values. 
                    	project_name CHAR(15) NOT NULL,--The column project_name has a char data type up to 15 characters and does not allow null values.
                    	budget FLOAT NULL);-- The budget column has a float data type and does allow null values.
/* We just created the table "project" with the following columns: project_no, project_name, and budget*/
CREATE TABLE works_on (emp_no INTEGER NOT NULL,-- The column emp_no has a interger data type and does not allow null values.
                    	project_no CHAR(4) NOT NULL,-- The column project_no has a char data type up to 4 characters and does not allow null values.
                    	job CHAR (15) NULL,-- The column job has a char data type up to 15 characters and does allow null values
                    	enter_date DATE NULL);-- The column enter_date has a date data type and does allow null values.
/* We just created the table "works_on with the following columns: emp_no, project_no, job, and enter_date*/ 
-- In addition, we are going to insert the values to populate our tables
insert into employee values(25348, 'Matthew', 'Smith','d3');
insert into employee values(10102, 'Ann', 'Jones','d3');
insert into employee values(18316, 'John','Barrimore','d1');
insert into employee values(29346, 'James',  'James','d2');
insert into employee values(9031,  'Elke','Hansel', 'd2');
insert into employee values(2581,  'Elsa','Bertoni', 'd2');
insert into employee values(28559, 'Sybill',  'Moser',	'd1');
insert into department values ('d1', 'Research',  'Dallas');
insert into department values ('d2', 'Accounting', 'Seattle');
insert into department values ('d3', 'Marketing',  'Dallas');
insert into project values ('p1', 'Apollo', 120000.00);
insert into project values ('p2', 'Gemini', 95000.00);
insert into project values ('p3', 'Mercury', 186500.00);
insert into works_on values (10102, 'p1',  'Analyst',  '2006.10.1');
insert into works_on values (10102, 'p3',  'Manager', '2008.1.1');
insert into works_on values (25348, 'p2',  'Clerk', '2007.2.15');
insert into works_on values (18316, 'p2',  NULL, '2007.6.1');
insert into works_on values (29346, 'p2',  NULL,'2006.12.15');
insert into works_on values (2581,  'p3',  'Analyst',  '2007.10.15');
insert into works_on values (9031,  'p1',  'Manager', '2007.4.15');
insert into works_on values (28559, 'p1',  NULL, '2007.8.1');
insert into works_on values (28559, 'p2',  'Clerk', '2008.2.1')
insert into works_on values (9031,  'p3',  'Clerk', '2006.11.15'); 
insert into works_on values (29346, 'p1',  'Clerk', '2007.1.4');

/* We added the values into the tables succesfully*/ 
--Now let us start working on some examples from Chapter 6 "Queries"
--What is the simplest retrieval form with the "Select" statement?

Use Chapter6;-- We make sure we are using the Chapter6 Database with the USE function.
Select dept_no,dept_name, location
from department;-- As we can see by using the SELECT function we are selecting the columns; 
--"dept_no,dept_name,location from the table named "department" as we can see from the output

--Use the Select Statement to retrieve the columns project_no,project_name and budget from the project table
--Make comments about the project_name and the budget

SELECT project_no, project_name , budget 
from project;
/* As we can see the output of the above function gave us the following results: 
project_no: 'p1','p2','p3'.
project_name: 'Apollo', 'Gemini', 'Mercury'
budget:'120000' for the Apollo project, '186500' for the Mercury Project, and '95000' for the Gemini Project.
As a result, we can say that Mercury is the project with the highest budget with 186500, 
followed by Apollo  with 120000 , and lastly Gemini with 95000*/

--Now let us use the "Where" clause to get the names and numbers of all departments located in Dallas

Use Chapter6; -- Again, we make sure we are using the Chapter6 database.
Select dept_name,dept_no
From department
where location='Dallas';
--What is the output,make some comments about the output
/* By using the select statement we get the following output:
dept_name: Research from dept_no 'd1'
dept_name: Marketing from dept_no 'd3'
We can come to the conclution that the departments "Research" and "Marketing" are the departments 
that are located in 'Dallas'*/

--Now use the works_on table to get the emp_no and the project_no for every manager,make some comments
SELECT emp_no,project_no 
FROM  works_on
where job='Manager'; 
/* By using the SELECT function we are selecting the emp_no, and the project_no from the works_on table 
in which we are specifying the job title 'Manager' by using the WHERE function. 
As we can see, the output is the following: 
emp_no: 101002 from project_no 'p3'
emp_no: 9031 from project_no 'p1' */

--Now let us get the last and first names of all employees with employee numbers greater than or equal to 15000:
Use Chapter6;
Select emp_lname,emp_fname
From employee
Where emp_no>=15000; 
--Make some comments about the output
/* By using the select function from the columns emp_lname, and emp_fname 
of the employee table and the WHERE emp_no >=15000. 
We are specifying that we are only selecting the values where the emp_no is greater than or 
equal to 15000. As a result, we get the following values: Matthew Smith, John Barrimore, James James, and Sybill Moser.*/

--Use a similar query to obtain a table with no values (hint:Every emp_no is less than 30000)
Use Chapter6;
Select emp_lname,emp_fname
From employee 
Where emp_no>30000;
/* As we can see the output of the previous function give us a table with no values because there is not an employee
with an  emp_no greater than 30000*/
/*Let us use a similar query to obtain the project name 
for every project with a budget greater than 50000 Euros 
(let us assume the exchange rate to be 0.79 euros for every dollar)*/
Use Chapter6;
Select project_name
From project
Where budget*0.79>50000;
--Make comments, does the current exchange rate have an impact on the materialization of the project?
/*As we can see from the output, all of the projects have a budget greater than 50000 euros because
-using this current rate( 0.79 Euros for every dollar) we are basically asking the system to select the 
names of every project with a budget greater than 39500 dollars ( 50000 Euros * 0.79) 
As we can see the projects 'Apollo', 'Gemini' , and 'Mercury' . They all have a budget greater than 50000 Euros*/

--Build a similar example using the exchange rate between US dollars and another currency.

/*Let us use a similar query to obtain the project name 
for every project with a budget greater than 100000 Chinese Yuan
(let us assume the exchange rate to be 6.33 yuan for every dollar)*/

Use Chapter6;
Select project_name
From project
Where budget*6.33>100000;
/* As we can see this query gave us the same results as before because every project has a budget greater than 
100000 Chinese Yuan due to the conversion rate ( 1 usd = 6.33 CNY)*/

--Now let us use a boolean operator to get the employee numbers
--for all employees who work for either project1 or project3

Use Chapter6; 
Select project_no,emp_no
From works_on
where project_no = 'p1'
Or project_no = 'p3';

/* As we can see from the results of this query, we are selecting the values of the project_no and the
emp_no columns from the works_on table in which the project_no is either 'p1' or 'p3'*/ 

--I would like you to obtain the project number for every employee with ID (emp_no) either 10102 or 9031
Use Chapter6; 
Select project_no
From works_on
where emp_no = '10102'
Or emp_no = '9031';
/* As we can see from the results of this query, we are selecting only the project numbers from
the project_no column of the works_on table where the emp_no is either '10102' or '9031'. 
The results where 'p1' and 'p3'*/  

--Let us take a look at an example of an illegal statement

Use Chapter6;
Select emp_fname,Distinct emp_no
From employee
where emp_lname ='Moser';

--We obtained an error since there is more than one column in the select list, let us fix this
Use Chapter6;

Select Distinct emp_fname
from employee
where emp_lname ='Moser';
--Make some comments about the output and run a similar query to obtain a table with more than one row
/* In the previous query we couldn't use the emp_fname because it was not part of the aggregate function 
"Distinct". In addition , the Distinct function eliminates duplicate values of a column so in the second query 
we could only get one emp_fname with the emp_lname 'Moser' */ 

SELECT Distinct enter_date
from works_on
where job = 'Analyst';

/* By using this similar query, we are selecting the enter dates (with no duplicates) using 
the distinct function from the works_on table where the job title is 'Analyst'. As we can see, 
the results are '2006.10.01' and '2007.10.15'*/

--The existence of several Boolean operations in a Where clause 
--complicates the corresponding Select statements, let us run the following piece of code:

Use Chapter6;
select emp_no,emp_fname,emp_lname
from employee
where emp_no=25348 and emp_lname ='Smith'
Or emp_fname='Matthew' and dept_no='d1'; 
select emp_no,emp_fname,emp_lname
from employee
where ((emp_no =25348 and emp_lname ='Smith')Or emp_fname='Matthew') and dept_no = 'd1';
--Make comments about the output
/* As we can see by using the select function were are selecting the emp_no
, the emp_fname, and the emp_lname from the employee table where the emp_no is '25348'
and the emp_lname is 'Smith' or where the emp_fname is 'Matthew' and the dept_no is 'd1'. Which the 
results confirm we did it succesfully. However, in the second query as we can see from the output,
by using the parenthesis to establish priorities we did not get the expected values like previously. 
There was no values selected.*/

--The Boolean Operatorhas different priorities for evaluation,let us use parentheses to obtain the expected outcome
Use Chapter6;
select emp_no,emp_fname,emp_lname
from employee
where (emp_no=25348 and emp_lname ='Smith')
Or (emp_fname='Matthew' and dept_no='d1'); /* In this query ,by using the parenthesis correctly we get the right output which is 
emp_no '25348', emp_fname 'Matthew', and emp_lname 'Smith'.*/

select emp_no,emp_fname,emp_lname
from employee
where ((emp_no =25348 and emp_lname ='Smith')
Or emp_fname='Matthew') and dept_no = 'd1';

--Now let us get the employee last name and first name of all employees who do not belong to department 1
Use Chapter6;
Select emp_fname,emp_lname
From employee
where Not dept_no='d1'; -- By using the function 'Not' we are selecting all values of the columns 
--the emp_fname, the emp_lname of the employees from the employee table that do not work in dept_no 'd1' 

--Devise a similar method to obtain a table that contains the employee 
--numbers and department for every employee whose last name is not Smith.
Use Chapter6;
Select emp_no,dept_no
From employee 
where not emp_lname='Smith';
/* As we can see the values of the columns emp_no, and dept_no were selected from the 
employee table in which the emp_lname is not 'Smith'*/ 


























