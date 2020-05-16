-- List all employees in the Sales department:
-- including their employee number, last name, first name, and department name.

DROP VIEW sales_dept;

CREATE VIEW sales_dept AS
SELECT e.emp_no, e.last_name, e.first_name,d.dept_name
FROM ((employees e
INNER JOIN dept_employees de
	   ON e.emp_no = de.emp_no)
INNER JOIN departments d 
	  ON de.dept_no = d.dept_no);

SELECT * FROM sales_dept WHERE dept_name = 'Sales';