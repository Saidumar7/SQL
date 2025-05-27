
CREATE TABLE Employees1 (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Department VARCHAR(50) NOT NULL,
    Salary DECIMAL(10,2) NOT NULL,
    HireDate DATE NOT NULL
);

INSERT INTO Employees1 (Name, Department, Salary, HireDate) VALUES
    ('Alice', 'HR', 50000, '2020-06-15'),
    ('Bob', 'HR', 60000, '2018-09-10'),
    ('Charlie', 'IT', 70000, '2019-03-05'),
    ('David', 'IT', 80000, '2021-07-22'),
    ('Eve', 'Finance', 90000, '2017-11-30'),
    ('Frank', 'Finance', 75000, '2019-12-25'),
    ('Grace', 'Marketing', 65000, '2016-05-14'),
    ('Hank', 'Marketing', 72000, '2019-10-08'),
    ('Ivy', 'IT', 67000, '2022-01-12'),
    ('Jack', 'HR', 52000, '2021-03-29');

-- 1
SELECT *,
    RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
FROM Employees;

-- 2
SELECT *,
    DENSE_RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
FROM Employees;

--3
SELECT *
FROM (
    SELECT *,
           DENSE_RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS DeptRank
    FROM Employees
) AS Ranked
WHERE DeptRank <= 2;

-- 4
SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY Department ORDER BY Salary ASC) AS RowNum
    FROM Employees
) AS Ranked
WHERE RowNum = 1;

-- 5
SELECT *,
    SUM(Salary) OVER (PARTITION BY Department ORDER BY HireDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningTotal
FROM Employees;

-- 6
SELECT *,
    SUM(Salary) OVER (PARTITION BY Department) AS TotalDepartmentSalary
FROM Employees;

-- 7
SELECT *,
    AVG(Salary) OVER (PARTITION BY Department) AS AvgDepartmentSalary
FROM Employees;

-- 8
SELECT *,
    Salary - AVG(Salary) OVER (PARTITION BY Department) AS SalaryDifference
FROM Employees;

-- 9
SELECT *,
    AVG(Salary) OVER (ORDER BY HireDate ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS MovingAvg
FROM Employees;

-- 10
SELECT *,
        sum(Salary) over() as lastsum
FROM (
    SELECT *, 
           ROW_NUMBER() OVER (ORDER BY HireDate DESC) AS RowNum
    FROM Employees
) AS Ranked
WHERE RowNum <= 3;

-- 11
SELECT *,
    AVG(Salary) OVER (ORDER BY HireDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningAvg
FROM Employees;

-- 12
SELECT *,
    MAX(Salary) OVER (ORDER BY HireDate ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING) AS MaxInWindow
FROM Employees;

-- 13
SELECT *,
    CAST(Salary * 100.0 / SUM(Salary) OVER (PARTITION BY Department) AS DECIMAL(5,2)) AS PercentOfDept
FROM Employees;

