USE TSQL2012;

--1
SELECT
    E.empid,
    E.lastname,
    N.n
FROM
    HR.Employees AS E
        CROSS JOIN dbo.Nums AS N
WHERE
    N.n <= 5
ORDER BY
    N.n, E.empid;

--1-2
SELECT
    E.empid,
    DATEADD(day, N.n, '20090611') AS dt
FROM
    HR.Employees AS E
        CROSS JOIN dbo.Nums AS N
WHERE
    N.n <= DATEDIFF(day, '20090612', '20090616') + 1
ORDER BY
    E.empid, dt;

--2
SELECT
    C.custid,
    COUNT(DISTINCT O.orderid) AS numorders,
    SUM(OD.qty) AS totalqty
FROM
    Sales.Customers AS C
    JOIN Sales.Orders AS O
        ON C.custid = O.custid
    JOIN Sales.OrderDetails AS OD
        ON O.orderid = OD.orderid
WHERE
    C.country = 'США'
GROUP BY
    C.custid
ORDER BY
    C.custid;

--3
SELECT
    C.custid,
    C.companyname,
    O.orderid,
    O.orderdate
FROM
    Sales.Customers AS C
    LEFT OUTER JOIN Sales.Orders AS O
        ON C.custid = O.custid;

--4
SELECT
    C.custid,
    C.companyname,
    O.orderid,
    O.orderdate
FROM
    Sales.Customers AS C
    LEFT OUTER JOIN Sales.Orders AS O
        ON C.custid = O.custid
WHERE
    O.orderid IS NULL;

--5
SELECT
    C.custid,
    C.companyname,
    O.orderid,
    O.orderdate
FROM
    Sales.Customers AS C
    JOIN Sales.Orders AS O
        ON C.custid = O.custid
WHERE
    O.orderdate = '20070212';

--6
SELECT
    C.custid,
    C.companyname,
    O.orderid,
    O.orderdate
FROM
    Sales.Customers AS C
    LEFT OUTER JOIN Sales.Orders AS O
        ON C.custid = O.custid AND O.orderdate = '20070212';

--7
SELECT
    C.custid,
    C.companyname,
    CASE COUNT(O.orderid)
        WHEN 0
            THEN 'No'
            ELSE 'Yes'
    END AS HasOrderOn20070212
FROM
    Sales.Customers AS C
    LEFT JOIN Sales.Orders AS O
        ON C.custid = O.custid AND O.orderdate = '20070212'
GROUP BY
    C.custid,
    C.companyname;

SELECT DISTINCT
    C.custid,
    C.companyname,
    CASE
        WHEN O.orderid IS NOT NULL
        THEN 'yes'
        ELSE 'no'
    END AS HasOrderOn20070212
FROM Sales.Customers AS C
    LEFT OUTER JOIN Sales.Orders AS O
        ON O.custid = C.custid
        AND O.orderdate = '20070212';
