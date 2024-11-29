-- JOINS- combine 2 or more tables if they have columns in common
-- JOIN IS AN INNER JOIN BY DEFAULT: same rows- kinda AUB
SELECT dem.employee_id, occupation, age, salary
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
;
-- OUTER JOIN: LEFT- left table whole, matching rows from the right table; RIGHT vice versa
SELECT *
FROM employee_demographics AS dem
LEFT JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
;
SELECT *
FROM employee_demographics AS dem
RIGHT JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
;
-- SELF JOIN
SELECT emp1.employee_id, emp1.first_name, emp1.last_name, emp2. employee_id, emp2.first_name, emp2.last_name
FROM employee_salary emp1
JOIN employee_salary emp2
	ON emp1.employee_id + 2 = emp2.employee_id
;
-- Joining Multiple Tables
SELECT *
FROM employee_demographics AS dem
JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
JOIN parks_departments pd
	ON sal.dept_id = pd.department_id
;

-- UNION- by default it's DISTINCT
SELECT age, gender
FROM employee_demographics
UNION
SELECT last_name, first_name
FROM employee_salary
;
-- by default it's DISTINCT
SELECT last_name, first_name
FROM employee_demographics
UNION
SELECT last_name, first_name
FROM employee_salary
;
-- if you don't want it distinct
SELECT last_name, first_name
FROM employee_demographics
UNION ALL
SELECT last_name, first_name
FROM employee_salary
;
SELECT last_name, first_name, 'Old Man' AS Label 
FROM employee_demographics
WHERE age > 40 AND gender = 'Male'
UNION 
SELECT last_name, first_name, 'Old Woman' AS Label 
FROM employee_demographics
WHERE age > 40 AND gender = 'Female'
UNION 
SELECT last_name, first_name, 'Highly Paid' AS Label
FROM employee_salary
WHERE salary > 70000
ORDER BY first_name, last_name
;
-- String Functions
-- LENGTH
SELECT length('waterfall');

SELECT first_name, length(first_name)
FROM employee_demographics
ORDER BY 2
;
-- CAPS/ NO CAPS
SELECT UPPER('Water');
SELECT LOWER('Water');
SELECT first_name, UPPER(first_name)
FROM employee_demographics
;
-- TRIM remove white spaces right or left
SELECT TRIM('     WATER    ');
SELECT LTRIM('         WATER       ');
SELECT RTRIM('         WATER       ');
-- substring
SELECT first_name,
LEFT(first_name, 4),
RIGHT (first_name, 4),
SUBSTRING(first_name, 2, 4),
birth_date,
SUBSTRING(birth_date, 6, 2) birth_month
FROM employee_demographics
;
-- replace
SELECT first_name, REPLACE(first_name, 'a', 'z')
FROM employee_demographics
;
-- locate
SELECT LOCATE('a', 'Hamsika');
SELECT first_name, LOCATE('AN', first_name)
FROM employee_demographics
;
-- concat
SELECT first_name, last_name,
CONCAT(first_name,' ', last_name) full_name
FROM employee_demographics
;
-- CASE STATEMENTS
SELECT first_name, last_name, age,
CASE
	WHEN age <= 30 THEN 'Young'
    WHEN age BETWEEN 31 and 50 THEN 'Old'
    WHEN age >= 50 THEN "On Death's Door"
END
FROM employee_demographics
;
-- > 50000 5% salary increase, < 50000 7% salary increase, finance- 10% bonus
SELECT first_name, last_name, salary,
CASE
	WHEN salary < 50000 THEN salary + (salary * 0.05)
    WHEN salary > 50000 THEN salary + (salary*0.07)
END AS New_Salary,
CASE
	WHEN dept_id = 6 THEN salary*0.10
END AS Bonus
FROM employee_salary
;
SELECT *
FROM employee_salary;
SELECT *
FROM parks_departments;