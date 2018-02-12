USE TSQL2012;

SELECT
    companyname,
    custid
FROM
    Sales.Customers AS C
WHERE
    country = N'Испания'
    AND EXISTS
    (SELECT * FROM Sales.Orders AS O
    WHERE O.custid = C.custid);

SELECT
    companyname,
    custid
FROM
    Sales.Customers AS C
WHERE
    country = N'Испания'
    AND NOT EXISTS
        (SELECT * FROM Sales.Orders AS O
        WHERE O.custid = C.custid);
