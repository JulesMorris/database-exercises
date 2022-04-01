USE employees;

# 2) What is first and last name of first result and first and last name of last result?
SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name;
	-- Irena Reuten 
    -- Vidya Simmen

# 3) First and last name of first result and first and last name of last result of query

SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name, last_name;

	-- First: Irena Acton
    
    SELECT *
    FROM employees
    WHERE first_name IN ('Irena', 'Vidya', 'Maya')
    ORDER BY first_name DESC, last_name DESC;
    
    -- Vidya Zweizig
 
 # 4) First and last name of first and last query result
SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY last_name, first_name;
	-- Irena Acton
    
SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY last_name DESC, first_name DESC;
    
    -- Maya Zyda

# 5) Find number of employees w/ last name that starts and ends with 'E' ordered by employee number

SELECT * 
FROM employees
WHERE last_name LIKE 'E%E'
ORDER BY emp_no;
	-- 899
    
# 6) Find newest and oldest employees whose last name starts and ends with 'E'

SELECT * 
FROM employees
WHERE last_name LIKE 'E%E'
ORDER BY hire_date DESC;
	-- Newest employee: Teiji Eldridge
    
 SELECT * 
FROM employees
WHERE last_name LIKE 'E%E'
ORDER BY hire_date;   
    -- Oldest employee: Sergi Erde

# 7) Find all employees hired in 90s and born on Christmas. Sort by oldest(birthdate) new hire

SELECT *
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
AND birth_date LIKE '%-12-25'
ORDER BY birth_date ASC, hire_date DESC;

	-- Number of employees hired in 90s born on Xmas: 362
    -- Oldest employee hired last: Khun Bernini
    
    
SELECT *
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
AND birth_date LIKE '%-12-25'
ORDER BY birth_date DESC, hire_date ASC;

	-- youngest employee hired first: Douadi Pettis
    
