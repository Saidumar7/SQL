CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    HireDate DATE
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    Status VARCHAR(20) CHECK (Status IN ('Pending', 'Shipped', 'Delivered', 'Cancelled'))
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    Stock INT
);

INSERT INTO Employees VALUES (1, 'Alice', 'Smith', 'HR', 72000.00, '2018-06-12');
INSERT INTO Employees VALUES (2, 'Bob', 'Johnson', 'Engineering', 85000.50, '2017-03-18');
INSERT INTO Employees VALUES (3, 'Carol', 'Williams', 'Marketing', 49000.00, '2020-09-01');
INSERT INTO Employees VALUES (4, 'David', 'Brown', 'HR', 78000.25, '2019-01-23');
INSERT INTO Employees VALUES (5, 'Eve', 'Jones', 'Engineering', 95000.75, '2015-04-11');
INSERT INTO Employees VALUES (6, 'Frank', 'Garcia', 'Engineering', 61000.00, '2016-05-14');
INSERT INTO Employees VALUES (7, 'Grace', 'Miller', 'Sales', 58000.30, '2021-02-19');
INSERT INTO Employees VALUES (8, 'Henry', 'Davis', 'Marketing', 52000.00, '2020-12-01');
INSERT INTO Employees VALUES (9, 'Ivy', 'Martinez', 'Sales', 47000.45, '2022-01-15');
INSERT INTO Employees VALUES (10, 'Jack', 'Rodriguez', 'Engineering', 88000.00, '2014-11-30');
INSERT INTO Employees VALUES (11, 'Karen', 'Martinez', 'HR', 51000.00, '2018-03-15');
INSERT INTO Employees VALUES (12, 'Leo', 'Hernandez', 'Sales', 60000.20, '2019-07-25');
INSERT INTO Employees VALUES (13, 'Maria', 'Lopez', 'Engineering', 93000.10, '2017-10-10');
INSERT INTO Employees VALUES (14, 'Nina', 'Gonzalez', 'Marketing', 45000.00, '2020-06-18');
INSERT INTO Employees VALUES (15, 'Oscar', 'Wilson', 'Sales', 55000.90, '2022-03-01');
INSERT INTO Employees VALUES (16, 'Paul', 'Anderson', 'Engineering', 87000.60, '2015-02-20');
INSERT INTO Employees VALUES (17, 'Queen', 'Thomas', 'Marketing', 49000.00, '2021-08-22');
INSERT INTO Employees VALUES (18, 'Ray', 'Taylor', 'Sales', 52000.50, '2022-05-05');
INSERT INTO Employees VALUES (19, 'Sara', 'Moore', 'HR', 76000.00, '2018-11-08');
INSERT INTO Employees VALUES (20, 'Tom', 'Jackson', 'Engineering', 91000.90, '2016-01-17');

INSERT INTO Orders VALUES (1, 'Alice Smith', '2023-02-10', 1200.50, 'Shipped');
INSERT INTO Orders VALUES (2, 'Bob Johnson', '2023-04-15', 3100.75, 'Pending');
INSERT INTO Orders VALUES (3, 'Carol Williams', '2023-06-20', 980.10, 'Delivered');
INSERT INTO Orders VALUES (4, 'David Brown', '2023-07-12', 4500.60, 'Cancelled');
INSERT INTO Orders VALUES (5, 'Eve Jones', '2023-03-05', 700.00, 'Delivered');
INSERT INTO Orders VALUES (6, 'Frank Garcia', '2023-09-01', 1550.30, 'Pending');
INSERT INTO Orders VALUES (7, 'Grace Miller', '2023-10-10', 2000.00, 'Shipped');
INSERT INTO Orders VALUES (8, 'Henry Davis', '2023-11-11', 2500.25, 'Delivered');
INSERT INTO Orders VALUES (9, 'Ivy Martinez', '2023-05-17', 3200.00, 'Pending');
INSERT INTO Orders VALUES (10, 'Jack Rodriguez', '2023-08-30', 4100.80, 'Cancelled');
INSERT INTO Orders VALUES (11, 'Karen Martinez', '2023-12-01', 1250.60, 'Shipped');
INSERT INTO Orders VALUES (12, 'Leo Hernandez', '2023-01-15', 1100.20, 'Pending');
INSERT INTO Orders VALUES (13, 'Maria Lopez', '2023-03-25', 990.00, 'Delivered');
INSERT INTO Orders VALUES (14, 'Nina Gonzalez', '2023-04-22', 3100.90, 'Shipped');
INSERT INTO Orders VALUES (15, 'Oscar Wilson', '2023-07-03', 760.00, 'Cancelled');
INSERT INTO Orders VALUES (16, 'Paul Anderson', '2023-06-18', 1800.10, 'Pending');
INSERT INTO Orders VALUES (17, 'Queen Thomas', '2023-05-09', 2300.00, 'Shipped');
INSERT INTO Orders VALUES (18, 'Ray Taylor', '2023-02-25', 450.00, 'Delivered');
INSERT INTO Orders VALUES (19, 'Sara Moore', '2023-11-27', 2750.45, 'Shipped');
INSERT INTO Orders VALUES (20, 'Tom Jackson', '2023-10-15', 1600.30, 'Pending');

INSERT INTO Products VALUES (1, 'Widget A', 'Electronics', 299.99, 15);
INSERT INTO Products VALUES (2, 'Gadget B', 'Accessories', 49.99, 0);
INSERT INTO Products VALUES (3, 'Device C', 'Hardware', 199.99, 5);
INSERT INTO Products VALUES (4, 'Item D', 'Software', 99.99, 12);
INSERT INTO Products VALUES (5, 'Gear E', 'Tools', 89.49, 2);
INSERT INTO Products VALUES (6, 'Gizmo F', 'Electronics', 249.00, 20);
INSERT INTO Products VALUES (7, 'Widget G', 'Hardware', 150.75, 0);
INSERT INTO Products VALUES (8, 'Gadget H', 'Accessories', 75.25, 8);
INSERT INTO Products VALUES (9, 'Device I', 'Electronics', 120.00, 18);
INSERT INTO Products VALUES (10, 'Tool J', 'Tools', 49.95, 1);
INSERT INTO Products VALUES (11, 'Item K', 'Software', 79.99, 0);
INSERT INTO Products VALUES (12, 'Gadget L', 'Accessories', 55.55, 10);
INSERT INTO Products VALUES (13, 'Widget M', 'Electronics', 340.10, 3);
INSERT INTO Products VALUES (14, 'Gear N', 'Tools', 65.65, 7);
INSERT INTO Products VALUES (15, 'Device O', 'Hardware', 199.00, 9);
INSERT INTO Products VALUES (16, 'Gizmo P', 'Electronics', 230.45, 11);
INSERT INTO Products VALUES (17, 'Tool Q', 'Tools', 35.50, 0);
INSERT INTO Products VALUES (18, 'Item R', 'Software', 105.00, 4);
INSERT INTO Products VALUES (19, 'Gadget S', 'Accessories', 60.00, 2);
INSERT INTO Products VALUES (20, 'Widget T', 'Hardware', 180.80, 6);

--task1

select top 10 percent *
from Employees
order by Salary desc;

select Department, AVG(salary) as avg_salary 
from Employees
Group by Department;

SELECT 
    EmployeeID,
    FirstName,
    LastName,
    Department,
    Salary,
    CASE 
        WHEN Salary > 80000 THEN 'High'
        WHEN Salary BETWEEN 50000 AND 80000 THEN 'Medium'
        ELSE 'Low'
    END AS SalaryCategory
FROM Employees;

select Department, 
	AVG(salary) as avg_salary 
from Employees
group by Department
order by avg_salary desc;

select Department, 
	AVG(salary) as avg_salary 
from Employees
group by Department
order by avg_salary desc
offset 2 rows fetch next 5 rows only;

-- task 2
SELECT 
    CASE 
        WHEN Status = 'Delivered' OR Status = 'Shipped' THEN 'Completed'
        WHEN Status = 'Pending' THEN 'Pending'
        WHEN Status = 'Cancelled' THEN 'Cancelled'
    END AS OrderStatus,
    COUNT(*) AS TotalOrders,
    SUM(TotalAmount) AS TotalRevenue
FROM 
    Orders
WHERE 
    OrderDate BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY 
    CASE 
        WHEN Status = 'Delivered' OR Status = 'Shipped' THEN 'Completed'
        WHEN Status = 'Pending' THEN 'Pending'
        WHEN Status = 'Cancelled' THEN 'Cancelled'
    END
having SUM(TotalAmount)>5000
order by SUM(TotalAmount) desc

-- task 3
SELECT *
FROM (
    SELECT 
        Category,
        MAX(Price) AS Expensive,
        CASE
            WHEN MIN(Stock) = 0 THEN 'Out of Stock'
            WHEN MIN(Stock) < 10 THEN 'Low Stock'
            ELSE 'In Stock'
        END AS Inventory
    FROM Products
    GROUP BY Category
) AS Sub
ORDER BY Expensive DESC
OFFSET 1 ROWS FETCH NEXT 5 ROWS ONLY;








