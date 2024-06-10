1. 
SELECT name FROM Products


2.
Select name, price from Products


3.
 SELECT name FROM Products
WHERE price <= 200


4.
SELECT name FROM Products
WHERE price <= 120 
AND price >= 60


5. 
SELECT name, (price * 100) FROM Products


6.
SELECT avg(price) from Products


7.
SELECT avg(price) from Products
WHERE manufacturer = 2


8.
SELECT count(price) FROM Products
WHERE price >= 180


9.
SELECT name, price from Products
WHERE price >= 180
Order By price desc , name ASC


10.
SELECT * FROM Products p
JOIN Manufacturers m
ON m.Code = p.Manufacturer


11.
SELECT
  Products.Name as Product_Name,
  Products.Price,
  Manufacturers.Name as Manufacturer_Name
FROM
  Manufacturers
JOIN Products ON
  Manufacturers.Code = Products.Manufacturer

  
12.
SELECT
	Manufacturer, avg(Price)
FROM 
	Products
GROUP BY 
	Manufacturer
	
	
13.
SELECT 
	Manufacturers.Name, 
	avg(Price)
FROM
	Products
JOIN
	Manufacturers
ON
	Manufacturers.code = Products.Manufacturer
GROUP BY 
	Manufacturer
	
	
14.
SELECT 
	Manufacturers.Name, 
	avg(Price)
FROM
	Products
JOIN
	Manufacturers
ON
	Manufacturers.code = Products.Manufacturer
GROUP BY 
	Manufacturer
HAVING
	avg(price) >= 150
Order by avg(price) DESC


15.
SELECT 
	Name, min(Price)
FROM
	Products

	
16.
SELECT 
	Manufacturers.Name, max(price)
FROM
	Manufacturers
JOIN
	Products
ON
	Manufacturers.code = Products.Manufacturer
Group by Manufacturers.Name


17.	
INSERT INTO Products VALUES (11, 'Loudspeakers',  '70', '2')


18.
UPDATE Products
SET Name = 'Laser Print'
WHERE Code = '8'

19.
UPDATE Products
SET price = price*0.9

20. 
UPDATE Products
SET price = price*0.9
WHERE price >= 120

