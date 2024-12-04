-- CTEs- common table expression, define subquery block which you can ref in the main query

WITH CTE_Example AS 
(
SELECT gender, AVG(salary) avg_salary, MAX(salary) max_salary, MIN(salary) min_salary, COUNT(salary) count_salary
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
)
SELECT AVG(avg_salary)
FROM CTE_Example
;

WITH CTE_Example AS
(
SELECT employee_id, birth_date, first_name, gender
FROM employee_demographics
WHERE birth_date > '1980-01-01'
),
CTE_Example2 AS
(
SELECT employee_id, salary
FROM employee_salary
WHERE salary > 50000
)

SELECT DISTINCT *
FROM CTE_Example
JOIN CTE_Example2
	ON CTE_Example.employee_id = CTE_Example2.employee_id
;

-- Temporary Tables- visible only in the session we created in

CREATE TEMPORARY TABLE Temp_table
(first_name varchar(50),
last_name varchar(50),
favorite_movie varchar(100)
);
SELECT *
FROM Temp_table;

INSERT INTO Temp_table
VALUES('Hamsika', 'Kondamudi', 'Zindagi na Milegi Dubara');
SELECT *
FROM Temp_table;
--
CREATE TEMPORARY TABLE Salary_over_50k
SELECT *
FROM employee_salary
WHERE salary >= 50000
;
SELECT *
FROM Salary_over_50k;

-- Stored Procedure save and resuse the procedure

CREATE PROCEDURE large_salaries()
SELECT *
FROM employee_salary
WHERE salary >= 50000;

CALL large_salaries();

DELIMITER //
CREATE PROCEDURE large_salaries3()
BEGIN
	SELECT *
	FROM employee_salary
	WHERE salary >= 50000;
	SELECT *
	FROM employee_salary
	WHERE salary >= 10000;
END //
DELIMITER ;

CALL large_salaries3();

-- parameters are variables that passed as an input in a stored procedure

DELIMITER //
CREATE PROCEDURE large_salaries4(employee_id_param Int)
BEGIN
	SELECT *
	FROM employee_salary
	WHERE employee_id = employee_id_param
    ;
END //
DELIMITER ;

CALL large_salaries4(1);

-- Triggeres and Events- trigger is a block of code that executes automatically when an event takes place on a specific table
DROP TRIGGER IF EXISTS employee_update;
DROP TRIGGER IF EXISTS employee_update1;
DROP TRIGGER IF EXISTS employee_insert2;
DROP TRIGGER IF EXISTS employee_insert3;
DROP TRIGGER IF EXISTS employee_insert;

DELIMITER $$

DROP TRIGGER IF EXISTS employee_insert1 $$

CREATE TRIGGER employee_insert1
AFTER INSERT ON employee_salary
FOR EACH ROW
BEGIN
    INSERT INTO employee_demographics (employee_id, first_name, last_name)
    VALUES (NEW.employee_id, NEW.first_name, NEW.last_name);
END $$

DELIMITER ;

INSERT INTO employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
VALUES (15, 'Harry', 'Potter', 'Muggle Entertainment CEO', 100000, NULL);

SELECT*
FROM employee_demographics;
SELECT*
FROM employee_salary;

DELETE FROM employee_demographics
WHERE employee_id = 13 AND employee_id = 14;

-- EVENTS- scheduled automater

DELIMITER &&
DROP EVENT IF EXISTS delete_retirees;
CREATE EVENT delete_retirees
ON SCHEDULE EVERY 1 MONTH
DO
BEGIN
	DELETE
    FROM employee_demographics
    WHERE age >= 60;
END &&
DELIMITER ;