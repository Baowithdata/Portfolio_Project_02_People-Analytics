/*
People Analytics Data Exploration 
Skills used: Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types
*/
-- Big Question 1: Employees with high attrition rate
-- 1. Attrition rate by Ages
SELECT
EmployeeNumber
,Attrition
,Age
,CASE 
	WHEN 0 <= AGE AND AGE <= 20 THEN 20 
	WHEN 20 < AGE AND AGE <= 30 THEN 30 
	WHEN 30 < AGE AND AGE <= 40 THEN 40 
	WHEN 40 < AGE AND AGE <= 50 THEN 50 
	WHEN 50 < AGE AND AGE <= 60 THEN 60 
END AS Age_range
INTO #A
FROM
[dbo].[HR_Analytics];

WITH 
Attrition AS (
SELECT 
Age_range
,Attrition
,COUNT (EmployeeNumber) AS #_of_Employees
FROM
#A
WHERE
Attrition = 'YES'
GROUP BY
Age_range, Attrition),
Total AS (
SELECT
Age_range
,COUNT (EmployeeNumber) AS Total_Employees
FROM
#A
GROUP BY
Age_range)
SELECT
A.Age_range
, Total_Employees
,CAST (#_of_Employees AS FLOAT)/Total_Employees  AS Attirtion_rate
FROM
Attrition A
JOIN
TOTAL T
ON
A.Age_range = T.Age_range;

-- 2. Attrition rate by Gender

WITH 
Attrition AS (
SELECT 
	Gender
	,Attrition
	,COUNT (EmployeeNumber) AS #_of_Employees
FROM
[dbo].[HR_Analytics]
WHERE
Attrition = 'YES'
GROUP BY
Gender, Attrition),
Total AS (
SELECT
	Gender
	,COUNT (EmployeeNumber) AS Total_Employees
FROM
[dbo].[HR_Analytics]
GROUP BY
Gender)
SELECT
	A.Gender
	,Total_Employees
	,CAST (#_of_Employees AS FLOAT)/Total_Employees  AS Attirtion_rate
FROM
Attrition A
JOIN
TOTAL T
ON
A.Gender = T.Gender

-- 3. Attrition rate by Education

WITH 
Attrition AS (
SELECT 
	Education
	,Attrition
	,COUNT (EmployeeNumber) AS #_of_Employees
FROM
[dbo].[HR_Analytics]
WHERE
Attrition = 'YES'
GROUP BY
Education, Attrition),
Total AS (
SELECT
	Education
	,COUNT (EmployeeNumber) AS Total_Employees
FROM
[dbo].[HR_Analytics]
GROUP BY
Education)
SELECT
	A.Education
	,Total_Employees
	,CAST (#_of_Employees AS FLOAT)/Total_Employees  AS Attirtion_rate
FROM
Attrition A
JOIN
TOTAL T
ON
A.Education = T.Education

-- 4. Attrition rate by Education Field
WITH 
Attrition AS (
SELECT 
	EducationField
	,Attrition
	,COUNT (EmployeeNumber) AS #_of_Employees
FROM
[dbo].[HR_Analytics]
WHERE
Attrition = 'YES'
GROUP BY
EducationField, Attrition),
Total AS (
SELECT
	EducationField
	,COUNT (EmployeeNumber) AS Total_Employees
FROM
[dbo].[HR_Analytics]
GROUP BY
EducationField)
SELECT
	A.EducationField
	,Total_Employees
	,CAST (#_of_Employees AS FLOAT)/Total_Employees  AS Attirtion_rate
FROM
Attrition A
JOIN
TOTAL T
ON
A.EducationField = T.EducationField
-- 5. Attrition rate by Marital Status
WITH 
Attrition AS (
SELECT 
	MaritalStatus
	,Attrition
	,COUNT (EmployeeNumber) AS #_of_Employees
FROM
[dbo].[HR_Analytics]
WHERE
Attrition = 'YES'
GROUP BY
MaritalStatus, Attrition),
Total AS (
SELECT
	MaritalStatus
	,COUNT (EmployeeNumber) AS Total_Employees
FROM
[dbo].[HR_Analytics]
GROUP BY
MaritalStatus)
SELECT
	A.MaritalStatus
	,Total_Employees
	,CAST (#_of_Employees AS FLOAT)/Total_Employees  AS Attirtion_rate
FROM
Attrition A
JOIN
TOTAL T
ON
A.MaritalStatus = T.MaritalStatus
-- 6. Attrition rate by Department
WITH 
Attrition AS (
SELECT 
	Department
	,Attrition
	,COUNT (EmployeeNumber) AS #_of_Employees
FROM
[dbo].[HR_Analytics]
WHERE
Attrition = 'YES'
GROUP BY
Department, Attrition),
Total AS (
SELECT
	Department
	,COUNT (EmployeeNumber) AS Total_Employees
FROM
[dbo].[HR_Analytics]
GROUP BY
Department)
SELECT
	A.Department
	,Total_Employees
	,CAST (#_of_Employees AS FLOAT)/Total_Employees  AS Attirtion_rate
FROM
Attrition A
JOIN
TOTAL T
ON
A.Department = T.Department
-- 7. Attrition rate by Job Role
WITH 
Attrition AS (
SELECT 
	JobRole
	,Attrition
	,COUNT (EmployeeNumber) AS #_of_Employees
FROM
[dbo].[HR_Analytics]
WHERE
Attrition = 'YES'
GROUP BY
JobRole, Attrition),
Total AS (
SELECT
	JobRole
	,COUNT (EmployeeNumber) AS Total_Employees
FROM
[dbo].[HR_Analytics]
GROUP BY
JobRole)
SELECT
	A.JobRole
	,Total_Employees
	,CAST (#_of_Employees AS FLOAT)/Total_Employees  AS Attirtion_rate
FROM
Attrition A
JOIN
TOTAL T
ON
A.JobRole = T.JobRole
-- 8. Attrition rate by Monthly Income
DROP TABLE #B
SELECT
EmployeeNumber
,Attrition
,MonthlyIncome
,Range
,CASE 
	WHEN 0 <= MonthlyIncome		AND MonthlyIncome <= 2000	THEN 2000
	WHEN 2000 < MonthlyIncome	AND MonthlyIncome <= 5000	THEN 5000
	WHEN 5000 < MonthlyIncome	AND MonthlyIncome <= 10000	THEN 10000
	WHEN 10000 < MonthlyIncome	AND MonthlyIncome <= 15000	THEN 15000
	WHEN 15000 < MonthlyIncome	AND MonthlyIncome <= 20000	THEN 20000
END AS MonthlyIncome_range
INTO #B
FROM
[dbo].[HR_Analytics]


WITH 
Attrition AS (
SELECT 
	MonthlyIncome_range
	,Attrition
	,COUNT (EmployeeNumber) AS #_of_Employees
FROM
#B
WHERE
Attrition = 'YES'
GROUP BY
MonthlyIncome_range, Attrition),
Total AS (
SELECT
	MonthlyIncome_range
	,COUNT (EmployeeNumber) AS Total_Employees
FROM
#B
GROUP BY
MonthlyIncome_range)
SELECT
	A.MonthlyIncome_range
	,Total_Employees
	,CAST (#_of_Employees AS FLOAT)/Total_Employees  AS Attirtion_rate
FROM
Attrition A
JOIN
TOTAL T
ON
A.MonthlyIncome_range = T.MonthlyIncome_range
--9. Attrition rate by Distance from home
DECLARE @ID INT,
		@interval INT,
		@MAX INT,
		@DIS INT,
		@RANGE INT
SET @interval = 5
SELECT 
@ID		= MIN	([EmployeeNumber]),
@MAX	= MAX	([EmployeeNumber]) 
FROM HR_Analytics
WHILE  (@ID <= @MAX)
	BEGIN
	SELECT @DIS = [DistanceFromHome]
	FROM HR_Analytics
	WHERE
	[EmployeeNumber] = @ID
	WHILE (@DIS > @interval)  
		BEGIN
			SET @Interval = @interval +5  
		END
	UPDATE HR_Analytics
	SET [Range] = @interval WHERE [EmployeeNumber] = @ID
	SET @interval = 5
	SET @ID = @ID + 1
END
WITH 
Attrition AS (
SELECT 
	Range
	,Attrition
	,COUNT (EmployeeNumber) AS #_of_Employees
FROM
[dbo].[HR_Analytics]
WHERE
Attrition = 'YES'
GROUP BY
Range, Attrition),
Total AS (
SELECT
	Range
	,COUNT (EmployeeNumber) AS Total_Employees
FROM
[dbo].[HR_Analytics]
GROUP BY
Range)
SELECT
	A.Range
	,Total_Employees
	,CAST (#_of_Employees AS FLOAT)/Total_Employees  AS Attirtion_rate
FROM
Attrition A
JOIN
TOTAL T
ON
A.Range = T.Range
-- break by distance and income
WITH att_break AS (
SELECT DISTINCT
range
,MonthlyIncome_range
,attrition
,	COUNT (EMPLOYEENUMBER) OVER (PARTITION BY range,attrition) AS #_of_employee_dis
,	COUNT (EMPLOYEENUMBER) OVER (PARTITION BY range) AS #_of_employee_incl_dis
,	COUNT (EMPLOYEENUMBER) OVER (PARTITION BY range,monthlyincome_range,attrition) AS #_of_employee
,	COUNT (EMPLOYEENUMBER) OVER (PARTITION BY range,monthlyincome_range) AS #_of_employee_incl
FROM
#B)
SELECT 
* 
,attrition_rate_dis_only = cast (#_of_employee_dis AS FLOAT)/#_of_employee_incl_dis
,attrition_rate = cast (#_of_employee AS FLOAT)/#_of_employee_incl
FROM
att_break
WHERE
Attrition = 'YES'
ORDER BY
range, MonthlyIncome_range
