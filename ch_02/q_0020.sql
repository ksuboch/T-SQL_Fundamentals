USE TSQL2012;

SELECT
    orderid,
    custid,
    empid,
    orderdate
FROM
    Sales.Orders
WHERE
    orderdate = '20070212';

SELECT
    orderid,
    custid,
    empid,
    orderdate
FROM
    Sales.Orders
WHERE
    orderdate = CAST('20070212' AS DATETIME);

SET LANGUAGE Russian;
SELECT CAST('02/12/2007' AS DATETIME);

SET LANGUAGE us_english;
SELECT CAST('02/12/2007' AS DATETIME);

SET LANGUAGE Russian;
SELECT CAST('20070212' AS DATETIME);

SET LANGUAGE us_english;
SELECT CAST('20070212' AS DATETIME);

SELECT CONVERT(DATETIME, '02/12/2007', 101); --mm/dd/yyyy

SELECT CONVERT(DATETIME, '02/12/2007', 103); --dd/mm/yyyy

SELECT PARSE('02/12/2007' AS DATETIME USING 'en-GB'); --MS SQL Server 2012

SELECT
    orderid,
    custid,
    empid,
    orderdate
FROM
    Sales.Orders
WHERE
    orderdate >= '20070212'
    AND orderdate < '20070213';

SELECT CAST('12:30:15.123' AS DATETIME);

SELECT
    orderid,
    custid,
    empid,
    orderdate
FROM
    Sales.Orders
WHERE
    YEAR(orderdate) = 2007
    AND MONTH(orderdate) = 2;
