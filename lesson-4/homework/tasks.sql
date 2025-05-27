CREATE TABLE [dbo].[TestMultipleZero]
(
    [A] [int] NULL,
    [B] [int] NULL,
    [C] [int] NULL,
    [D] [int] NULL
);
GO

INSERT INTO [dbo].[TestMultipleZero](A,B,C,D)
VALUES 
    (0,0,0,1),
    (0,0,1,0),
    (0,1,0,0),
    (1,0,0,0),
    (0,0,0,0),
    (1,1,1,0);

select A, B, C, D

from TestMultipleZero
where A!=0 OR B<>0 OR c<>0 OR d<>0

CREATE TABLE TestMax
(
    Year1 INT
    ,Max1 INT
    ,Max2 INT
    ,Max3 INT
);
GO
 
INSERT INTO TestMax 
VALUES
    (2001,10,101,87)
    ,(2002,103,19,88)
    ,(2003,21,23,89)
    ,(2004,27,28,91);

select Max1, Max2, Max3,
case 
when max1>=max2 and max1>=max3 then max1
when max2>=max1 and max2>=max3 then max2
else max3
end as maxmax
from TestMax

CREATE TABLE EmpBirth
(
    EmpId INT  IDENTITY(1,1) 
    ,EmpName VARCHAR(50) 
    ,BirthDate DATETIME 
);
 
INSERT INTO EmpBirth(EmpName,BirthDate)
SELECT 'Pawan' , '12/04/1983'
UNION ALL
SELECT 'Zuzu' , '11/28/1986'
UNION ALL
SELECT 'Parveen', '05/07/1977'
UNION ALL
SELECT 'Mahesh', '01/13/1983'
UNION ALL
SELECT'Ramesh', '05/09/1983';

SELECT EmpId, EmpName, BirthDate
FROM EmpBirth
WHERE 
    MONTH(BirthDate) = 5 
    AND DAY(BirthDate) BETWEEN 7 AND 15;


create table letters
(letter char(1));

insert into letters
values ('a'), ('a'), ('a'), 
  ('b'), ('c'), ('d'), ('e'), ('f');

-- b first
select letter
from letters
order by case 
when letter='b' then 0
else 1
end, letter 

-- b last
select letter
from letters
order by case 
when letter='b' then 1
else 0
end, letter 
