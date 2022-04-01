

# 1) Create a new file named group_by_exercises.sql
USE employees;
# 2) In your script, use DISTINCT to find the unique titles in the titles table. How many 
   # unique titles have there ever been? Answer that in a comment in your SQL file.
   
DESCRIBE titles;

SELECT DISTINCT COUNT(title)
FROM titles;

-- 443,308

# 3) Write a query to to find a list of all unique last names of all employees that start and end with 'E' using GROUP BY.
SELECT DISTINCT(last_name)
FROM employees
WHERE last_name LIKE 'E%e'
GROUP BY last_name;

# 4) Write a query to to find all unique combinations of first and last names of all employees whose last names start and end with 'E'.

SELECT (last_name), first_name
FROM employees
WHERE last_name LIKE 'E%e'
GROUP BY first_name, last_name;
-- 846 rows

# 5) Write a query to find the unique last names with a 'q' but not 'qu'. Include those names in a comment in your sql code.
SELECT DISTINCT (last_name)
FROM employees
WHERE last_name LIKE '%q%'
AND NOT last_name LIKE '%qu%';
-- Cleq, Lindqvist, Qiwen

#6) Add a COUNT() to your results (the query above) to find the number of employees with the same last name.

SELECT DISTINCT(COUNT(last_name)), last_name AS surname
FROM employees
WHERE last_name LIKE '%q%'
AND NOT last_name LIKE '%qu%'
GROUP BY last_name;

-- Total: 547 (Chleq - 189, Lindqvist - 190, Qiwen - 168)

# 7)Find all all employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names.


SELECT gender, COUNT(first_name), first_name AS given_name
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
GROUP BY gender, first_name;

-- Total: 709
-- (Irena M-144/F-97, Vidya M-151/F-81, Maya M-146/F-90) 

# 8) Using your query that generates a username for all of the employees, generate a count employees for each unique username. 

SELECT LOWER(CONCAT(SUBSTR(first_name, 1, 1), 
					SUBSTR(last_name, 1, 4), '_', 
					SUBSTR(birth_date, 6, 2), 
                    SUBSTR(birth_date, 3, 2))) AS username, 
                    COUNT(*) AS user_count
FROM employees
GROUP BY username;
# Are there any duplicate usernames?
SELECT LOWER(CONCAT(SUBSTR(first_name, 1, 1), 
					SUBSTR(last_name, 1, 4), '_', 
					SUBSTR(birth_date, 6, 2), 
                    SUBSTR(birth_date, 3, 2))) AS username, 
                    COUNT(*) AS user_count
FROM employees
GROUP BY username
HAVING user_count > 1;
-- Yes

# BONUS: How many duplicate usernames are there?
SELECT SUM(t.user_count) AS 'total_duplicates',
COUNT(t.user_count) AS 'number_of_unique_duplicates'
FROM (SELECT LOWER(CONCAT(SUBSTR(first_name, 1, 1), 
					SUBSTR(last_name, 1, 4), '_', 
					SUBSTR(birth_date, 6, 2), 
                    SUBSTR(birth_date, 3, 2))) AS username, 
                    COUNT(*) AS user_count
FROM employees
GROUP BY username
HAVING user_count > 1) AS t;
-- total_deuplicates = 27,403
-- number_of_unique_duplicates = 13,251


  # More practice with aggregate functions:
        #Determine the historic average salary for each employee. When you hear, read, or think "for each" with regard to SQL, you'll probably be grouping by that exact column.
DESCRIBE salaries;

	SELECT FORMAT(AVG(salary), 2),emp_no
    FROM salaries
    GROUP BY emp_no;
    
    
        #Using the dept_emp table, count how many current employees work in each department. 
			-- The query result should show 9 rows, one for each department and the employee count.
       /* DESCRIBE dept_emp;
        
        SELECT COUNT(emp_no), dept_no, dept_name FROM dept_emp
        JOIN departments USING (dept_no)
        GROUP BY dept_name; /*
        
        -- Customer Service: 23580
        -- Development : 85707
        
        
        
        # Determine how many different salaries each employee has had. This includes both historic and current.
       
       Find the maximum salary for each employee.
       
       Find the minimum salary for each employee.
        
        Find the standard deviation of salaries for each employee.
       
       Now find the max salary for each employee where that max salary is greater than $150,000.
       
       Find the average salary for each employee where that average salary is between $80k and $90k. /*
