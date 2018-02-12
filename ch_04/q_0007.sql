USE TSQL2012;

SELECT
    custid,
    companyname
FROM
    Sales.Customers
WHERE
    custid NOT IN (SELECT O.custid
                   FROM Sales.Orders AS O);

INSERT INTO Sales.Orders
    (custid, empid, orderdate, requireddate, shippeddate,
     shipperid, freight, shipname, shipaddress, shipcity,
     shipregion, shippostalcode, shipcountry)
    VALUES(NULL, 1, '20090212', '20090212',
           '20090212', 1, 123.00, N'abc', N'abc', N'abc',
           N'abc', N'abc', N'abc');

SELECT
    custid,
    companyname
FROM
    Sales.Customers
WHERE
    custid NOT IN (SELECT O.custid
                   FROM Sales.Orders AS O
                   WHERE O.custid IS NOT NULL);

SELECT
    custid,
    companyname
FROM
    Sales.Customers AS C
WHERE NOT EXISTS
    (SELECT *
     FROM Sales.Orders AS O
     WHERE O.custid = C.custid);

DELETE FROM Sales.Orders WHERE custid IS NULL;
