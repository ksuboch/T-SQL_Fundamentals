USE TSQL2012;

SELECT
    S.shipperid,
    E.empid
FROM
    Sales.Shippers AS S
    CROSS APPLY HR.Employees AS E;

SELECT
    C.custid,
    A.orderid,
    A.orderdate
FROM Sales.Customers AS C
    CROSS APPLY
        (SELECT TOP(3)
            orderid,
            empid,
            orderdate,
            requireddate
         FROM Sales.Orders AS O
         WHERE O.custid = C.custid
         ORDER BY orderdate DESC, orderid DESC) AS A;

SELECT
    C.custid,
    A.orderid,
    A.orderdate
FROM Sales.Customers AS C
    OUTER APPLY
        (SELECT TOP(3)
            orderid,
            empid,
            orderdate,
            requireddate
         FROM Sales.Orders AS O
         WHERE O.custid = C.custid
         ORDER BY orderdate DESC, orderid DESC) AS A;
