USE TSQL2012;

-- 1
SELECT
    orderid,
    orderdate,
    custid,
    empid
FROM Sales.Orders
WHERE orderdate = (SELECT MAX(orderdate) FROM Sales.Orders);

-- 2
SELECT
    custid,
    orderid,
    orderdate,
    empid
FROM
    Sales.Orders
WHERE custid IN (
    SELECT custid
    FROM Sales.Orders
    GROUP BY custid
    HAVING COUNT(orderid) = (
        SELECT TOP 1
            COUNT(orderid) AS cnt
        FROM Sales.Orders
        GROUP BY custid
        ORDER BY cnt DESC
        )
    );

SELECT
    custid,
    orderid,
    orderdate,
    empid
FROM
    Sales.Orders
WHERE
    custid IN
    (SELECT TOP (1) WITH TIES
        custid
    FROM
        Sales.Orders
    GROUP BY
        custid
    ORDER BY
        COUNT(*) DESC);

-- 3
SELECT
    empid,
    firstname,
    lastname
FROM
    HR.Employees
WHERE
    empid NOT IN (
        SELECT DISTINCT
            empid
        FROM
            Sales.Orders
        WHERE orderdate >= '20080501'
    );

-- 4
SELECT DISTINCT
    country
FROM
    Sales.Customers
WHERE
    country NOT IN (
        SELECT DISTINCT
            country
        FROM
            HR.Employees
    );

-- 5
SELECT
    o1.custid,
    o1.orderdate,
    o1.empid
FROM
    Sales.Orders o1
WHERE
    o1.orderdate = (
        SELECT
            MAX(orderdate)
        FROM
            Sales.Orders o2
        WHERE
            o2.custid = o1.custid
    );

-- 6
SELECT
    custid,
    companyname
FROM
    Sales.Customers
WHERE
    custid IN (
        SELECT DISTINCT
            custid
        FROM
            Sales.Orders
        WHERE
            orderdate BETWEEN '20070101' AND '20080101'
    )
    AND
    custid NOT IN (
        SELECT DISTINCT
            custid
        FROM
            Sales.Orders
        WHERE
            orderdate >= '20080101'
    );

SELECT
    c.custid,
    c.companyname
FROM
    Sales.Customers c
WHERE EXISTS
    (SELECT *
    FROM Sales.Orders o
    WHERE o.custid = c.custid
        AND o.orderdate BETWEEN '20070101' AND '20080101')
    AND NOT EXISTS
    (SELECT *
    FROM Sales.Orders o
    WHERE o.custid = c.custid
        AND o.orderdate BETWEEN '20080101' AND '20090101');

-- 7
SELECT
    custid,
    companyname
FROM
    Sales.Customers
WHERE
    custid IN (
        SELECT DISTINCT
            custid
        FROM
            Sales.Orders
        WHERE
            orderid IN (
                SELECT DISTINCT
                    orderid
                FROM
                    Sales.OrderDetails
                WHERE
                    productid = 12
            )
    );

SELECT
    custid,
    companyname
FROM
    Sales.Customers c
WHERE EXISTS
    (SELECT *
    FROM Sales.Orders o
    WHERE o.custid = c.custid
        AND EXISTS
        (SELECT *
        FROM Sales.OrderDetails od
        WHERE od.orderid = o.orderid
            AND od.productid = 12));

-- 8
SELECT
    co1.custid,
    co1.ordermonth,
    co1.qty,
    (
        SELECT
            SUM(qty)
        FROM
            Sales.CustOrders co2
        WHERE
            co2.custid = co1.custid
            AND co2.ordermonth <= co1.ordermonth
    ) runqty
FROM
    Sales.CustOrders co1
ORDER BY
    co1.custid,
    co1.ordermonth;
