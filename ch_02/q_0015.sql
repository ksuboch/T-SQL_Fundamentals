USE TSQL2012;

SELECT
    custid,
    country,
    region,
    city
FROM Sales.Customers
WHERE region = N'WA';

SELECT
    custid,
    country,
    region,
    city
FROM Sales.Customers
WHERE region <> N'WA';

SELECT
    custid,
    country,
    region,
    city
FROM Sales.Customers
WHERE region = NULL;

SELECT
    custid,
    country,
    region,
    city
FROM Sales.Customers
WHERE region IS NULL;
