USE TSQL2012;

--1
SELECT
    orderid,
    orderdate,
    custid,
    empid
FROM
    Sales.Orders
WHERE
    orderdate BETWEEN DATEFROMPARTS(2007, 06, 01) AND DATEFROMPARTS(2007, 06, 30);

--2
SELECT
    orderid,
    orderdate,
    custid,
    empid
FROM
    Sales.Orders
WHERE
    orderdate = EOMONTH(orderdate);

--3
SELECT
    empid,
    firstname,
    lastname
FROM
    HR.Employees
WHERE lastname LIKE '%о%о%';

--4
SELECT
    orderid,
    SUM(unitprice * qty) AS totalvalue
FROM
    Sales.OrderDetails
GROUP BY
    orderid
HAVING
    SUM(unitprice * qty) > 10000
ORDER BY
    totalvalue DESC;

--5
SELECT TOP(3)
    shipcountry,
    AVG(freight) AS avgfreight
FROM
    Sales.Orders
WHERE
    orderdate BETWEEN '20070101' AND '20071231'
GROUP BY
    shipcountry
ORDER BY
    avgfreight DESC;

SELECT
    shipcountry,
    AVG(freight) AS avgfreight
FROM
    Sales.Orders
WHERE
    orderdate BETWEEN '20070101' AND '20071231'
GROUP BY
    shipcountry
ORDER BY
    avgfreight DESC
OFFSET 0 ROWS FETCH FIRST 3 ROWS ONLY;

--6
SELECT
    custid,
    orderdate,
    orderid,
    ROW_NUMBER() OVER (PARTITION BY custid ORDER BY orderdate, orderid) AS rownum
FROM
    Sales.Orders
ORDER BY
    custid,
    rownum;

--7
SELECT
    empid,
    firstname,
    lastname,
    titleofcourtesy,
    CASE
        WHEN titleofcourtesy IN ('мисс', 'миссис')  THEN 'женщина'
        WHEN titleofcourtesy = 'мистер'             THEN 'мужчина'
        ELSE                                             'неизвестно'
    END AS gender
FROM
    HR.Employees
ORDER BY
    empid;

--8
SELECT
    custid,
    region
FROM
    Sales.Customers
ORDER BY
    CASE WHEN region IS NULL
        THEN 1
        ELSE 0
    END,
    region;
