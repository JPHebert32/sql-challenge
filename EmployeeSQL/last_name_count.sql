-- In descending order, list the frequency count of employee last names,
-- i.e., how many employees share each last name.
DROP VIEW last_name;

CREATE VIEW last_name AS
SELECT e.last_name,
    COUNT(*) occurrences
FROM employees e
GROUP BY e.last_name
ORDER BY occurrences DESC;

SELECT * FROM last_name;	
	