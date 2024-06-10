--1. Select all warehouses.
SELECT * FROM Warehouses

--2. Select all boxes with a value larger than $150.
SELECT * FROM Boxes
WHERE Value >= 150

--3. Select all distinct contents in all the boxes.
SELECT DISTINCT Contents FROM Boxes

--4. Select the average value of all the boxes.
SELECT Avg(value) FROM Boxes

--5. Select the warehouse code and the average value of the boxes in each warehouse.
SELECT Code, avg(value) from Boxes
GROUP BY Code

--6. Same as previous exercise, but select only those warehouses where the average value of the boxes is greater than 150.
SELECT Code, avg(value) from Boxes
GROUP BY Code
HAVING avg(value) >= 150

--7. Select the code of each box, along with the name of the city the box is located in.
SELECT Boxes.Code, Location FROM Boxes
JOIN Warehouses
ON Warehouses.Code = Boxes.Warehouse
 
--8. Select the warehouse codes, along with the number of boxes in each warehouse. 
SELECT Warehouses.Code, count(*) FROM Warehouses
JOIN Boxes
ON Warehouses.Code = Boxes.Warehouse
GROUP BY Warehouses.Code

--9. Select the codes of all warehouses that are saturated 
--(a warehouse is saturated if the number of boxes in it is larger than the warehouse's capacity).
SELECT Warehouses.Code From Warehouses
JOIN Boxes
ON Warehouses.Code = Boxes.Warehouse
GROUP BY Warehouses.Code
HAVING Warehouses.Capacity < count(warehouse) 

--10. Select the codes of all the boxes located in Chicago.
SELECT Boxes.Code FROM Boxes
JOIN Warehouses
ON Warehouses.Code = Boxes.Warehouse
WHERE Location = 'Chicago'

--11. Create a new warehouse in New York with a capacity for 3 boxes.
INSERT INTO Warehouses VALUES(6, 'New York', 3)

--12. Create a new box, with code "H5RT", containing "Papers" with a value of $200, and located in warehouse 2.
INSERT INTO Boxes VALUES('H5RT', 'Papers', 200, 2)

--13. Reduce the value of all boxes by 15%.
UPDATE Boxes 
SET Value = Value*0.85

--14. Remove all boxes with a value lower than $100.
DELETE FROM Boxes
WHERE Value < 100

--15. Remove all boxes from saturated warehouses.
 DELETE FROM Boxes 
  WHERE Warehouse IN 
  (
   SELECT * FROM 
     (
       SELECT Code
	 FROM Warehouses
	 WHERE Capacity <
           (
                SELECT COUNT(*)
		  FROM Boxes
		  WHERE Warehouse = Warehouses.Code
            )
      ) AS Bxs
  );

SELECT * From Boxes
  
  
--16. Add Index for column "Warehouse" in table "boxes"
    -- !!!NOTE!!!: index should NOT be used on small tables in practice
CREATE INDEX Index_16 ON Boxes (Warehouse)
	
--17. Print all the existing indexes
    -- !!!NOTE!!!: index should NOT be used on small tables in practice
SELECT name 
FROM sqlite_master 
WHERE type = 'index'
	
--18. Remove (drop) the index you added just
    -- !!!NOTE!!!: index should NOT be used on small tables in practice
DROP INDEX Index_16 






