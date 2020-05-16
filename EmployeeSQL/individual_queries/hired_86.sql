-- List first name, last name, and hire date for employees who were hired in 1986.

DROP VIEW hired_86;

CREATE VIEW hired_86 AS
SELECT e.first_name, e.last_name, e.hire_date
FROM employees e
WHERE e.hire_date  BETWEEN '01/01/1986' AND '12/31/1986' 
ORDER BY e.emp_no ASC;

SELECT * FROM hired_86;