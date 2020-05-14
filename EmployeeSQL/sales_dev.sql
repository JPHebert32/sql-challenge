-- List all employees in the Sales and Development departments:
-- including their employee number, last name, first name, and department name:

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