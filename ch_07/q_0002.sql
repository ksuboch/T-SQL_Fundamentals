USE TSQL2012;

SELECT custid, orderid, val,
    LAG(val) OVER (PARTITION BY custid
                    ORDER BY orderdate, orderid) AS prevval,
    LEAD(val) OVER (PARTITION BY custid
                    ORDER BY orderdate, orderid) AS nextval
FROM Sales.OrderValues;

SELECT custid, orderid, val,
    FIRST_VALUE(val) OVER(PARTITION BY custid
                            ORDER BY orderdate, orderid
                            ROWS BETWEEN UNBOUNDED PRECEDING
                                AND CURRENT ROW) AS firstval,
    LAST_VALUE(val) OVER(PARTITION BY custid
                            ORDER BY orderdate, orderid
                            ROWS BETWEEN CURRENT ROW
                                AND UNBOUNDED FOLLOWING) AS lastval
FROM Sales.OrderValues
ORDER BY custid, orderdate, orderid;
