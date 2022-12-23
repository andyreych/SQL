/*Welcome to Lecture 12, as we already discussed last class we are going to be working with the UPDATE and DELETE statements (Chapter VII) today.*/

/*Let us start by assigning several rows to the temporary table we created in the previous handout. Is this possible? Why not?Then let us use the INSERT statement (DML statement) to insert several rows into the 'employee_enh' table from the sample database. Do you all remember how this table was created?*/

use Chapter7;
insert into employee_enh values
(32390,'Andy','Young', 'd2','Miami'),
(41012,'James', 'Gordon', 'd1', 'Boca'),
(43002, 'Glenn', 'Spencer', 'd3','Miami'); 

/*Explain what we just did to the Chapter7 database (first take a look at the modified table, 
hint:select *from employee_enh) and in particular to the table employee_enh. 
Do you perceive a logical reason for the company to ask us to complete this 
(you are a database administrator for the company) ?
 Now Insert two rows into each of the tables that we have in the chapter7 (or sample) database. Make comments about your choices. Describe a hypothetical case scenario for your choices.*/
/* Let us now use the UPDATE statement (modifies values of tables rows) to modify the project for an employee.*/
use Chapter7;
update works_on --see 7.11
set job='Null'
where emp_no='9031'
and project_no='p3';

/*Explain how our database was affected by this change [always double-check by running (SELECT *FROM works_on)]. In addition, run a similar query to set to 'temporary' the task of each employee whose job category is unknown.*/

/*Now I would like you to change the budget of all projects to be represented in Mexican Pesos.*/

use Chapter7;
update project
set budget = budget*18.80;

/*Let us now take a look at the output.*/

select *from project;

/*Explain how my table "project" was affected. Run a similar query assuming the company is using a different foreign currency to estimate the budget. Explain your choice.*/

/*Can you explain the query below. Would you have created a different query to obtain the same output? Is the query below logically correct?*/

use Chapter7;
update works_on
set job ='Revenue'
from works_on,project
where emp_no>20000
and works_on.project_no=project.project_no;

/*Create a similar query to set the department number to 'd1' for every person with the last name Smith with the same ID number in the employee and works_on table.*/

/*Let us now work with the DELETE statement. The company is cutting funds and we were asked to delete the employees with less seniority from the database because they are no longer part of the company.*/

use Chapter7;
delete from employee
where emp_no>29000;

/*Now create a similar query to delete every employee from Miami. Was any row affected, why?*/
/*Let us now combine the WHERE clause and the DELETE statement to form an inner query.*/

use Chapter7;
delete from employee_enh
where emp_no in
(select emp_no
from employee_enh
where emp_fname like '__h%');

/* Please explain the output as well as the query we just created above. Now, create a similar query that deletes every employee whose last name ends with an M. Explain the output. Now complete a similar task if the last name ends in r.*/


/*Can you explain the query below. Was any row affected?Why?*/

delete from employee_enh
where emp_lname like '__h%';

/*What if we want to delete all rows of a table. Do not execute the query below, just make comments about it.*/

use Chapter7;
delete from works_on;

/*Would it make sense to execute a similar query to delete all the rows from any of our tables.*/

