USE TSQL2012;

SELECT
    orderid,
    custid,
    val,
    ROW_NUMBER() OVER (PARTITION BY custid
                        ORDER BY val) AS rownum
FROM Sales.OrderValues
ORDER BY
    custid,
    val;
