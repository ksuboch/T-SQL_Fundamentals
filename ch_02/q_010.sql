USE TSQL2012;

SELECT TOP(5)
    orderid,
    orderdate,
    custid,
    empid
FROM Sales.Orders
ORDER BY orderdate DESC;

SELECT TOP (1) PERCENT
    orderid,
    orderdate,
    custid,
    empid
FROM Sales.Orders
ORDER BY orderdate DESC;
