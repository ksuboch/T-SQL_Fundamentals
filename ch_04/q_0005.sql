USE TSQL2012;

SELECT
    orderid,
    orderdate,
    empid,
    custid,
    (SELECT MAX(O2.orderid)
     FROM Sales.Orders AS O2
     WHERE O2.orderid < O1.orderid) AS prevorderid
FROM
    Sales.Orders AS O1;


SELECT
    orderid,
    orderdate,
    empid,
    custid,
    (SELECT MIN(O2.orderid)
     FROM Sales.Orders AS O2
     WHERE O2.orderid  > O1.orderid) AS nextorderid
    FROM Sales.Orders AS O1;
