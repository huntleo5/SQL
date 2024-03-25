USE employees;

#PART 1
#Creating Command to find Average Salary by Current Position and Current Salary
SELECT t.title as 'Title', FORMAT(AVG(s.salary),2) as 'Average_Salary' from titles as t
INNER JOIN salaries as s
ON t.emp_no=s.emp_no
WHERE s.to_date = "9999-01-01"
GROUP BY t.title
ORDER BY t.title ASC
;

SELECT * FROM salaries
WHERE to_date = "9999-01-01"
;

USE sakila;

#PART 2

#Question 1
#The neccesary tables are customer, rental, inventory, film, and language

#Question 2
#The neccesary tables are staff and store

#Query 1
SELECT c.first_name as 'First Name', c.last_name as 'Last Name', s.store_id as 'Store #', SUM(p.amount) as 'Revenue' FROM customer as c
INNER JOIN store as s
ON c.store_id=s.store_id
INNER JOIN payment as p
ON c.customer_id=p.customer_id
GROUP BY c.first_name, c.last_name, s.store_id
ORDER BY SUM(p.amount) DESC
;

#Query 2
USE sakila;

CREATE VIEW spend_by_customer AS 
SELECT c.first_name as 'First Name', c.last_name as 'Last Name', s.store_id as 'Store #', SUM(p.amount) as 'Revenue' FROM customer as c
INNER JOIN store as s
ON c.store_id=s.store_id
INNER JOIN payment as p
ON c.customer_id=p.customer_id
GROUP BY c.first_name, c.last_name, s.store_id
ORDER BY SUM(p.amount) DESC
;

#Query 3
SELECT c.store_id as 'Store #', inventory_sq.inv / COUNT(c.store_id) as 'Inventory per Customer'
FROM customer as c
RIGHT JOIN
	(SELECT
		i.store_id, COUNT(i.store_id) AS inv
	FROM
		inventory as i
	GROUP BY i.store_id) AS inventory_sq
ON c.store_id=inventory_sq.store_id
GROUP BY c.store_id
;

#Query 4
CREATE VIEW inventory_per_customer AS
SELECT c.store_id as 'Store #', inventory_sq.inv / COUNT(c.store_id) as 'Inventory per Customer'
FROM customer as c
RIGHT JOIN
	(SELECT
		i.store_id, COUNT(i.store_id) AS inv
	FROM
		inventory as i
	GROUP BY i.store_id) AS inventory_sq
ON c.store_id=inventory_sq.store_id
GROUP BY c.store_id
;

#Query 5
SELECT c.first_name as 'First Name', c.last_name as 'Last Name', c.store_id as 'Store #', get_customer_balance(c.customer_id, current_date) as 'Outstanding Balance'
FROM customer as c
WHERE get_customer_balance(c.customer_id, current_date) < 0
;
