-- 1. Testing delete, truncate, drop
CREATE TABLE test_identity (
    id INT IDENTITY(1,1),
    name NVARCHAR(50)
);

INSERT INTO test_identity (name)
VALUES ('A'), ('B'), ('C'), ('D'), ('E');

SELECT * FROM test_identity;

-- DELETE test
DELETE FROM test_identity;
INSERT INTO test_identity (name) VALUES ('F');  -- ID continues (6)

-- TRUNCATE test
TRUNCATE TABLE test_identity;
INSERT INTO test_identity (name) VALUES ('G');  -- ID resets to 1

-- DROP test
DROP TABLE test_identity;

-- common data types
CREATE TABLE data_types_demo (
    int_col INT,
    decimal_col DECIMAL(10,2),
    float_col FLOAT,
    date_col DATE,
    time_col TIME,
    datetime_col DATETIME,
    char_col CHAR(10),
    varchar_col VARCHAR(50),
    bit_col BIT
);

INSERT INTO data_types_demo
VALUES (10, 123.45, 3.14159, '2023-01-01', '12:30:00', '2023-01-01 12:30:00', 'X', 'Hello SQL', 1);

SELECT * FROM data_types_demo;

-- 3. working with image
CREATE TABLE photos (
    id INT IDENTITY(1,1),
    image VARBINARY(MAX)
);

INSERT INTO photos (image)
SELECT * FROM OPENROWSET(BULK 'C:\path\to\image.jpg', SINGLE_BLOB) AS img;

-- Compute total
CREATE TABLE student (
    name NVARCHAR(50),
    classes INT,
    tuition_per_class DECIMAL(10,2),
    total_tuition AS classes * tuition_per_class
);

INSERT INTO student (name, classes, tuition_per_class)
VALUES ('Ali', 4, 100), ('Sara', 3, 120), ('Zaid', 5, 90);

SELECT * FROM student;


-- CV to SQL server
CREATE TABLE worker (
    id INT,
    name NVARCHAR(50)
);

BULK INSERT worker
FROM 'C:\Users\VICTUS\Desktop\SQL\lesson-2\homework\cv_to_sql.cv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);

SELECT * FROM worker;
