-- DATA CLEANING 
-- This is my normal proccess when performing cleaning data received from stakeholders. It includes modifying date format, address data, outliers, null value ... 

--------------------------------------------------------------------------------------------------------------------------
-- Find out contaiminatied data
--------------------------------------------------------------------------------------------------------------------------
-- Find  out missing data
--------------------------------------------------------------------------------------------------------------------------
-- Find out incosistent data
--------------------------------------------------------------------------------------------------------------------------
-- Find out invalid data (not acceptable record)
--------------------------------------------------------------------------------------------------------------------------
-- Standardize Date Format
 --------------------------------------------------------------------------------------------------------------------------
-- Populate Property Address data
--------------------------------------------------------------------------------------------------------------------------
-- Breaking out Address into Individual Columns (Address, City, State)
--------------------------------------------------------------------------------------------------------------------------
-- Change Y and N to Yes and No in "" field (Into consistent field)
--------------------------------------------------------------------------------------------------------------------------
-- Remove Duplicates
-- No duplicated record

--Check duplicate with index column

WITH RowNumCTE AS(
SELECT
*,
ROW_NUMBER () OVER (PARTITION BY [EmployeeNumber] ORDER BY [EmployeeNumber]) AS DE_DUP 
FROM
[dbo].[People_information]
)
SELECT *
FROM RowNumCTE
WHERE DE_DUP > 1
ORDER BY [EmployeeNumber]

----Check duplicate without index column

WITH RowNumCTE AS(
SELECT
*,
ROW_NUMBER () OVER (PARTITION BY [EmployeeNumber]
								,[Age]
								,[Gender]
								,[Education]
								,[EducationField]
								,[MaritalStatus]
								,[Department]
								,[JobRole]
								,[MonthlyIncome] ORDER BY [EmployeeNumber]) AS DE_DUP 
FROM
[dbo].[People_information]
)
SELECT *
FROM RowNumCTE
WHERE DE_DUP > 1
ORDER BY [EmployeeNumber]
---------------------------------------------------------------------------------------------------------

-- Delete Unused and useless Columns
-- Instead of deleting, I often create a new table/temp table which includes usable columns and reorder them for analyzing
SELECT 
[EmployeeNumber]
,[Attrition]
,[Age]
,[Gender]
,[Education]
,[EducationField]
,[MaritalStatus]
,[DistanceFromHome]
,[Department]
,[JobRole]
,[MonthlyIncome]
,[PerformanceRating]
,[OverTime]
,[StandardHours]
,[JobSatisfaction]
,[EnvironmentSatisfaction]
,[RelationshipSatisfaction]
,[WorkLifeBalance]
,[YearsAtCompany]
,[YearsInCurrentRole]
,[YearsSinceLastPromotion]
,[YearsWithCurrManager]
,[TotalWorkingYears]
INTO HR_Analytics
FROM
[dbo].[People_information]