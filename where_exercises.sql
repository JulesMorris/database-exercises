USE employees;
# 2) Find all current or previous employees with first names: 'Irena', 'Vidya', or 'Maya' using IN. 

SELECT COUNT(*)
FROM employees
WHERE first_name IN ('Irene', 'Vidya', 'Maya');
	-- 731
    
# 3) Use OR instead of IN, to find the number of employees with first_name: Irene, Vidya, Maya

    
SELECT COUNT(*)
FROM employees
WHERE first_name = 'Irene'
	OR first_name = 'Vidya'
    OR first_name = 'Maya';

-- 731, count remains the same
    
# 4) Find the employees with same names as above using OR that are also male

# 'AND' is evaluated BEFORE 'OR', use parentheses!!!

SELECT *
FROM employees
WHERE gender = 'M'
AND 
	(first_name = 'Irena'
    OR first_name = 'Vidya'
    OR first_name = 'Maya');
-- 441

# 5) Number of employees whose last name starts with 'E'
	-- 7330
    
SELECT COUNT(last_name)
FROM employees
WHERE last_name LIKE 'E%';

SELECT *
FROM employees
WHERE last_name LIKE 'E%';

# 6) Find number of employees w/ last name that starts or ends with 'E'
	-- 30,723 with first or last letter of last name is 'E'
		-- Last name ends with 'E' = 23,393
SELECT COUNT(last_name)
FROM employees
WHERE last_name LIKE 'E%'
	OR last_name LIKE '%E';
    
-- How many employees have name that ends with 'E' but does not start with 'E' 
SELECT COUNT(last_name)
FROM employees
WHERE last_name LIKE '%E'
	AND NOT last_name LIKE 'E%';
		-- 23,393
        
        
# 7) How many employees have last names that starts and ends with 'E'?

SELECT COUNT(last_name)
FROM employees
WHERE last_name LIKE 'E%E';

-- 899

# 8) Find all employees hired in the 90s

SELECT COUNT(hire_date)
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31';

-- 135,214

# 9) Find number of employees born on Christmas

SELECT COUNT(birth_date)
FROM employees
WHERE birth_date LIKE '%-12-25';

-- 842


 # 10) Hired in the 90s and born on Christmas
 
 SELECT COUNT(hire_date)
 FROM employees
 WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
 AND birth_date LIKE '%-12-25';
-- 362 

# 11) Get count of employees w/ 'Q' in last name

SELECT COUNT(last_name)
FROM employees
WHERE last_name LIKE 'Q%'
	OR last_name LIKE '%Q%'
    OR last_name LIKE '%Q';
    
    # More succinct:
SELECT COUNT(last_name)
FROM employees
WHERE last_name LIKE '%Q%';

-- 1873

# 12) Find count of employees w/ 'q' but not 'qu' in their last names

SELECT COUNT(last_name)
FROM employees
WHERE last_name LIKE '%Q%'
AND NOT last_name LIKE '%QU%';

-- 547
	
	