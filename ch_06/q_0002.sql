USE TSQL2012;

-- 1
SELECT 1 AS n
UNION ALL SELECT 2
UNION ALL SELECT 3
UNION ALL SELECT 4
UNION ALL SELECT 5
UNION ALL SELECT 6
UNION ALL SELECT 7
UNION ALL SELECT 8
UNION ALL SELECT 9
UNION ALL SELECT 10;

SELECT n
FROM (VALUES(1), (2), (3), (4), (5), (6), (7), (8), (9), (10)) AS Nums(n);

-- 2
SELECT custid, empid
FROM Sales.Orders
WHERE orderdate BETWEEN '20080101' AND '20080201'

EXCEPT

SELECT custid, empid
FROM Sales.Orders
WHERE orderdate BETWEEN '20080201' AND '20080301';

-- 3
SELECT custid, empid
FROM Sales.Orders
WHERE orderdate BETWEEN '20080101' AND '20080201'

INTERSECT

SELECT custid, empid
FROM Sales.Orders
WHERE orderdate BETWEEN '20080201' AND '20080301';

-- 4
(SELECT custid, empid
FROM Sales.Orders
WHERE orderdate BETWEEN '20080101' AND '20080201'

INTERSECT

SELECT custid, empid
FROM Sales.Orders
WHERE orderdate BETWEEN '20080201' AND '20080301')

EXCEPT

SELECT custid, empid
FROM Sales.Orders
WHERE YEAR(orderdate) = 2007;

-- 5
SELECT
    country,
    region,
    city
FROM
    (SELECT
        1 AS Num,
        country,
        region,
        city
    FROM HR.Employees

    UNION ALL

    SELECT
        2,
        country,
        region,
        city
    FROM Production.Suppliers) AS S
ORDER BY Num, country, region, city;
