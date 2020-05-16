--List the following details of each employee: employee number, last name, first name, sex, and salary.

DROP VIEW employee_info;

CREATE VIEW employee_info AS
SELECT e.emp_no, e.last_name, e.first_name, e.sex, Max(s.salary)AS "Salary"
FROM employees e 
JOIN salaries s 
ON e.emp_no = s.emp_no
GROUP BY e.emp_no 
ORDER BY e.emp_no ASC;

SELECT * FROM employee_info;