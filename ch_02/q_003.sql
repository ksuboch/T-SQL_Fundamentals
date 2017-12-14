USE TSQL2012;

SELECT
    orderid,
    empid,
    orderdate,
    freight
FROM
    Sales.Orders
WHERE
    custid = 71;
