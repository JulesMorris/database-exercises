# 1) Find all the current employees with the same hire date as employee 101010 using a sub-query.

USE employees;

SELECT *
FROM employees
WHERE emp_no = '101010'; #1990-10-22



SELECT CONCAT(e.first_name, ' ', e.last_name) AS 'Employee Name',
	   hire_date
FROM employees AS e
JOIN dept_emp USING (emp_no)
WHERE hire_date = '1990-10-22'
AND to_date = '9999-01-01';

# Subquery
SELECT *
FROM employees
JOIN dept_emp USING (emp_no)
WHERE to_date = '9999-01-01'
AND hire_date =
	(SELECT hire_date
     FROM employees
     WHERE emp_no = 101010);


# 2) Find all the titles ever held by all current employees with the first name Aamod.


SELECT title
FROM titles
JOIN employees USING (emp_no)
WHERE first_name = 'Aamod'; #314 titles held by person named Aamod

#current
SELECT title
FROM titles
JOIN employees USING (emp_no)
WHERE first_name = 'Aamod'
AND to_date = '9999-01-01'; #168 rows returned

# SUBQUERY
SELECT DISTINCT title
FROM titles
WHERE emp_no IN (
	SELECT emp_no
    FROM employees
    JOIN dept_emp USING (emp_no)
    WHERE first_name = 'Aamod'
    AND to_date = '9999=01-01');
    

# 3) How many people in the employees table are no longer working for the company? 
	# should be 59,900

# SUBQUERY 
SELECT COUNT(*)
FROM employees
WHERE emp_no NOT IN
	(SELECT emp_no
     FROM dept_emp
     WHERE to_date > now());

-- 59,900

# USING salaries table
SELECT COUNT(*)
FROM employees
WHERE emp_no NOT IN
	 (SELECT emp_no
      FROM salaries
      WHERE to_date > now());

# 4) Find all the current department managers that are female. 
#List their names in a comment in your code.
SELECT *
FROM dept_manager
WHERE to_date = '9999-01-01';


SELECT CONCAT(first_name, ' ', last_name) AS female_dept_mgr, 
       dept_name
FROM employees
JOIN dept_manager USING (emp_no)
JOIN departments USING (dept_no) 
	WHERE to_date = '9999-01-01'
    AND gender = 'F';
    
    
# SUBQUERY 
SELECT *
FROM employees
WHERE emp_no IN (
					SELECT emp_no
                    FROM dept_manager
                    WHERE to_date > now())
					AND gender = 'F';

-- Isamu Legleitner, Karsten Sigstam, Leon DasSarma, Hilary Kambil

# 5) Find all the employees who currently have a higher salary than the companies overall, historical average salary

#historcal avg sal for all employees

SELECT ROUND(AVG(salary), 0) AS hist_avg_sal
FROM salaries; # $63,811


SELECT CONCAT(first_name, ' ', last_name) AS emp_name, 
       ROUND(AVG(salary), 0) AS current_salary_avg      
FROM employees
JOIN salaries USING (emp_no)
WHERE salary > (SELECT AVG(salary) FROM salaries)
AND salaries.to_date = '9999-01-01' #formal name of table pulling to_date from
GROUP BY emp_name, salary
ORDER BY salary; 

#SUBQUERY 
SELECT COUNT(emp_no)
FROM salaries AS s
JOIN employees AS e USING (emp_no)
WHERE to_date > now()
AND salary > (
			  SELECT AVG(salary)
              FROM salaries); 
-- 154,543




# 6) How many current salaries are within 1 standard deviation of the current highest salary? 
#(Hint: you can use a built in function to calculate the standard deviation.) 
#What percentage of all salaries is this?

    #Hint Number 1 You will likely use a combination of different kinds of subqueries.
    #Hint Number 2 Consider that the following code will produce the z score for current salaries.
SELECT MAX(salary)
FROM salaries
WHERE to_date = '9999-01-01'; # $158,220

SELECT salary,
	   (salary - (SELECT AVG (salary) FROM salaries)) /
       (SELECT stddev(salary) FROM salaries) AS zscore
FROM salaries;


SELECT (MAX(salary) - STDDEV(salary)) AS sal_within_one_stddev_of_max 
FROM salaries
WHERE to_date > CURDATE(); # 140,910.04 Make this the subquery

#count salaries within one 

SELECT COUNT(salary) AS num_of_sal_within_one_stddev_of_max
FROM salaries
WHERE to_date > CURDATE()
AND salary > (SELECT (MAX(salary) - STDDEV(salary)) AS sal_within_one_stddev_of_max 
FROM salaries
WHERE to_date > CURDATE()); # 83 salaries

#find percentage

SELECT CONCAT(
       (SELECT 
       COUNT(salary) AS num_of_sal_within_one_stddev_of_max
	   FROM salaries
	   WHERE to_date > CURDATE()
       AND salary > (SELECT (MAX(salary) - STDDEV(salary)) AS sal_within_one_stddev_of_max 
       FROM salaries
       WHERE to_date = '9999-01-01'))
       / 
(SELECT 
COUNT(*)
FROM salaries
WHERE to_date = '9999-01-01') * 100, '%') AS percent_of_sal_with_one_stddev_of_max; 

-- 0.0346%



# Bonus 1: Find all the department names that currently have female managers.
SELECT dept_name, 
CONCAT(first_name, ' ', last_name) AS female_dept_manager
FROM dept_manager
JOIN employees USING (emp_no)
JOIN departments USING (dept_no)
WHERE gender = 'F'
AND to_date = '9999-01-01';
-- Finance, HR, Development, Research

# Bonus 2: Find the first and last name of the employee with the highest salary.
SELECT MAX(salary),
	   CONCAT(first_name, ' ', last_name) AS employee_name
FROM salaries
JOIN employees USING (emp_no)
GROUP BY employee_name, salary
ORDER BY salary DESC
LIMIT 1;
-- Tokuyasu Pesch

# Bonus 3: Find the department name that the employee with the highest salary works in.
SELECT dept_name,
	   CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
       MAX(salary)
FROM employees AS e
JOIN salaries USING (emp_no)
JOIN dept_emp USING (emp_no)
JOIN departments USING (dept_no)
GROUP By employee_name, salary, dept_name
ORDER BY salary DESC
LIMIT 1;
-- Sales


       

