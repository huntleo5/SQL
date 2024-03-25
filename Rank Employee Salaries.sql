USE employees_mod;

#Query 1
SELECT e.first_name as 'First Name', e.last_name as 'Last Name', e.emp_no as 'Employee #', FORMAT(s.salary,2) as 'Salary' FROM t_employees as e
INNER JOIN t_salaries as s
ON e.emp_no=s.emp_no
WHERE s.to_date = '9999/1/1'
GROUP BY s.salary
ORDER BY s.salary DESC
LIMIT 10
;

#Query 2
SELECT FORMAT(AVG(s.salary),2) from t_salaries as s
WHERE s.to_date = '9999/1/1'
;