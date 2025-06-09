-- 1
WITH GroupedStatus AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Step Number]) -
           ROW_NUMBER() OVER (PARTITION BY Status ORDER BY [Step Number]) AS grp
    FROM Groupings
),
ConsecutiveGroups AS (
    SELECT 
        MIN([Step Number]) AS [Min Step Number],
        MAX([Step Number]) AS [Max Step Number],
        Status,
        COUNT(*) AS [Consecutive Count]
    FROM GroupedStatus
    GROUP BY Status, grp
)
SELECT * 
FROM ConsecutiveGroups
ORDER BY [Min Step Number];

-- 2
-- Step 1: Generate all years from 1975 to current
WITH AllYears AS (
    SELECT TOP (YEAR(GETDATE()) - 1974)
        1974 + ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS HireYear
    FROM master..spt_values
),
-- Step 2: Get distinct hiring years
HiredYears AS (
    SELECT DISTINCT YEAR(HIRE_DATE) AS HireYear
    FROM EMPLOYEES_N
),
-- Step 3: Find years without hires
NoHireYears AS (
    SELECT HireYear
    FROM AllYears
    WHERE HireYear NOT IN (SELECT HireYear FROM HiredYears)
),
-- Step 4: Group into intervals using dense difference method
Grouped AS (
    SELECT *,
           HireYear - ROW_NUMBER() OVER (ORDER BY HireYear) AS grp
    FROM NoHireYears
)
-- Step 5: Get min and max per group
SELECT 
    MIN(HireYear) AS StartYear,
    MAX(HireYear) AS EndYear,
    CONCAT(MIN(HireYear), ' - ', MAX(HireYear)) AS Years
FROM Grouped
GROUP BY grp
ORDER BY StartYear;
