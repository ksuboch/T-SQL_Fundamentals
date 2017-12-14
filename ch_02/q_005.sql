USE TSQL2012;

SELECT
  empid,
  YEAR(orderdate) AS orderyear,
  SUM(freight) AS totalfreight,
  COUNT(*) AS numorders
FROM Sales.Orders
WHERE
  custid = 71
GROUP BY
  empid,
  YEAR(orderdate);
