USE TSQL2012;

SELECT
    orderid,
    orderdate,
    custid,
    empid
FROM Sales.Orders
ORDER BY
    orderdate,
    orderid
OFFSET 50 ROWS      -- ROW/ROWS
FETCH NEXT 25 ROWS  -- NEXT/FIRST and ROW/ROWS
ONLY;
