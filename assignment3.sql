-- Inner Join Queries
-- 1. Display first name, last name, package number, and internet speed for all customers.
SELECT c.firstname, c.lastname, p.pack_id, p.speed
FROM Customers c
INNER JOIN Packages p ON c.pack_id = p.pack_id;

-- 2. Display first name, last name, package number, and internet speed for customers whose package number equals 22 or 27.
SELECT c.firstname, c.lastname, p.pack_id, p.speed
FROM Customers c
INNER JOIN Packages p ON c.pack_id = p.pack_id
WHERE p.pack_id IN (22, 27)
ORDER BY c.lastname ASC;

-- 3. Display the package number, internet speed, monthly payment, and sector name for all packages.
SELECT p.pack_id, p.speed, p.monthly_payment, s.sector_name
FROM Packages p
INNER JOIN Sectors s ON p.sector_id = s.sector_id;

-- 4. Display the customer name, package number, internet speed, monthly payment, and sector name for all customers.
SELECT CONCAT(c.firstname, ' ', c.lastname) AS customer_name, p.pack_id, p.speed, p.monthly_payment, s.sector_name
FROM Customers c
INNER JOIN Packages p ON c.pack_id = p.pack_id
INNER JOIN Sectors s ON p.sector_id = s.sector_id;

-- 5. Display the customer name, package number, internet speed, monthly payment, and sector name for customers in the business sector.
SELECT CONCAT(c.firstname, ' ', c.lastname) AS customer_name, p.pack_id, p.speed, p.monthly_payment, s.sector_name
FROM Customers c
INNER JOIN Packages p ON c.pack_id = p.pack_id
INNER JOIN Sectors s ON p.sector_id = s.sector_id
WHERE s.sector_name = 'Business';

-- 6. Display the last name, first name, join date, package number, internet speed, and sector name for all customers in the private sector who joined in 2006.
SELECT c.lastname, c.firstname, c.joindate, p.pack_id, p.speed, s.sector_name
FROM Customers c
INNER JOIN Packages p ON c.pack_id = p.pack_id
INNER JOIN Sectors s ON p.sector_id = s.sector_id
WHERE s.sector_name = 'Private' AND YEAR(c.joindate) = 2006;

-- Non-Equi Join Queries
-- 7. Display the package number, internet speed, monthly payment, and package grade for packages whose monthly payment is between min_price and max_price.
SELECT p.pack_id, p.speed, p.monthly_payment, pg.grade_name
FROM Packages p
INNER JOIN Pack_grades pg ON p.monthly_payment BETWEEN pg.min_price AND pg.max_price;

-- Outer Join Queries
-- 8. Display the first name, last name, internet speed, and monthly payment for all customers, using an outer join.
SELECT c.firstname, c.lastname, p.speed, p.monthly_payment
FROM Customers c
LEFT JOIN Packages p ON c.pack_id = p.pack_id;

-- 9. Display all customers, including those without any internet package.
SELECT c.*
FROM Customers c
LEFT JOIN Packages p ON c.pack_id = p.pack_id
WHERE p.pack_id IS NULL;

-- 10. Display all packages, including those without any customers.
SELECT p.*
FROM Packages p
LEFT JOIN Customers c ON p.pack_id = c.pack_id
WHERE c.cust_id IS NULL;
