-- 1. NOT NULL Constraint
CREATE TABLE student (
    id INT,
    name VARCHAR(255),
    age INT
);

ALTER TABLE student
MODIFY id INT NOT NULL;

-- 2. UNIQUE Constraint
CREATE TABLE product (
    product_id INT UNIQUE,
    product_name VARCHAR(255),
    price DECIMAL(10, 2)
);

ALTER TABLE product
DROP INDEX product_id;

ALTER TABLE product
ADD UNIQUE (product_id);

ALTER TABLE product
ADD CONSTRAINT unique_product_productname UNIQUE (product_id, product_name);

-- 3. PRIMARY KEY Constraint
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(255),
    order_date DATE
);

ALTER TABLE orders
DROP PRIMARY KEY;

ALTER TABLE orders
ADD PRIMARY KEY (order_id);

-- 4. FOREIGN KEY Constraint
CREATE TABLE category (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(255)
);

CREATE TABLE item (
    item_id INT PRIMARY KEY,
    item_name VARCHAR(255),
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES category(category_id)
);

ALTER TABLE item
DROP FOREIGN KEY item_ibfk_1;

ALTER TABLE item
ADD CONSTRAINT fk_item_category
FOREIGN KEY (category_id) REFERENCES category(category_id);

-- 5. CHECK Constraint
CREATE TABLE account (
    account_id INT PRIMARY KEY,
    balance DECIMAL(10,2) CHECK (balance >= 0),
    account_type VARCHAR(20) CHECK (account_type IN ('Saving', 'Checking'))
);

ALTER TABLE account
DROP CHECK balance;

ALTER TABLE account
ADD CONSTRAINT chk_balance CHECK (balance >= 0);

ALTER TABLE account
DROP CHECK account_type;

ALTER TABLE account
ADD CONSTRAINT chk_account_type CHECK (account_type IN ('Saving', 'Checking'));

-- 6. DEFAULT Constraint
CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    name VARCHAR(255),
    city VARCHAR(255) DEFAULT 'Unknown'
);


ALTER TABLE customer
ALTER COLUMN city DROP DEFAULT;

ALTER TABLE customer
ALTER COLUMN city SET DEFAULT 'Unknown';

-- 7. IDENTITY Column (Auto-Increment)
CREATE TABLE invoice (
    invoice_id INT AUTO_INCREMENT PRIMARY KEY,
    amount DECIMAL(10,2)
);

INSERT INTO invoice (amount) VALUES (100.00), (200.00), (300.00), (400.00), (500.00);

-- For MySQL: Direct insert (no SET IDENTITY_INSERT)
INSERT INTO invoice (invoice_id, amount) VALUES (100, 999.99);

-- 8. All at once - books table
CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) CHECK (price > 0),
    genre VARCHAR(255) DEFAULT 'Unknown'
);

INSERT INTO books (title, price, genre) VALUES ('Book A', 15.50, 'Fiction');
INSERT INTO books (title, price) VALUES ('Book B', 20.00);

-- 9. Library Management System
CREATE TABLE book (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255),
    author VARCHAR(255),
    published_year INT
);

CREATE TABLE member (
    member_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    email VARCHAR(255),
    phone_number VARCHAR(50)
);

CREATE TABLE loan (
    loan_id INT PRIMARY KEY AUTO_INCREMENT,
    book_id INT,
    member_id INT,
    loan_date DATE,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (member_id) REFERENCES member(member_id)
);

INSERT INTO book (title, author, published_year) VALUES
('The Alchemist', 'Paulo Coelho', 1988),
('1984', 'George Orwell', 1949),
('The Hobbit', 'J.R.R. Tolkien', 1937);

INSERT INTO member (name, email, phone_number) VALUES
('Alice', 'alice@example.com', '123-456-7890'),
('Bob', 'bob@example.com', '234-567-8901');

INSERT INTO loan (book_id, member_id, loan_date, return_date) VALUES
(1, 1, '2025-04-01', '2025-04-10'),
(2, 1, '2025-04-02', NULL),
(3, 2, '2025-04-03', NULL);
