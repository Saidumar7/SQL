
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL
);

CREATE TABLE Employees1 (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    DepartmentID INT NULL,
    Salary DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(100) NOT NULL,
    EmployeeID INT NULL,
    FOREIGN KEY (EmployeeID) REFERENCES Employees1(EmployeeID)
);

-- Insert data into Departments table
INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(101, 'IT'),
(102, 'HR'),
(103, 'Finance'),
(104, 'Marketing');

-- Insert data into Employees table
INSERT INTO Employees1 (EmployeeID, Name, DepartmentID, Salary) VALUES
(1, 'Alice', 101, 60000),
(2, 'Bob', 102, 70000),
(3, 'Charlie', 101, 65000),
(4, 'David', 103, 72000),
(5, 'Eva', NULL, 68000);

-- Insert data into Projects table
INSERT INTO Projects (ProjectID, ProjectName, EmployeeID) VALUES
(1, 'Alpha', 1),
(2, 'Beta', 2),
(3, 'Gamma', 1),
(4, 'Delta', 4),
(5, 'Omega', NULL);


-- 1
select * 
from Employees1 join Departments on Employees1.DepartmentID = Departments.DepartmentID

-- 2
select *
from Employees1 left join Departments on Employees1.DepartmentID = Departments.DepartmentID

-- 3
select *
from Employees1 right join Departments on Employees1.DepartmentID = Departments.DepartmentID

-- 4
select *
from Employees1 full join Departments on Employees1.DepartmentID = Departments.DepartmentID

-- 5
select *, sum(Salary) over(partition by departmentID)
from Employees1

SELECT 
    d.DepartmentName,
    SUM(e.Salary) AS TotalSalaryExpense
FROM 
    Employees1 e
JOIN 
    Departments d ON e.DepartmentID = d.DepartmentID
GROUP BY 
    d.DepartmentName;

-- 6
select *
from Projects, Departments

-- 7
select Employees1.EmployeeID, Name, DepartmentName, ProjectName
from Employees1 left join Departments on Employees1.DepartmentID = Departments.DepartmentID left join Projects on Employees1.EmployeeID = Projects.EmployeeID
