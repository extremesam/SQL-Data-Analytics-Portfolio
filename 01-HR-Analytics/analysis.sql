Business Question 1
How many employees do we have?

SELECT COUNT(*) AS TotalEmployees
FROM employees;

Business Question 2
Which department has the highest attrition?

SELECT
Department,
COUNT(*) AS Employees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Leavers,
ROUND(
100.0 *
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)
/ COUNT(*),
2
) AS AttritionRate
FROM employees
GROUP BY Department
ORDER BY AttritionRate DESC;

Business Question 3
Average salary by department

SELECT
Department,
AVG(Salary) AS AvgSalary
FROM employees
GROUP BY Department
ORDER BY AvgSalary DESC;

Business Question 4
Top performing departments
  
SELECT
Department,
AVG(PerformanceRating) AS AvgPerformance
FROM employees
GROUP BY Department
ORDER BY AvgPerformance DESC;

Business Question 5
Use Window Functions
SELECT
EmployeeID,
Department,
Salary,
RANK() OVER(
PARTITION BY Department
ORDER BY Salary DESC
) AS SalaryRank
FROM employees;
