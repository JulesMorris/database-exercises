

  #  1) Use the join_example_db. Select all the records from both the users and roles tables.
USE join_example_db;

SELECT *
FROM users;

SELECT *
FROM roles;

  # 2) Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. Before you run each query, guess the expected number of results.

-- Join
SELECT u.name,
	   u.email,
       r.name
FROM users AS u
JOIN roles AS r ON u.role_id = r.id;

-- Left join
SELECT u.name,
	   u.email,
       r.name AS 'role_name'
FROM users AS u
LEFT JOIN roles AS r ON u.role_id = r.id;

-- Right join

SELECT u.name,
	   u.email,
       r.name AS 'role_name'
FROM users AS u
RIGHT JOIN roles as r ON u.role_id = r.id;
       
  # 3) Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. Use count and the appropriate 
  # join type to get a list of roles along with the number of users that has the role. Hint: You will also need to use group by in the query.
USE join_example_db;

SELECT *
FROM users;

SELECT *
FROM roles;

### Need to Left Join to get all of the user roles, need to count(u.name) to get the counts in each role

SELECT r.name,
	   COUNT(u.name) AS number_of_users
FROM roles AS r
LEFT JOIN users AS u ON r.id = u.role_id
GROUP BY r.name;



USE employees;

SELECT *
FROM departments;

SELECT *
FROM dept_emp;

SELECT *
FROM dept_manager;

	-- use departments and dept_manager tables, and to-date 9999-01-01 to find current manager

SELECT CONCAT(e.first_name, ' ', last_name) AS full_name, d.dept_name
FROM employees AS e
JOIN dept_manager AS de
	ON de.emp_no = e.emp_no
JOIN departments AS d
	ON d.dept_no = de.dept_no
WHERE de.to_date = '9999-01-01';

#

SELECT CONCAT(e.first_name, ' ', last_name) AS full_name, d.dept_name
FROM employees AS e
JOIN dept_manager AS de
	ON de.emp_no = e.emp_no
JOIN departments AS d
	ON d.dept_no = de.dept_no
WHERE de.to_date = '9999-01-01'
AND gender = 'F';

# Find the current titles of employees currently working in Customer Service.
SELECT * 
FROM titles;
SELECT *
FROM departments;

SELECT t.title, 
	   COUNT(de.emp_no) AS emp_per_title
FROM dept_emp AS de
JOIN titles AS t ON de.emp_no = t.emp_no
	AND de.to_date = '9999-01-01'
JOIN departments AS d ON d.dept_no = de.dept_no
    WHERE d.dept_name = 'Customer Service'
GROUP BY  t.title;
	

# Find the current salary of all current managers.
SELECT *
FROM salaries;

SELECT *
FROM dept_manager;

SELECT CONCAT(e.first_name, ' ', last_name) AS dept_manager, 
       d.dept_name, 
       s.salary
FROM employees AS e
JOIN salaries AS s
	ON e.emp_no = s.emp_no
    AND s.to_date = '9999-01-01'
JOIN dept_manager AS dm
	ON dm.emp_no = e.emp_no
AND dm.to_date = '9999-01-01'
JOIN departments AS d USING (dept_no)
ORDER BY dept_name;

# Find the number of current employees in each department.
SELECT *
FROM dept_emp;

SELECT *
FROM departments;

SELECT d.dept_no,
	   d.dept_name,
       COUNT(emp_no) AS emp_per_dept
FROM dept_emp AS de
JOIN departments AS d ON de.dept_no = d.dept_no
	AND de.to_date = '9999-01-01'
GROUP BY dept_no, dept_name;

# Which department has the highest average salary? Hint: Use current not historic information.
SELECT *
FROM salaries;

SELECT *
FROM departments;

SELECT * 
FROM dept_emp;

SELECT d.dept_name,
	   FORMAT(AVG(salary), 2) AS avg_salary
FROM dept_emp as de
JOIN salaries AS s ON de.emp_no = s.emp_no
	AND de.to_date = '9999-01-01'
    AND s.to_date = '9999-01-01'
JOIN departments AS d on de.dept_no = d.dept_no
GROUP BY dept_name
ORDER BY avg_salary DESC
LIMIT 1;

 # Who is the highest paid employee in the Marketing department?
 SELECT *
 FROM salaries;
 
 SELECT *
 FROM dept_emp;
 
 SELECT *
 FROM departments;
 
 SELECT CONCAT(e.first_name, ' ', e.last_name) AS highest_paid
 FROM employees AS e
 JOIN dept_emp AS de ON e.emp_no = de.emp_no
	AND de.to_date = '9999-01-01'
JOIN salaries AS s on e.emp_no = s.emp_no
JOIN departments AS d on de.dept_no = d.dept_no
	AND d.dept_name = 'Marketing'
ORDER BY s.salary DESC
LIMIT 1;

# Which current department manager has the highest salary?
SELECT *
FROM employees; #emp_no, birth_date, first_name, last_name, gender, hire_date (get f/l name from employees, use emp_no)

SELECT *
FROM salaries; #emp_no, salary, from_date, to_date ##use emp_no

SELECT *
FROM departments; #dept_no, dept_name ##use dept_no w/ dept_manager

SELECT * 
FROM dept_manager; #emp_no, dept_no, from_date, to_date


SELECT d.dept_name,
       CONCAT(e.first_name, ' ', e.last_name) AS dept_manager,
	   s.salary
FROM employees AS e
JOIN dept_manager AS dm ON e.emp_no = dm.emp_no
	AND to_date = '9999-01-01'
JOIN salaries AS s ON e.emp_no = s.emp_no
	AND s.to_date = '9999-01-01'
JOIN departments AS d USING (dept_no)
ORDER BY s.salary DESC
Limit 1;

# Determine the average salary for each department. Use all salary information and round your results.
SELECT *
FROM salaries;

SELECT *
FROM dept_emp;

SELECT * 
FROM departments;

 SELECT d.dept_name,
		FORMAT(AVG(salary), 2) AS avg_sal_per_dept
FROM dept_emp AS de
JOIN salaries AS s ON de.emp_no = s.emp_no
JOIN departments AS d ON de.dept_no = d.dept_no
GROUP BY dept_name
ORDER BY avg_sal_per_dept DESC;

# Bonus: Find the names of all current employees, their department name, and their current manager's name.
SELECT *
FROM dept_emp; #emp_no, dept_no, from_date, to_date

SELECT *
FROM departments;# dept_no, dept_name

SELECT *
FROM employees; #emp_no, birth_date, first_name, last_name, gender, hire_date

SELECT *
FROM dept_manager; #emp_no, dept_no, from_date, to_date

SELECT dm.dept_no,
	   CONCAT(e.first_name, ' ', e.last_name) AS managers
FROM employees AS e
JOIN dept_manager AS dm on e.emp_no = dm.emp_no
	AND to_date = '9999-01-01';
    # dept_no and current managers

SELECT CONCAT(e.first_name, ' ', e.last_name) AS 'Employee Name',
       d.dept_name AS 'Department',
       m.managers AS 'Manager Name'
FROM employees AS e
JOIN dept_emp AS de ON de.emp_no = e.emp_no
	AND de.to_date = '9999-01-01'
JOIN departments AS d ON de.dept_no = d.dept_no
JOIN ( SELECT dm.dept_no, #query from earlier copy/pasted in this join to combine it all)
	   CONCAT(e.first_name, ' ', e.last_name) AS managers
FROM employees AS e
JOIN dept_manager AS dm on e.emp_no = dm.emp_no
	AND to_date = '9999-01-01') AS m ON m.dept_no = d.dept_no
ORDER BY d.dept_name;

# Bonus: Who is the highest paid employee within each department.
 
 #SELECT d.dept_name,
		#CONCAT(e.first_name, ' ', e.last_name) AS Employee,
		#MAX(salary) AS highest_paid_per_dept
#FROM dept_emp AS de
#JOIN salaries AS s ON de.emp_no = s.emp_no
#JOIN departments AS d on de.dept_no = d.dept_no
#JOIN employees AS e ON e.emp_no = s.emp_no
#GROUP BY dept_name, Employee
#ORDER BY highest_paid_per_dept DESC;    

SELECT d.dept_name,
       MAX(salary) AS max_income
FROM dept_emp AS de
JOIN salaries AS s ON de.emp_no = s.emp_no
JOIN departments as d on de.dept_no = d.dept_no
GROUP BY dept_name
ORDER BY max_income DESC;

SELECT CONCAT(e.first_name, ' ', e.last_name) AS 'Employee Name',
	   d.dept_name AS 'Department'
       m.
FROM employees AS e
JOIN dept_emp AS de ON de.emp_no = e.emp_no
JOIN departments AS d ON de.dept_no = d.dept_no
JOIN( 


# employees per dept query
SELECT *
FROM dept_emp; #emp_no, dept_no, from_date, to_date

SELECT *
FROM departments;#dept_no, dept_name

SELECT dept_name,
       COUNT(de.emp_no) AS emp_per_dept
FROM dept_emp as de
JOIN departments AS d ON d.dept_no = de.dept_no
GROUP BY dept_name;
#####