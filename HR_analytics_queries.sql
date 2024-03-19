create database HRproject;

SELECT * FROM hr_1 ;
SELECT * FROM hr_2 ;

# Average Attrition rate for all Departments (KPI 1)
SELECT 
department,
concat(round((AVG(CASE WHEN attrition = 'yes' THEN 1 ELSE 0 END)*100),2),'%') AS avg_attrition_rate
FROM hr_1
GROUP BY 
department;

# Average Hourly rate of Male Research Scientist (KPI 2)
SELECT 
round(AVG(HourlyRate),2) AS avg_hourly_rate
FROM hr_1
WHERE Gender = 'Male' AND JobRole = 'Research Scientist';

# Attrition rate Vs Monthly income stats (KPI 3)
SELECT
Department,
MonthlyIncome,
concat(round((AVG(CASE WHEN attrition = 'yes' THEN 1 ELSE 0 END)*100),2),'%') AS avg_attrition_rate
FROM hr_1 INNER JOIN hr_2 ON hr_1.EmployeeNumber = hr_2.`Employee ID`
GROUP BY 
department;

# Average working years for each Department (KPI 4)
SELECT 
hr_1.Department,
ROUND(AVG(hr_2.TotalWorkingYears),2) AS avg_working_years
FROM hr_1 INNER JOIN hr_2 ON hr_1.EmployeeNumber = hr_2.`Employee ID`
GROUP BY hr_1.Department;

# Departmentwise No of Employees (KPI 5)
SELECT Department,
count(EmployeeCount) AS no_of_employees
FROM hr_1
GROUP BY hr_1.Department;

# Count of Employees based on Educational Fields (KPI 6)
SELECT EducationField,
count(EmployeeCount) AS no_of_employees
FROM hr_1
GROUP BY EducationField;

# Job Role Vs Work life balance (KPI 7)
SELECT 
hr_1.JobRole AS job_role,
SUM(CASE WHEN hr_2.WorkLifeBalance = 4 THEN 1 ELSE 0 END) AS excellent_count,
SUM(CASE WHEN hr_2.WorkLifeBalance = 3 THEN 1 ELSE 0 END) AS good_count,
SUM(CASE WHEN hr_2.WorkLifeBalance = 2 THEN 1 ELSE 0 END) AS average_count,
SUM(CASE WHEN hr_2.WorkLifeBalance = 1 THEN 1 ELSE 0 END) AS poor_count
FROM hr_1 INNER JOIN hr_2 ON hr_1.EmployeeNumber = hr_2.`Employee ID`
GROUP BY hr_1.JobRole;

# Attrition rate Vs Year since last promotion relation (KPI 8)
SELECT 
YearsSinceLastPromotion,
COUNT(*) AS total_employees,
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,
CONCAT(ROUND((SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2),'%') AS attrition_rate
FROM 
hr_1 INNER JOIN hr_2 ON hr_1.EmployeeNumber = hr_2.`Employee ID`
GROUP BY 
YearsSinceLastPromotion;

# Gender based Percentage of Employee (KPI 9)
SELECT 
Gender,
round((COUNT(Gender) * 100.0 / (SELECT COUNT(*) FROM hr_1)), 3) AS percentage_of_employee
FROM hr_1
GROUP BY gender;

# Deptarment / Job Role wise job satisfaction (KPI 11)
SELECT 
Department,
JobRole,
SUM(CASE WHEN JobSatisfaction = 4 THEN 1 ELSE 0 END) AS excellent_count,
SUM(CASE WHEN JobSatisfaction = 3 THEN 1 ELSE 0 END) AS good_count,
SUM(CASE WHEN JobSatisfaction = 2 THEN 1 ELSE 0 END) AS average_count,
SUM(CASE WHEN JobSatisfaction = 1 THEN 1 ELSE 0 END) AS poor_count
FROM hr_1
GROUP BY 
Department,
JobRole;