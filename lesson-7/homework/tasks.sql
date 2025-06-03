drop table if exists Customers
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);
drop table if exists Orders
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE
);
drop table if exists OrderDetails
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10,2)
);
drop table if exists Products
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50)
);

INSERT INTO Customers (CustomerID, CustomerName) VALUES
(1, 'Alice Johnson'),
(2, 'Bob Smith'),
(3, 'Charlie Davis'),
(4, 'Diana Prince'),
(5, 'Ethan Hunt'),
(6, 'Fatima Noor'),
(7, 'George Martin'),
(8, 'Hannah Lee'),
(9, 'Ibrahim Khan'),
(10, 'Julia Roberts'),
(11, 'Kevin Hart'),         -- No order
(12, 'Lina Alami'),         -- No order
(13, 'Mohammed Zidan');     -- No order


INSERT INTO Products (ProductID, ProductName, Category) VALUES
(1, 'Laptop', 'Electronics'),
(2, 'Smartphone', 'Electronics'),
(3, 'Desk Chair', 'Furniture'),
(4, 'Notebook', 'Stationery'),
(5, 'Pen Set', 'Stationery'),
(6, 'Water Bottle', 'Accessories'),
(7, 'Backpack', 'Accessories'),
(8, 'Monitor', 'Electronics'),
(9, 'Keyboard', 'Electronics'),
(10, 'Mouse', 'Electronics'),
(11, 'Lamp', 'Furniture'),         -- Not used in any orders
(12, 'Drawing Tablet', 'Electronics'); -- Not used in any orders

INSERT INTO Orders (OrderID, CustomerID, OrderDate) VALUES 

(1, 1, '2024-06-01'),
(2, 2, '2024-06-02'),
(3, 3, '2024-06-02'),
(4, 4, '2024-06-03'),
(5, 5, '2024-06-04'),
(6, 6, '2024-06-11'),
(7, 7, '2024-06-05'),
(8, 8, '2024-06-05'),
(9, 9, '2024-06-06'),
(10, 10, '2024-06-06'),
(11, 11, '2024-06-02'),
(12, 11, '2024-06-01');
-- No orders for CustomerID 12, 13

INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity, Price) VALUES
(1, 1, 1, 1, 1200.00),
(2, 1, 2, 2, 800.00),
(3, 2, 3, 1, 150.00),
(4, 3, 4, 10, 2.50),
(5, 4, 5, 5, 1.75),
(6, 5, 6, 2, 12.00),
(7, 6, 7, 1, 30.00),
(8, 7, 8, 1, 250.00),
(9, 8, 9, 1, 45.00),
(10, 9, 10, 2, 25.00),
(11, 10, 1, 1, 1200.00),
(12, 10, 9, 1, 45.00);


-- 1
select c.CustomerName, o.OrderID, o.OrderDate
from Customers c left join Orders o on c.CustomerID = o.CustomerID
order by o.OrderDate

-- 2
select c.CustomerName, o.OrderID, o.OrderDate
from Customers c left join Orders o on c.CustomerID = o.CustomerID
where o.OrderID is null

-- 3
select d.OrderID, p.ProductName, d.Quantity
from Products p join OrderDetails d on p.ProductID = d.ProductID

--4
SELECT c.CustomerID, c.CustomerName, COUNT(o.OrderID) AS OrderCount
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CustomerName
HAVING COUNT(o.OrderID) > 1;

-- 5 
SELECT od.OrderID, od.ProductID, p.ProductName, od.Price
FROM OrderDetails od JOIN Products p ON od.ProductID = p.ProductID
WHERE od.Price = (
    SELECT MAX(Price)
    FROM OrderDetails
    WHERE OrderID = od.OrderID)
order by od.OrderID

-- 6
select o.CustomerID, o.OrderID, o.OrderDate
from Orders o
where o.OrderDate = (
select max(OrderDate)
from orders where CustomerID = o.CustomerID)

-- 7
select c.CustomerName, p.ProductName
from Customers c join Orders o on c.CustomerID = o.CustomerID join OrderDetails d on o.OrderID = d.OrderID join Products p on d.ProductID = p.ProductID  
where p.Category = 'Electronics'

-- 8
select distinct c.CustomerID, c.CustomerName, p.ProductName
from Customers c join Orders o on c.CustomerID = o.CustomerID join OrderDetails d on o.OrderID = d.OrderID join Products p on d.ProductID = p.ProductID  
where p.Category = 'Stationery'

-- 9
select c.CustomerID, c.CustomerName , sum(d.Price*d.Quantity) as TotalSpent
from Customers c join Orders o on c.CustomerID = o.CustomerID join OrderDetails d on o.OrderID = d.OrderID 
group by c.CustomerID, c.CustomerName