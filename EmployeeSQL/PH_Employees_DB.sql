-- DROP EXISTING TABLES
DROP TABLE departments;
DROP TABLE dept_employees;
DROP TABLE dept_managers;
DROP TABLE employees;
DROP TABLE salaries;
DROP TABLE titles;

-- CREATE TABLES

CREATE TABLE employees (
    emp_no INT   NOT NULL,
    emp_title_id VARCHAR(5)   NOT NULL,
    birth_date DATE   NOT NULL,
    first_name VARCHAR(30)   NOT NULL,
    last_name VARCHAR(30)   NOT NULL,
    sex VARCHAR(1)   NOT NULL,
    hire_date DATE   NOT NULL,
    CONSTRAINT pk_employees PRIMARY KEY (
        emp_no
     )
);

CREATE TABLE titles (
    title_id VARCHAR(5)   NOT NULL,
    title VARCHAR(30)   NOT NULL,
    CONSTRAINT pk_titles PRIMARY KEY (
        title_id
     )
);

CREATE TABLE salaries (
    emp_no INT   NOT NULL,
    salary INT   NOT NULL
);

CREATE TABLE departments (
    dept_no VARCHAR(5)   NOT NULL,
    dept_name VARCHAR(30)   NOT NULL,
    CONSTRAINT pk_departments PRIMARY KEY (
        dept_no
     )
);

CREATE TABLE dept_managers (
    dept_no VARCHAR(5)   NOT NULL,
    emp_no INT   NOT NULL
);

CREATE TABLE dept_employees (
    emp_no INT   NOT NULL,
    dept_no VARCHAR(5)   NOT NULL
);

ALTER TABLE employees ADD CONSTRAINT fk_employees_emp_title_id FOREIGN KEY(emp_title_id)
REFERENCES titles (title_id);

ALTER TABLE salaries ADD CONSTRAINT fk_salaries_emp_no FOREIGN KEY(emp_no)
REFERENCES employees (emp_no);

ALTER TABLE dept_managers ADD CONSTRAINT fk_dept_managers_dept_no FOREIGN KEY(dept_no)
REFERENCES departments (dept_no);

ALTER TABLE dept_managers ADD CONSTRAINT fk_dept_managers_emp_no FOREIGN KEY(emp_no)
REFERENCES employees (emp_no);

ALTER TABLE dept_employees ADD CONSTRAINT fk_dept_employees_emp_no FOREIGN KEY(emp_no)
REFERENCES employees (emp_no);

ALTER TABLE dept_employees ADD CONSTRAINT fk_dept_employees_dept_no FOREIGN KEY(dept_no)
REFERENCES departments (dept_no);

-- IMPORTED DATA FROM CSV'S IN THE FOLLOWING ORDER THEN CHECK TABLES
SELECT * FROM departments;
SELECT * FROM titles;
SELECT * FROM employees;
SELECT * FROM dept_employees;
SELECT * FROM dept_managers;
SELECT * FROM salaries;


----------------------------------------------------------------------------------------------
-- 1. List the following details of each employee:
----- employee number, last name, first name, sex, and salary.
----------------------------------------------------------------------------------------------
DROP VIEW employee_info;

CREATE VIEW employee_info AS
SELECT e.emp_no, e.last_name, e.first_name, e.sex, Max(s.salary)AS "Salary"
FROM employees e 
JOIN salaries s 
ON e.emp_no = s.emp_no
GROUP BY e.emp_no 
ORDER BY e.emp_no ASC;

SELECT * FROM employee_info;

----------------------------------------------------------------------------------------------
-- 2. List first name, last name, and hire date for employees who were hired in 1986.
----------------------------------------------------------------------------------------------
DROP VIEW hired_86;

CREATE VIEW hired_86 AS
SELECT e.first_name, e.last_name, e.hire_date
FROM employees e
WHERE e.hire_date  BETWEEN '01/01/1986' AND '12/31/1986' 
ORDER BY e.emp_no ASC;

SELECT * FROM hired_86;

------------------------------------------------------------------------------------------------
-- 3. List the manager of each department with the following information:
----- department number, department name, the manager's employee number, last name, first name.
------------------------------------------------------------------------------------------------
DROP VIEW managers;

CREATE VIEW managers AS
SELECT d.dept_no,d.dept_name,e.emp_no, e.last_name, e.first_name
FROM ((employees e
INNER JOIN dept_managers m
	   ON e.emp_no = m.emp_no)
INNER JOIN departments d 
	  ON m.dept_no = d.dept_no);

SELECT * FROM managers;

------------------------------------------------------------------------------------------------
-- 4. List the department of each employee with the following information:
----- employee number, last name, first name, and department name.
------------------------------------------------------------------------------------------------
DROP VIEW emp_department;

CREATE VIEW emp_department AS
SELECT e.emp_no, e.last_name, e.first_name,d.dept_name
FROM ((employees e
INNER JOIN dept_employees de
	   ON e.emp_no = de.emp_no)
INNER JOIN departments d 
	  ON de.dept_no = d.dept_no);

SELECT * FROM emp_department;

------------------------------------------------------------------------------------------------
-- 5. List first name, last name, and sex for employees whose:
----- first name is "Hercules" and last names begin with "B."
------------------------------------------------------------------------------------------------
DROP VIEW hercules;

Create VIEW hercules AS
SELECT e.first_name, e.last_name, e.sex
FROM employees e
WHERE e.last_name LIKE 'B%' AND e.first_name = 'Hercules';

SELECT * FROM hercules;

------------------------------------------------------------------------------------------------
-- 6. List all employees in the Sales department:
----- Including their employee number, last name, first name, and department name.
------------------------------------------------------------------------------------------------
DROP VIEW sales_dept;

CREATE VIEW sales_dept AS
SELECT e.emp_no, e.last_name, e.first_name,d.dept_name
FROM ((employees e
INNER JOIN dept_employees de
	   ON e.emp_no = de.emp_no)
INNER JOIN departments d 
	  ON de.dept_no = d.dept_no);

SELECT * FROM sales_dept WHERE dept_name = 'Sales';

------------------------------------------------------------------------------------------------
-- 7. List all employees in the Sales and Development departments:
----- Including their employee number, last name, first name, and department name.
------------------------------------------------------------------------------------------------
DROP VIEW sales_dev;

CREATE VIEW sales_dev AS
SELECT e.emp_no, e.last_name, e.first_name,d.dept_name
FROM ((employees e
INNER JOIN dept_employees de
	   ON e.emp_no = de.emp_no)
INNER JOIN departments d 
	  ON de.dept_no = d.dept_no)
ORDER BY d.dept_name;

SELECT * FROM sales_dev WHERE dept_name = 'Sales' OR dept_name = 'Development';

------------------------------------------------------------------------------------------------
-- 8. In descending order, list the frequency count of employee last names
----- i.e., how many employees share each last name.
------------------------------------------------------------------------------------------------
DROP VIEW last_name;

CREATE VIEW last_name AS
SELECT e.last_name,
    COUNT(*) occurrences
FROM employees e
GROUP BY e.last_name
ORDER BY occurrences DESC;

SELECT * FROM last_name;


