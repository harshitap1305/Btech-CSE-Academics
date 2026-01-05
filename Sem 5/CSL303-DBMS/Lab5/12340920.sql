-- Part 1
--1
SELECT emp_name FROM Employees
WHERE dept_id IN (
SELECT dept_id FROM Departments 
WHERE dept_name="Marketing"
); 

--2 
SELECT emp_name,salary FROM Employees
WHERE salary > ( SELECT AVG(salary) FROM Employees );

--3 
SELECT emp_name FROM Employees 
WHERE emp_id IN (
SELECT e.emp_id FROM Assignments AS e 
WHERE e.proj_id IN ( 
SELECT proj_id FROM Projects WHERE proj_name="Project Phoenix" 
) 
);

--4
SELECT e.emp_name FROM Employees AS e
EXCEPT
SELECT emp_name FROM Employees 
WHERE emp_id IN (
SELECT emp_id FROM Assignments ) ;

--5
SELECT emp_name
FROM Employees
WHERE salary > (
SELECT MIN(s.salary)
FROM Employees AS s
WHERE s.dept_id IN (
SELECT d.dept_id
FROM Departments AS d
WHERE d.dept_name = "Marketing"
)
);

--6
SELECT emp_name
FROM Employees
WHERE salary > (
SELECT MAX(s.salary)
FROM Employees AS s
WHERE s.dept_id IN (
SELECT d.dept_id
FROM Departments AS d
WHERE d.dept_name = "Marketing"
)
);


--PART 2
--1
SELECT emp_name,hire_date FROM Employees 
WHERE STRFTIME('%Y', hire_date) ='2023';

--2
SELECT emp_name FROM Employees WHERE manager_id IS NULL;

--3
SELECT emp_name FROM Employees WHERE emp_name LIKE '%Smith'
UNION
SELECT emp_name FROM Employees WHERE emp_name LIKE '%Williams';

--4
SELECT emp_name FROM Employees 
WHERE hire_date >= DATE('now','-2 years');

--PART 3

--1
SELECT d.dept_name, e.emp_name, e.salary
FROM Employees AS e
JOIN Departments AS d ON d.dept_id = e.dept_id
WHERE e.salary = (
SELECT MAX(e2.salary)
FROM Employees AS e2
WHERE e2.dept_id = e.dept_id
);

--2 
SELECT emp_name FROM Employees
WHERE dept_id IN (
SELECT dept_id FROM Departments 
WHERE dept_name = "Engineering"
)
EXCEPT
SELECT emp_name FROM Employees 
WHERE emp_id IN (
SELECT e.emp_id FROM Assignments AS e 
WHERE e.proj_id IN ( 
SELECT proj_id FROM Projects WHERE proj_name = "Project Neptune"
  ) 
);

--3
SELECT d.dept_name FROM Departments AS d
JOIN Employees AS e ON e.dept_id = d.dept_id
GROUP BY d.dept_id, d.dept_name
HAVING AVG(e.salary) > ( 
SELECT AVG(salary) FROM Employees
);



--PART 4

--1
ALTER TABLE Employees ADD COLUMN email TEXT;

--2
UPDATE Employees
SET email = LOWER(REPLACE(emp_name, ' ', '')) || '@engineering.com'
WHERE dept_id = ( SELECT dept_id FROM Departments WHERE dept_name = 'Engineering'
);

--3 
CREATE TABLE HighEarners (
emp_id INTEGER PRIMARY KEY,
emp_name TEXT NOT NULL
);

INSERT INTO HighEarners (emp_id, emp_name)
SELECT emp_id, emp_name
FROM Employees
WHERE salary > 95000;

