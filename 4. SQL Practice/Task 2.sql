1. 
SELECT LastName FROM Employees


2.
SELECT DISTINCT LastName FROM Employees


3. 
SELECT * FROM Employees
WHERE LastName = "Smith"


4.
SELECT * FROM Employees
WHERE LastName = "Smith"
OR LastName = "Doe"


5.
SELECT * FROM Employees
WHERE Department = '14'


6.
SELECT * FROM Employees
WHERE Department = '37'
OR Department = '77'


7.
SELECT * FROM Employees
WHERE LastName LIKE "S%"


8.
SELECT SUM(budget) FROM Departments


9.
SELECT Department, Count(*)
FROM Employees
GROUP BY Department


10.
SELECT SSN, Employees.Name, LastName, Department as Department_Code, Departments.Name as Department_Name 
FROM Employees
JOIN Departments
ON Departments.Code = Employees.Department


11.
SELECT Employees.Name as Name, Employees.LastName, Departments.Name as Department, Budget
FROM Employees
JOIN Departments
ON Departments.Code = Employees.Department


12. 
SELECT Employees.Name, LastName
FROM Employees
JOIN Departments
ON Departments.Code = Employees.Department
WHERE Budget >=60000


13.
SELECT Departments.Name 
From Departments
JOIN Employees
ON Departments.Code = Employees.Department
WHERE Budget > (SELECT avg(Budget) from Departments)


14.
SELECT Departments.Name, count(*)
From Departments
JOIN Employees
ON Departments.Code = Employees.Department
GROUP BY Departments.Name
Having count(*) >  1


15. 
SELECT 
	Employees.Name, 
	LastName
FROM Employees
JOIN Departments
ON Departments.Code = Employees.Department
ORDER BY Budget ASC
LIMIT 2


16.
Insert into Departments
VALUES ('11', 'Quality Assuarance', '40000')
Insert into Employees
VALUES ('847219811', 'Moore', 'Mary', '11')


17.
UPDATE Departments
SET Budget = Budget*0.9


18.
UPDATE Employees
SET Department = 14
WHERE Department = 77


19.
DELETE from Employees
WHERE Department = 14


20.
SELECT d. Name as Department_name, Budget, e.name as employee_name 
FROM Departments d
JOIN Employees e
ON d.code = e.Department


21.
DELETE from Employees




