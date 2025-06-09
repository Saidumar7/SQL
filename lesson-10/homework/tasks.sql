
WITH AllShipments AS (
    SELECT Num FROM Shipments
    UNION ALL
    SELECT 0 FROM (VALUES (1),(2),(3),(4),(5),(6),(7),(8)) AS zeros(dummy)
),
Ordered AS (
    SELECT Num,
           ROW_NUMBER() OVER (ORDER BY Num) AS rn
    FROM AllShipments
),
Counted AS (
    SELECT COUNT(*) AS total FROM AllShipments
),
MedianVals AS (
    SELECT o.Num
    FROM Ordered o
    CROSS JOIN Counted c
    WHERE o.rn = c.total / 2 OR o.rn = c.total / 2 + 1
)
SELECT AVG(1.0 * Num) AS Median
FROM MedianVals;
