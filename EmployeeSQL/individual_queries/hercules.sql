-- List first name, last name, and sex for employees whose first name is "Hercules"
-- and last names begin with "B."
DROP VIEW hercules;

Create VIEW hercules AS

SELECT e.first_name, e.last_name, e.sex
FROM employees e
WHERE e.last_name LIKE 'B%' AND e.first_name = 'Hercules';

SELECT * FROM hercules;