USE TSQL2012;

SELECT orderid, custid, val,
    SUM(val) OVER() AS totalvalue,
    SUM(val) OVER(PARTITION BY custid) AS custtotalvalue
FROM Sales.OrderValues;

SELECT orderid, custid, val,
    100. * val / SUM(val) OVER() AS pctall,
    100. * val / SUM(val) OVER(PARTITION BY custid) AS pctcust
FROM Sales.OrderValues;

SELECT empid, ordermonth, val,
    SUM(val) OVER(PARTITION BY empid
                    ORDER BY ordermonth
                    ROWS BETWEEN UNBOUNDED PRECEDING
                        AND CURRENT ROW) AS runval
FROM Sales.EmpOrders;
