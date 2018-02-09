USE TSQL2012;

SELECT
    C.custid,
    COUNT(*) AS numorders
FROM Sales.Customers AS C
    LEFT OUTER JOIN Sales.Orders AS O
        ON C.custid = o.custid
GROUP BY C.custid

SELECT
    C.custid,
    COUNT(O.orderid) AS numorders
FROM Sales.Customers AS C
    LEFT OUTER JOIN Sales.Orders AS O
        ON C.custid = o.custid
GROUP BY C.custid
