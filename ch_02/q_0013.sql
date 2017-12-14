USE TSQL2012;

SELECT
    orderid,
    empid,
    orderdate
FROM Sales.Orders
WHERE
    orderid IN(10248, 10249, 10250);

SELECT
    orderid,
    empid,
    orderdate
FROM Sales.Orders
WHERE
    orderid BETWEEN 10300 AND 10310;

SELECT
    empid,
    firstname,
    lastname
FROM HR.Employees
WHERE
    lastname LIKE N'Д%';

SELECT
    orderid,
    empid,
    orderdate
FROM Sales.Orders
WHERE orderdate >= '20080101';

SELECT
    orderid,
    empid,
    orderdate
FROM Sales.Orders
WHERE orderdate >= '20080101'
    AND empid IN(1, 3, 5);

SELECT
    orderid,
    productid,
    qty,
    unitprice,
    discount,
    qty * unitprice * (1 - discount) AS val
FROM Sales.OrderDetails;

SELECT
    orderid,
    custid,
    empid,
    orderdate
FROM Sales.Orders
WHERE
    (custid = 1
        AND empid IN(2, 4, 5))
    OR
    (custid = 85
        AND empid IN(2, 4, 6));
