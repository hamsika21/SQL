SELECT *
FROM parks_and_recreation.employee_demographics;

SELECT first_name, 
last_name, 
birth_date,
age,
age + 10 AS new_age
FROM parks_and_recreation.employee_demographics;

SELECT DISTINCT gender
FROM parks_and_recreation.employee_demographics;

SELECT *
FROM parks_and_recreation.employee_salary
WHERE
first_name = 'Leslie'
;
-- LIKE -- % _, %- any value and _ exact value
SELECT *
FROM parks_and_recreation.employee_demographics
WHERE birth_date LIKE '198%' 
;
-- GROUP BY
SELECT gender, 
AVG(age), MAX(age), MIN(age), count(age)
FROM employee_demographics
GROUP BY gender
;
-- ORDER BY
SELECT *
FROM parks_and_recreation.employee_demographics
ORDER BY gender, age DESC
;
SELECT *
FROM parks_and_recreation.employee_demographics
ORDER BY 5, 4
;

-- HAVING, can't use where because it tries filtering data before group by could create data table, so we having which comes later
SELECT occupation, avg(salary)
FROM employee_salary
WHERE occupation like '%manager%'
GROUP BY occupation
HAVING avg(salary) > 80000
;

-- Limit and aliasing

SELECT *
FROM parks_and_recreation.employee_demographics
ORDER BY age DESC
LIMIT 3
;
SELECT *
FROM parks_and_recreation.employee_demographics
ORDER BY age DESC
LIMIT 1, 2
;

SELECT occupation, avg(salary) AS avg_salary
FROM employee_salary
GROUP BY occupation
HAVING avg_salary > 50000
;
-- it'll work without AS as well
SELECT occupation, avg(salary) avg_salary
FROM employee_salary
GROUP BY occupation
HAVING avg_salary > 50000
;