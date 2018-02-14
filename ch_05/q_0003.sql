USE TSQL2012;

DECLARE @empid AS INT = 3;

SELECT
    orderyear,
    COUNT(DISTINCT custid) AS numcusts
FROM
    (SELECT YEAR(orderdate) AS orderyear, custid
     FROM Sales.Orders
     WHERE empid = @empid) AS D
GROUP BY orderyear;
