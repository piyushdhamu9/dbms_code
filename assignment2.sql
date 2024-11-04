-- Assignment 2: Employee and Department Tables in MySQL

-- 1. Create Employee and Department tables
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL
);

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50) NOT NULL,
    salary DECIMAL(10, 2),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- 2. Insert data into the tables
INSERT INTO departments (dept_id, dept_name) VALUES
    (1, 'Administration'),
    (2, 'Customer Service'),
    (3, 'Finance'),
    (4, 'Human Resources'),
    (5, 'Sales');

INSERT INTO employees (emp_id, emp_name, salary, dept_id) VALUES
    (1, 'Ethan Hunt', 5000, 4),
    (2, 'Tony Montana', 6500, 1),
    (3, 'Sarah Connor', 8000, 5),
    (4, 'Rick Deckard', 7200, 3),
    (5, 'Martin Blank', 5600, NULL);

-- 3. Retrieve the ID and name of employees along with their department name (Left Join)
SELECT t1.emp_id, t1.emp_name, t2.dept_name
FROM employees AS t1
LEFT JOIN departments AS t2 ON t1.dept_id = t2.dept_id;

-- 4. Create a View for the above query
CREATE VIEW emp_dept_view AS
SELECT t1.emp_id, t1.emp_name, t1.salary, t2.dept_name
FROM employees AS t1
LEFT JOIN departments AS t2 ON t1.dept_id = t2.dept_id;

-- 5. Retrieve records from the created view
SELECT * FROM emp_dept_view;

-- 6. Update the view to show emp_id, emp_name, dept_name, and salary only
--  we have to write "create or replace" both to make changes in existing view
CREATE OR REPLACE VIEW emp_dept_view AS
SELECT emp_id, emp_name, dept_name, salary
FROM employees AS e
LEFT JOIN departments AS d ON e.dept_id = d.dept_id;

-- 7. Insert 3 more records into the employees table
INSERT INTO employees (emp_id, emp_name, salary, dept_id) VALUES
    (6, 'John Wick', 6000, 2),
    (7, 'James Bond', 7000, 3),
    (8, 'Jason Bourne', 7500, NULL);

-- 8. Update the view to set salary = 6000 for the employee with emp_id = 1
UPDATE employees
SET salary = 6000
WHERE emp_id = 1;

-- 9. Retrieve records where dept_id of employees is NULL
SELECT * FROM emp_dept_view
WHERE dept_name IS NULL;

-- 10. Delete records from the view where salary is 8000
DELETE FROM employees
WHERE salary = 8000;

-- 11. Drop the created view
DROP VIEW emp_dept_view;

-- Additional SQL Queries for Employee and Project Tables

-- 1. Create Employee and Project tables and insert data as shown
CREATE TABLE Employee (
    Eid INT PRIMARY KEY,
    EName VARCHAR(50),
    Address VARCHAR(50),
    Salary DECIMAL(10, 2),
    Commission DECIMAL(10, 2)
);

CREATE TABLE Project (
    PrNo INT PRIMARY KEY,
    Addr VARCHAR(50)
);

INSERT INTO Employee (Eid, EName, Address, Salary, Commission) VALUES
    (1, 'Amit', 'Pune', 35000, 5000),
    (2, 'Sneha', 'Pune', 25000, 0),
    (3, 'Savita', 'Nasik', 28000, 2000),
    (4, 'Pooja', 'Mumbai', 19000, 1000),
    (5, 'Sagar', 'Mumbai', 25000, 3000),
    (6, 'Rohit', 'Jaipur', 40000, 4000),
    (7, 'Poonam', 'Patana', 45000, 2000),
    (8, 'Arjun', 'Delhi', 20000, 900),
    (9, 'Rahul', 'Nagpur', 60000, 5000),
    (10, 'Dulquer', 'Kochi', 30000, 1000);

INSERT INTO Project (PrNo, Addr) VALUES
    (10, 'Mumbai'),
    (20, 'Pune'),
    (30, 'Jalgaon'),
    (40, 'Nagpur'),
    (50, 'Delhi'),
    (60, 'Kochi'),
    (70, 'Pune'),
    (80, 'Nasik');

-- 2. Find different locations where employees belong to
SELECT DISTINCT Address FROM Employee;

-- 3. Find maximum, minimum, average salary, and sum of all salaries
SELECT MAX(Salary) AS MaxSalary, MIN(Salary) AS MinSalary, AVG(Salary) AS AvgSalary, SUM(Salary) AS TotalSalaries
FROM Employee;

-- 4. Display the employee table in ascending order of salary
SELECT * FROM Employee
ORDER BY Salary ASC;

-- 5. Find employees living in Nasik or Pune
SELECT * FROM Employee
WHERE Address IN ('Nasik', 'Pune');

-- 6. Find employees who do not receive a commission
SELECT * FROM Employee
WHERE Commission = 0;

-- 7. Change the city of Amit to Nashik
UPDATE Employee
SET Address = 'Nasik'
WHERE EName = 'Amit';

-- 8. Find employees whose name starts with 'A'
SELECT * FROM Employee
WHERE EName LIKE 'A%';

-- 9. Count the number of staff from Mumbai
SELECT COUNT(*) AS StaffCount FROM Employee
WHERE Address = 'Mumbai';

-- 10. Count the number of staff from each city
SELECT Address, COUNT(*) AS StaffCount FROM Employee
GROUP BY Address;

-- 11. Find addresses from which employees belong and where projects are going on (using UNION)
SELECT Address AS Location FROM Employee
UNION
SELECT Addr AS Location FROM Project;


-- 12. Find city wise minimum salary
select address as city,min(salary) from employee group by address;

--12.
select address as city,max(salary) from employee group by address having max(salary)>26000;


--13.
