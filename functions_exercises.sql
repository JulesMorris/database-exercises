USE employees;


# 2) Write a query to to find all employees whose last name starts and ends with 'E'. 
# Use concat() to combine their first and last name together as a single column named full_name.

SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM employees
WHERE last_name LIKE 'E%e';

# 3) Convert the names produced in your last query to all uppercase.
SELECT UPPER(CONCAT(first_name, ' ', last_name)) AS full_name
FROM employees
WHERE last_name LIKE 'E%E';

# 4) Find all employees hired in the 90s and born on Christmas. Use datediff() function to find how
 # many days they have been working at the company (Hint: You will also need to use NOW() or CURDATE()),

SELECT *, DATEDIFF(CURDATE(), hire_date) AS tenure_in_days
FROM employees
WHERE hire_date LIKE '199%'
AND birth_date LIKE '%-12-25'
ORDER BY hire_date DESC;

SELECT *, DATEDIFF(CURDATE(), hire_date)/365 AS tenure
FROM employees
WHERE hire_date LIKE '199%'
AND birth_date LIKE '%-12-25'
ORDER BY hire_date DESC;


# 5) Find the smallest and largest current salary from the salaries table.
SELECT * 
FROM salaries;
 
SELECT MAX(salary), MIN(salary)
FROM salaries
WHERE to_date > CURDATE();
	-- to_date should be greater than (read: older than) CURDATE() or NOW() b/c it's industry practice. 


# 6) Use your knowledge of built in SQL functions to generate a username for all of the employees. 
# A username should be all lowercase, and consist of the first character of the employees first name, 
# the first 4 characters of the employees last name, an underscore, the month the employee was born, 
# and the last two digits of the year that they were born.

-- *** REMEMBER, substr uses the index first and then how many characters from that index point you want to capture!***
	-- * So first substr reads, take the first letter from the first name. Second substr reads: take the first four characters from last_name, and final substr
    -- * reads, take the last two digits of birth month (which begins at index 3 in a format YEAR-MO-DY). SUBSTR is INCLUSIVE so starting at index 3 for 2 characters gets you 3 & 4***
SELECT LOWER(CONCAT(SUBSTR(first_name, 1, 1), 
					SUBSTR(last_name, 1, 4), '_', 
					SUBSTR(birth_date, 6, 2), 
                    SUBSTR(birth_date, 3, 2))) AS username, first_name, last_name, birth_date
FROM employees;