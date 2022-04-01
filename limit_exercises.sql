USE employees;
SELECT database();
SHOW tables;

DESCRIBE titles;

SELECT *
FROM titles
LIMIT 10;

# 2) List first 10 distinct last names sorted in desc. order

SELECT DISTINCT last_name
FROM employees
ORDER BY last_name DESC
LIMIT 10;

-- Zykh
-- Zyda
-- Zweizig
-- Zumaque
-- Zultner
-- Zucker
-- Zuberek
-- Zschoche
-- Zongker

# 3) List first 5 hires of the 90's born on Christamas

SELECT *
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
AND birth_date LIKE '%-12-25'
ORDER BY hire_date
LIMIT 5;
	-- Alselm Cappello
    -- Utz Mandell
    -- Bouchang Schreiter
    -- Baocai Kushner
    -- Petter Stroustrup
    
# More succinct:
SELECT *
FROM employees
WHERE hire_date LIKE '199%'
AND birth_date LIKE '%-12-25'
ORDER BY hire_date
LIMIT 5;

# 4) Same req's as above, but get the 50th "page" of results 
    
SELECT *
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
AND birth_date LIKE '%-12-25'
ORDER BY hire_date
LIMIT 5 OFFSET 45;

#More Succinct:
SELECT *
FROM employees
WHERE hire_date LIKE '199%'
AND birth_date LIKE '%-12-25'
ORDER BY hire_date
LIMIT 5 OFFSET 45;

	-- Pranay Narwekar
    -- Marjo Farrow
    -- Ennio Karcich
    -- Dines Lubachevsky
    -- Ipke Fontan
    
	-- The releationship between LIMIT and OFFSET is that using OFFSET helps to view the data in pages