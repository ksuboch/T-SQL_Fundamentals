USE TSQL2012;

SELECT DISTINCT
    empid,
    YEAR(orderdate) AS orderyear
FROM Sales.Orders
WHERE custid = 71;
