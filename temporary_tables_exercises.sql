# Using the example from the lesson, create a temporary table called employees_with_departments that contains first_name, last_name, 
# and dept_name for employees currently with that department. Be absolutely sure to create this table on your own database. 
# If you see "Access denied for user ...", it means that the query was attempting to write a new table to a database that you can only read.

SET SQL_SAFE_UPDATES = 0; #get out of safe mode w/o disturbing connection for 1175 error

USE jemison_1743;

CREATE TEMPORARY TABLE jemison_1743.employees_with_departments AS #user.TableName 
SELECT first_name,
	   last_name,
       dept_name
FROM employees.employees #table.database you want to use
JOIN dept_emp USING (emp_no)
JOIN departments USING (dept_no)
LIMIT 100;



SELECT *
FROM jemison_1743.employees_with_departments;

# a) Add a column named full_name to this table. 
# It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns

DESCRIBE jemison_1743.employees_with_departments;

ALTER TABLE jemison_1743.employees_with_departments
ADD full_name varchar(31);

SELECT *
FROM jemison_1743.employees_with_departments;

# b) Update the table so that full name column contains the correct data
UPDATE jemison_1743.employees_with_departments
SET full_name = CONCAT (first_name, ' ', last_name);

SELECT *
FROM jemison_1743.employees_with_departments;


# c) Remove the first_name and last_name columns from the table.
ALTER TABLE jemison_1743.employees_with_departments
DROP COLUMN first_name, DROP COLUMN last_name;

SELECT *
FROM jemison_1743.employees_with_departments;
# d) What is another way you could have ended up with this same table?




# Create a temporary table based on the payment table from the sakila database.
 
 CREATE TEMPORARY TABLE jemison_1743.sakila_payment AS
 SELECT *
 FROM sakila.payment;
 
 SELECT *
 FROM jemison_1743.sakila_payment
 LIMIT 100;
 
 SELECT amount * 100
 FROM jemison_1743.sakila_payment;


ALTER TABLE jemison_1743.sakila_payment 
MODIFY COLUMN amount decimal(6,2);

 SELECT *
 FROM jemison_1743.sakila_payment
 LIMIT 100;

UPDATE jemison_1743.sakila_payment
SET amount = amount * 100;

ALTER TABLE jemison_1743.sakila_payment
MODIFY amount INT(4); 

 SELECT *
 FROM jemison_1743.sakila_payment
 LIMIT 100;

 

# Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.



# Find out how the current average pay in each department compares to the overall, historical average pay. 
# In order to make the comparison easier, you should use the Z-score for salaries. 
# In terms of salary, what is the best department right now to work for? The worst?


	#Current 
CREATE TEMPORARY TABLE jemison_1743.current_avg AS
SELECT dept_name,
	   AVG(salary) AS dept_avg_current
FROM employees.salaries
JOIN employees.dept_emp USING (emp_no)
JOIN employees.departments USING (dept_no)
WHERE employees.dept_emp.to_date > now() #use whole name to prevent ambiguity
AND employees.salaries.to_date > now() #use whole name to prevent ambiguity
GROUP BY dept_name;

SELECT *
FROM jemison_1743.current_avg;

	#Historic
CREATE TEMPORARY TABLE jemison_1743.historic_avg AS
SELECT dept_name,
	   AVG(salary) AS dept_avg_historic
FROM employees.salaries
JOIN employees.dept_emp USING (emp_no)
JOIN employees.departments USING (dept_no)
GROUP BY dept_name;

SELECT *
FROM jemison_1743.historic_avg;

CREATE TEMPORARY TABLE jemison_1743.historic_single_avg AS
SELECT AVG(salary)
FROM employees.salaries;

SELECT *
FROM jemison_1743.historic_single_avg; # $63,810.74

# historic Z-Score
       #zscore  = (avg(x) - x) / std(x)
CREATE TEMPORARY TABLE jemison_1743.zscore_historic AS
SELECT salary,
	   (salary - (SELECT AVG(salary) FROM employees.salaries)) /
       (SELECT STD(salary) FROM employees.salaries) AS zscore_historic
FROM employees.salaries;

SELECT *
FROM jemison_1743.zscore_historic;

# Current zscore

/* CREATE TEMPORARY TABLE jemison_1743.zscore_current AS
SELECT salary,
	   (salary - (SELECT AVG(salary) FROM employees.salaries)) /
       (SELECT STD(salary) FROM employees.salaries) AS zscore
FROM employees.salaries;

DROP TABLE jemison_1743.zscore_current; */ #forgot to make it current

#zscore  = (avg(x) - x) / std(x)
CREATE TEMPORARY TABLE jemison_1743.zscore_current AS
SELECT salary,
	   (salary - (SELECT AVG(salary) FROM employees.salaries)) /
       (SELECT STD(salary) FROM employees.salaries) AS zscore_current
FROM employees.salaries
WHERE employees.salaries.to_date > now();

SELECT *
FROM jemison_1743.zscore_current;

#create historic zscore per dept
CREATE TEMPORARY TABLE jemison_1743.historic_zscore AS
SELECT dept_name, 
       (salary - (SELECT AVG(salary) FROM employees.salaries)) /
       (SELECT STD(salary) FROM employees.salaries) AS zscore_historic
FROM employees.salaries
JOIN employees.dept_emp USING (emp_no)
JOIN employees.departments USING (dept_no)
GROUP BY dept_name, zscore_historic;

SELECT *
FROM jemison_1743.historic_zscore;

	

# Find overall zscore = (department avg - historical average)/std(historical data)
USE jemison_1743;

CREATE TEMPORARY TABLE jemison_1743.overall_dept_zscore AS
SELECT (dept_avg_current - (SELECT AVG(salary) FROM employees.salaries)) /
       (SELECT STD(salary) FROM employees.salaries) AS dept_zscore
FROM historic_single_avg; #doesn't work -_-

CREATE TEMPORARY TABLE jemison_1743.avg_std_historic AS
SELECT AVG(salary) AS avg_historic_sal, STD(salary) AS std_historic_sal
FROM employees.salaries;

SELECT *
FROM jemison_1743.avg_std_historic;


#FINAL TABLE
#have dept name, current average/dept, abs(current avg - historic avg), std, zscore/dept 


# Question 3 re-write 我真的不知道我應該寫 
#Current 
CREATE TEMPORARY TABLE jemison_1743.current_avg AS
SELECT dept_name,
	   AVG(salary) AS dept_avg_current
FROM employees.salaries
JOIN employees.dept_emp USING (emp_no)
JOIN employees.departments USING (dept_no)
WHERE employees.dept_emp.to_date > now() #use whole name to prevent ambiguity
AND employees.salaries.to_date > now() #use whole name to prevent ambiguity
GROUP BY dept_name;

#Historic
CREATE TEMPORARY TABLE jemison_1743.historic_avg AS
SELECT dept_name,
	   AVG(salary) AS dept_avg_historic
FROM employees.salaries
JOIN employees.dept_emp USING (emp_no)
JOIN employees.departments USING (dept_no)
GROUP BY dept_name;

#Historic STD and AVG salary
CREATE TEMPORARY TABLE jemison_1743.avg_std_historic AS
SELECT AVG(salary) AS avg_historic_sal, STD(salary) AS std_historic_sal
FROM employees.salaries;


ALTER TABLE jemison_1743.current_avg #add column for historic avg
ADD historic_avg FLOAT(10,2);

ALTER TABLE jemison_1743.current_avg #add column for current avg
ADD historic_std FLOAT(10,2);

ALTER TABLE jemison_1743.current_avg
DROP COLUMN zcore;

ALTER TABLE jemison_1743.current_avg #add column for zscore
ADD zscore FLOAT(10,2);

SELECT * 
FROM jemison_1743.current_avg;

CREATE TEMPORARY TABLE jemison_1743.historic_single_avg AS
SELECT AVG(salary)
FROM employees.salaries;


UPDATE jemison_1743.current_avg #update table to include the company historic avg
SET historic_avg = (SELECT AVG(salary)
					FROM employees.salaries);

UPDATE jemison_1743.current_avg #update table to include historic std 
SET historic_std = (SELECT std_historic_sal
					FROM jemison_1743.avg_std_historic);

#calculate and add zscore now that all necessary columns have been added and filled
UPDATE jemison_1743.current_avg
SET zscore = (dept_avg_current - historic_avg)/ historic_std;

SELECT *
FROM jemison_1743.current_avg
ORDER BY zscore desc;
