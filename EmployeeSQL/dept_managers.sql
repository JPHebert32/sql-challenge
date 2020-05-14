-- List the manager of each department with the following information:
-- department number, department name, the manager's employee number, last name, first name.
DROP VIEW managers;

CREATE VIEW managers AS
SELECT d.dept_no,d.dept_name,e.emp_no, e.last_name, e.first_name
FROM ((employees e
INNER JOIN dept_managers m
	   ON e.emp_no = m.emp_no)
INNER JOIN departments d 
	  ON m.dept_no = d.dept_no);

SELECT * FROM managers;