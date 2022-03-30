USE employees;
SHOW tables;
-- What different data types are in this table?  
DESCRIBE employees;
-- int, varchar, date, enum

-- Which table(s) do you think contain a numeric type column?
-- emp_no, birth_date, hire_date

-- which table(s) do you think contain a string type column?
-- first_name, last_name, gender

-- Which table(s) do you think contain a date type column?
-- birth_date, hire_date

-- What is the relationship between the employees and departments tables?
DESCRIBE departments;
DESCRIBE employees;
-- Both the employee number and department number are primary keys so they employee number may be tied to department

SHOW CREATE TABLE dept_manager;
-- 'CREATE TABLE `dept_manager` (
--   `emp_no` int NOT NULL,
--   `dept_no` char(4) NOT NULL,
--   `from_date` date NOT NULL,
--   `to_date` date NOT NULL,
--   PRIMARY KEY (`emp_no`,`dept_no`),
--   KEY `dept_no` (`dept_no`),
--   CONSTRAINT `dept_manager_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE ON UPDATE RESTRICT,
--   CONSTRAINT `dept_manager_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`) ON DELETE CASCADE ON UPDATE RESTRICT
-- ) ENGINE=InnoDB DEFAULT CHARSET=latin1'
