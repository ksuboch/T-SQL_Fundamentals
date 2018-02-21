USE TSQL2012;

-- 1
IF OBJECT_ID('dbo.Customers', 'U') IS NOT NULL
    DROP TABLE dbo.Customers;

CREATE TABLE dbo.Customers
(
    custid INT NOT NULL PRIMARY KEY,
    companyname NVARCHAR(40) NOT NULL,
    country NVARCHAR(15) NOT NULL,
    region NVARCHAR(15) NULL,
    city NVARCHAR(15) NOT NULL
);

-- 1-1
INSERT INTO dbo.Customers
    (custid, companyname, country, region, city)
VALUES
    (100, N'Рога и копыта', N'США', N'WA', N'Редмонд');

-- 1-2
SELECT custid, companyname, country, region, city
INTO dbo.Customers
FROM Sales.Customers;

-- 1-3
IF OBJECT_ID('dbo.Orders', 'U') IS NOT NULL
    DROP TABLE dbo.Orders;

SELECT *
INTO dbo.Orders
FROM Sales.Orders
WHERE YEAR(orderdate) BETWEEN 2006 AND 2008;

-- 2
DELETE FROM dbo.Orders
    OUTPUT
        deleted.orderid,
        deleted.orderdate
WHERE orderdate < '20060801';

-- 3
DELETE FROM O
    FROM dbo.Orders AS O
    JOIN dbo.Customers AS C
    ON O.custid = C.custid
WHERE C.country = N'Бразилия'

DELETE FROM dbo.Orders
    WHERE EXISTS
    (SELECT *
FROM dbo.Customers
WHERE Orders.custid = Customers.custid
    AND Customers.country = N'Бразилия')

MERGE INTO dbo.Orders AS O
USING dbo.Customers AS C
    ON O.custid = C.custid
    AND country = N'Бразилия'
WHEN MATCHED THEN DELETE;

-- 4
SELECT *
FROM dbo.Customers;

UPDATE dbo.Customers
    SET region = N'<None>'
OUTPUT
    inserted.custid,
    deleted.region AS oldregion,
    deleted.region AS newregion
WHERE region IS NULL;

-- 5
UPDATE dbo.Orders
    SET shipcountry = C.country,
        shipregion  = C.region,
        shipcity    = C.city
    FROM dbo.Orders AS O
    JOIN dbo.Customers AS C
    ON O.custid = C.custid
WHERE C.country = N'Великобритания';

WITH
    CTE_UPD
    AS
    (
        SELECT
            O.shipcountry AS ocountry,
            O.shipregion  AS oregion,
            O.shipcity    AS ocity,
            C.country AS ccountry,
            C.region  AS cregion,
            C.city    AS ccity
        FROM dbo.Orders AS O
            JOIN dbo.Customers AS C
            ON O.custid = C.custid
        WHERE C.country = N'Великобритания'
    )
UPDATE CTE_UPD
    SET ocountry = ccountry, oregion = cregion, ocity = ccity;

MERGE INTO dbo.Orders AS O
USING dbo.Customers AS C
    ON O.custid = C.custid
    AND C.country = N'Великобритания'
WHEN MATCHED THEN
    UPDATE SET  shipcountry = C.country,
                shipregion  = C.region,
                shipcity    = C.city;

IF OBJECT_ID('dbo.Orders', 'U') IS NOT NULL
    DROP TABLE dbo.Orders;

IF OBJECT_ID('dbo.Customers', 'U') IS NOT NULL
    DROP TABLE dbo.Customers;
