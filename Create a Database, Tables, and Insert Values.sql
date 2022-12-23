
-- This Transact-SQL script creates all tables that are used
-- in the book "SQL Server 2016: A Beginner's guide".
-- It also loads all data in the four existing tables.
-- NOTE, please !!
-- Create first the database (sample), using CREATE DATABASE statement

CREATE DATABASE sample;
USE sample;
CREATE TABLE employee  (emp_no INTEGER NOT NULL, --The data type for emp_no is integer
                    	emp_fname CHAR(20) NOT NULL, --The data type for emp_fname is char(20)
                    	emp_lname CHAR(20) NOT NULL, -- The data type for emp_lname is char(20)
                    	dept_no CHAR(4) NULL); -- The data type for dept_no is char(4)
						--and accepts null values;so, we think that some employees
						-- might not belong to any department in particular
-- Here we are about to create the department table, this table stores dept_no,dept_name, and location

CREATE TABLE department(dept_no CHAR(4) NOT NULL, -- The data type for dept_no is char(4)
                    	dept_name CHAR(25) NOT NULL, -- The data type for dept_name is char(25)
                    	location CHAR(30) NULL); -- The data type for location char(30)
-- Now let's create the Project table, this table stores project_no, project_name, and budget
CREATE TABLE project   (project_no CHAR(4) NOT NULL, -- The data type for project_no is char(4)
                    	project_name CHAR(15) NOT NULL, -- The data type for project_name is char(15)
                    	budget FLOAT NULL); 
-- Here we will create a table (relationship) works_on which includes information about the
-- relationship between employees and projects. This is not an entity.
CREATE TABLE works_on (emp_no INTEGER NOT NULL,
                    	project_no CHAR(4) NOT NULL,
                    	job CHAR (15) NULL,
                    	enter_date DATE NULL);
-- Here we will insert values such as first and last name of each employee into the employee table 

insert into employee values(25348, 'Matthew', 'Smith',	'd3');
insert into employee values(10102, 'Ann', 	'Jones',	'd3');
insert into employee values(18316, 'John',	'Barrimore','d1');
insert into employee values(29346, 'James',   'James',	'd2');
insert into employee values(9031,  'Elke',	'Hansel',   'd2');
insert into employee values(2581,  'Elsa',	'Bertoni',  'd2');
insert into employee values(28559, 'Sybill',  'Moser',	'd1');
--Here we will confirm if all the employee values were added into the table 
SELECT *From employee
--Here we will proceed by adding values to the department table
insert into department values ('d1', 'Research',   'Dallas');
insert into department values ('d2', 'Accounting', 'Seattle');
insert into department values ('d3', 'Marketing',  'Dallas');
--Here we will confirm that we added all the values to the department correctly
SELECT *From department
--Here we will add the values for the project tables 
insert into project values ('p1', 'Apollo', 120000.00);
insert into project values ('p2', 'Gemini', 95000.00);
insert into project values ('p3', 'Mercury', 186500.00);
-- We will confirm that the values were added into the project table by: 
SELECT *From project
-- Here we will add values into the relationship table named works_on 
insert into works_on values (10102, 'p1',  'Analyst',   '2006.10.1');
insert into works_on values (10102, 'p3',  'Manager',   '2008.1.1');
insert into works_on values (25348, 'p2',  'Clerk', 	'2007.2.15');
insert into works_on values (18316, 'p2',  NULL,    	'2007.6.1');
insert into works_on values (29346, 'p2',  NULL,    	'2006.12.15');
insert into works_on values (2581,  'p3',  'Analyst',   '2007.10.15');
insert into works_on values (9031,  'p1',  'Manager',   '2007.4.15');
insert into works_on values (28559, 'p1',  NULL,    	'2007.8.1');
insert into works_on values (28559, 'p2',  'Clerk', 	'2008.2.1')
insert into works_on values (9031,  'p3',  'Clerk', 	'2006.11.15'); 
insert into works_on values (29346, 'p1',  'Clerk', 	'2007.1.4');
-- Here we will confirm that the values were added correctly into thr works_on table
SELECT *From works_on


/*Questions:
Upload the sample database along with your comments (100 words at least) and answers to the following questions:
What is the primary key in the works_on table?
There is no primary key in the works_on table. However, there is a composite key with emp_no and project_no
How many tables do we have in this database?
We have four tables in this database which are: employee, department, project, and work_on
How many entities do we have in this database?
We have three entities in this database which are:Department, employee, and project
What is the name of our database?
The name of our database is sample
How many records do we have on each table?
We have three records in the department table which are: Research,Accounting, and Marketing. 
In addition, We have seven records in the Employee table which are: Mathew Smith, Ann Jones, John Barrimore, James James, Elke Hansel,
Elsa Bertoni, and Sybill Moser.
Futhermore, We have eleven records in the Works_on table.
Which field would you add to every table (if any) and why?
I would add an email and a phone number of each employee for contact information. In my opinion, having the contact information of
each employee is useful in case of changes in the work schedule, set up meetings, or simply emergency contact for the projects*/



