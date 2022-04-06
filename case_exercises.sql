#QUESTION 1
# Write a query that returns all employees, their department number, their start date, their end date, 
# and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.

USE employees;

SELECT first_name, 
       last_name, 
       dept_no, 
       hire_date, 
       to_date,
			IF (to_date = '9999-01-01', 1, 0)
			AS is_current_employee
FROM employees
JOIN dept_emp USING (emp_no); # provides inaccurate results when try to do as CASE, why?


# QUESTION 2
# Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 
# 'I-Q', or 'R-Z' depending on the first letter of their last name.

SELECT CONCAT(first_name, ' ', last_name) AS full_name,
			CASE 
				WHEN LEFT(last_name, 1) IN ('a', 'b', 'c', 'd', 'e', 'f', 'g', 'h') THEN 'A-H'
                WHEN LEFT(last_name, 1) IN ('i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q') THEN 'I-Q'
                ELSE 'R-Z'
			END AS alpha_group
FROM employees;

# QUESTION 3
# How many employees (current or previous) were born in each decade?
SELECT birth_date
FROM employees
ORDER BY birth_date 
LIMIT 100; #eldest employee born 1952

SELECT birth_date
FROM employees
ORDER BY birth_date DESC
LIMIT 100; #youngest employee born 1965

SELECT COUNT(*)
FROM employees; # 300,024

SELECT 
	CASE
		WHEN birth_date LIKE ('195%') THEN 'Born in 50s' # 182,886
        WHEN birth_date LIKE ('196%') THEN 'Born in 60s' # 117,138
	END AS decade_born, # need this comma because case is in select statement and count comes after in the select statement
    COUNT(*)
FROM employees
GROUP BY decade_born; 

# QUESTION 4
# What is the current average salary for each of the following department groups: 
# R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?
SELECT *
FROM departments;
 
SELECT
	CASE
		WHEN dept_name IN ('Research', 'Development') THEN 'R&D'
        WHEN dept_name IN ('Sales', 'Marketing') THEN 'Sales & Marketing'
        WHEN dept_name IN ('Production', 'Quality Management') THEN 'Prod Q&M'
        WHEN dept_name IN ('Finance', 'Human Resources') THEN 'Finance & HR'
        ELSE 'Customer Service'
	END AS avg_dept_group_sal,
    ROUND(AVG(salary), 0) AS group_avg
FROM salaries AS s
JOIN dept_emp USING (emp_no) # connects to salaries
JOIN departments USING (dept_no) # connects to department names in CASE
WHERE s.to_date > NOW() 
AND dept_emp.to_date > NOW() # adding this changed the AVG, so provide both WHERE(s.to_date)/AND (dept_emp.to_date) 
GROUP BY avg_dept_group_sal     -- to best represent data
ORDER BY group_avg DESC;     



