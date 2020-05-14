-- List the department of each employee with the following information:
-- employee number, last name, first name, and department name.

DROP VIEW emp_department;

CREATE VIEW emp_department AS
SELECT e.emp_no, e.last_name, e.first_name,d.dept_name
FROM ((employees e
INNER JOIN dept_employees de
	   ON e.emp_no = de.emp_no)
INNER JOIN departments d 
	  ON de.dept_no = d.dept_no);

SELECT * FROM emp_department;