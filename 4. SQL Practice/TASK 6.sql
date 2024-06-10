-- 6.1 List all the scientists' names, their projects' names, 
    -- and the total hours worked on each project, 
    -- in alphabetical order of project name, then scientist name.

SELECT Scientists.Name as ScientistName, Projects.Name as ProjectName, sum(Hours) as ProjectHours From Scientists
JOIN  AssignedTo
ON Scientists.SSN = AssignedTo.Scientist
JOIN Projects
ON AssignedTo.Project = Projects.Code
GROUP BY ScientistName
ORDER BY ProjectName ASC, ScientistName ASC;


-- 6.2 Select the project names which are not assigned yet

SELECT Projects.Name FROM Projects
LEFT JOIN AssignedTo
ON Projects.Code = AssignedTo.Project
WHERE AssignedTo.Project IS NULL
