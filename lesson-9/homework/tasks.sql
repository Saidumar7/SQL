-- 1
WITH EmployeeDepth AS (
    SELECT 
        EmployeeID,
        ManagerID,
        JobTitle,
        0 AS Depth
    FROM Employees
    WHERE ManagerID IS NULL  -- Start from President

    UNION ALL

    SELECT 
        e.EmployeeID,
        e.ManagerID,
        e.JobTitle,
        ed.Depth + 1
    FROM Employees e
    INNER JOIN EmployeeDepth ed ON e.ManagerID = ed.EmployeeID
)
SELECT * 
FROM EmployeeDepth
ORDER BY Depth, EmployeeID;

-- 2
DECLARE @N INT = 10;

WITH FactorialCTE AS (
    SELECT 1 AS Num, 1 AS Factorial
    UNION ALL
    SELECT Num + 1, Factorial * (Num + 1)
    FROM FactorialCTE
    WHERE Num < @N
)
SELECT * FROM FactorialCTE;

-- 3
DECLARE @N INT = 10;

WITH FibonacciCTE AS (
    SELECT 1 AS n, 1 AS Fibonacci_Number
    UNION ALL
    SELECT 2, 1
    UNION ALL
    SELECT n + 1, 
           Fibonacci_Number + LAG(Fibonacci_Number) OVER (ORDER BY n)
    FROM (
        SELECT *, ROW_NUMBER() OVER (ORDER BY n) AS rn
        FROM (
            SELECT 1 AS n, 1 AS Fibonacci_Number
            UNION ALL
            SELECT 2, 1
        ) base
        UNION ALL
        SELECT n + 1, NULL
        FROM generate_series(3, @N) AS n(n)
    ) seq
),
FinalFibo AS (
    SELECT * FROM FibonacciCTE
    WHERE n <= @N
)
SELECT * FROM FinalFibo;
