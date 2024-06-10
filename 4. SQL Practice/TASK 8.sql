-- 8.1 Obtain the names of all physicians that have performed a medical procedure they have never been certified to perform.

SELECT DISTINCT Physician.Name
FROM Physician
JOIN Undergoes 
ON Physician.EmployeeID = Undergoes.Physician
LEFT JOIN Trained_In 
ON Physician.EmployeeID = Trained_In.Physician AND Undergoes.Procedure = Trained_In.Treatment
WHERE Trained_In.Treatment IS NULL


-- 8.2 Same as the previous query, but include the following information in the results
-- : Physician name, name of procedure, date when the procedure was carried out, name of the patient the procedure was carried out on.

SELECT DISTINCT Physician.Name, Procedures.Name as ProcedureName, Undergoes.Date, Patient.Name as PatientName
FROM Physician
JOIN Undergoes ON Physician.EmployeeID = Undergoes.Physician
JOIN Procedures On Undergoes.Procedure = Procedures.Code
JOIN Patient On Undergoes.Patient = Patient.SSN
LEFT JOIN Trained_In ON Physician.EmployeeID = Trained_In.Physician AND Undergoes.Procedure = Trained_In.Treatment
WHERE Trained_In.Treatment IS NULL



-- 8.3 Obtain the names of all physicians that have performed a medical procedure that they are certified to perform, 
-- but such that the procedure was done at a date (Undergoes.Date) after the physician's certification expired (Trained_In.CertificationExpires).

SELECT DISTINCT Physician.Name FROM Physician
JOIN Undergoes
ON Undergoes.Physician = Physician.EmployeeID
JOIN Trained_In
ON Trained_In.Physician = Physician.EmployeeID
	WHERE julianday(Trained_in.CertificationExpires) - julianday(Undergoes.Date) < 0
	OR julianday(Trained_in.CertificationDate) - julianday(Undergoes.Date) >0


-- 8.4 Same as the previous query, but include the following information in the results
-- : Physician name, name of procedure, date when the procedure was carried out, name of the patient the procedure was carried out on, and date when the certification expired.

SELECT DISTINCT Physician.Name as PhysicianName, Procedures.Name as ProcedureName, Undergoes.date, Patient.Name as PatientName, Trained_In.CertificationExpires as ExpiredDate FROM Physician
JOIN Undergoes
ON Undergoes.Physician = Physician.EmployeeID
JOIN Procedures
ON Procedures.Code = Undergoes.Procedure
JOIN Patient
ON Undergoes.Patient = Patient.SSN
JOIN Trained_In
ON Trained_In.Physician = Physician.EmployeeID
	WHERE julianday(Trained_in.CertificationExpires) - julianday(Undergoes.Date) < 0
	OR julianday(Trained_in.CertificationDate) - julianday(Undergoes.Date) >0

-- 8.5 Obtain the information for appointments where a patient met with a physician other than his/her primary care physician. 
-- Show the following information: Patient name, physician name, nurse name (if any), start and end time of appointment, examination room, and the name of the patient's primary care physician.

SELECT 
	Patient.Name as PatientName, 
	Physician.Name as PhysicianName, 
	Nurse.Name as NurseName, 
	Appointment.Start, 
	Appointment.End, 
	Appointment.ExaminationRoom, 
	Physician.Name as PCP 
FROM Patient
	JOIN Appointment ON Patient.SSN = Appointment.Patient
	JOIN Physician On Appointment.Physician = Physician.EmployeeID
	JOIN Nurse On Appointment.PrepNurse = Nurse.EmployeeID
	WHERE Patient.PCP = Appointment.Physician


-- 8.6 The Patient field in Undergoes is redundant, since we can obtain it from the Stay table. There are no constraints in force to prevent inconsistencies between these two tables. 
-- More specifically, the Undergoes table may include a row where the patient ID does not match the one we would obtain from the Stay table through the Undergoes.
-- Stay foreign key. Select all rows from Undergoes that exhibit this inconsistency.

SELECT * FROM Stay
SELECT * FROM Undergoes

-- 8.7 Obtain the names of all the nurses who have ever been on call for room 123.
SELECT Nurse.Name FROM Nurse
JOIN On_Call ON Nurse.EmployeeID = On_Call.Nurse
JOIN Room ON On_Call.BlockCode = Room.BlockCode
WHERE Room.Number = 123


-- 8.8 The hospital has several examination rooms where appointments take place. Obtain the number of appointments that have taken place in each examination room.
SELECT Appointment.ExaminationRoom, count(*) as Number_of_Appointment From Appointment
GROUP BY ExaminationRoom

-- 8.9 Obtain the names of all patients and their primary care physician, such that the following are true:
    -- The patient has been prescribed some medication by his/her primary care physician.	
    -- The patient has undergone a procedure with a cost larger that $5,000
    -- The patient has had at least two appointments where the nurse who prepared the appointment was a registered nurse.
    -- The patient's primary care physician is not the head of any department.

	
-- The patient has been prescribed some medication by his/her primary care physician.	
SELECT Patient.Name as PatientName, Physician.Name From Patient
JOIN Prescribes 
ON Prescribes.Patient = Patient.SSN
JOIN Physician
ON Prescribes.Physician = Physician.EmployeeID
WHERE Prescribes.Physician = Patient.PCP	

-- The patient has undergone a procedure with a cost larger that $5,000
SELECT Patient.Name as PatientName, Physician.Name From Patient
JOIN Prescribes 
ON Prescribes.Patient = Patient.SSN
JOIN Physician
ON Prescribes.Physician = Physician.EmployeeID
JOIN Undergoes
ON Patient.SSN =Undergoes.Patient
JOIN Procedures
ON Undergoes.Procedure = Procedures.Code
WHERE Procedures.Cost > 5000

-- The patient has had at least two appointments where the nurse who prepared the appointment was a registered nurse.
SELECT Patient.Name as PatientName, Physician.Name From Patient
JOIN Prescribes 
ON Prescribes.Patient = Patient.SSN
JOIN Physician
ON Prescribes.Physician = Physician.EmployeeID
JOIN Undergoes
ON Patient.SSN =Undergoes.Patient
JOIN Procedures
ON Undergoes.Procedure = Procedures.Code
JOIN Appointment
ON Patient.SSN = Appointment.Patient
JOIN Nurse
ON Nurse.EmployeeID = Appointment.PrepNurse
GROUP BY Appointment.PrepNurse
Having Nurse.Registered = 1 
AND count(*) > 1

 -- The patient's primary care physician is not the head of any department.
SELECT Patient.Name as PatientName, Physician.Name From Patient
JOIN Prescribes 
ON Prescribes.Patient = Patient.SSN
JOIN Physician
ON Prescribes.Physician = Physician.EmployeeID
LEFT JOIN Department
ON Physician.EmployeeID = Department.Head
WHERE Department.Head IS NULL

 -- Combining them
SELECT DISTINCT Patient.Name as PatientName, Physician.Name as PrimaryPhysician From Patient
JOIN Prescribes 
ON Prescribes.Patient = Patient.SSN
JOIN Physician
ON Prescribes.Physician = Physician.EmployeeID
JOIN Undergoes
ON Patient.SSN =Undergoes.Patient
JOIN Procedures
ON Undergoes.Procedure = Procedures.Code
JOIN Appointment
ON Patient.SSN = Appointment.Patient
JOIN Nurse
ON Nurse.EmployeeID = Appointment.PrepNurse
LEFT JOIN Department
ON Physician.EmployeeID = Department.Head
WHERE Prescribes.Physician = Patient.PCP	
		AND Procedures.Cost > 5000
		AND Department.Head IS NULL
GROUP BY PatientName, PrimaryPhysician
HAVING count(*) > 1 AND Nurse.Registered =1;
