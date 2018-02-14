USE TSQL2012;

SELECT
    Cur.numcusts AS curnumcusts,
    Prv.numcusts AS prvnumcusts,
    Cur.numcusts - Prv.numcusts AS growth
FROM (SELECT
        YEAR(orderdate) AS orderyear,
        COUNT(DISTINCT custid) AS numcusts
      FROM Sales.Orders
      GROUP BY YEAR(orderdate)) AS Cur
    LEFT OUTER JOIN
      (SELECT
         YEAR(orderdate) AS orderyear,
         COUNT(DISTINCT custid) AS numcusts
       FROM Sales.Orders
       GROUP BY YEAR(orderdate)) AS Prv
    ON Cur.orderyear = Prv.orderyear + 1;
