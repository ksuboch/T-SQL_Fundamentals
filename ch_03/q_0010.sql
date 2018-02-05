USE TSQL2012;

SELECT
    C.custid,
    O.orderid,
    OD.productid,
    OD.qty
FROM Sales.Customers AS C
    LEFT OUTER JOIN Sales.Orders AS O
        ON C.custid = O.custid
    JOIN Sales.OrderDetails AS OD
        ON O.orderid = OD.orderid

SELECT
    C.custid,
    O.orderid,
    OD.productid,
    OD.qty
FROM Sales.Orders AS O
    JOIN Sales.OrderDetails AS OD
        ON O.orderid = OD.orderid
    RIGHT OUTER JOIN Sales.Customers AS C
        ON O.custid = C.custid;

SELECT
    C.custid,
    O.orderid,
    OD.productid,
    OD.qty
FROM Sales.Customers AS C
    LEFT OUTER JOIN
        (Sales.Orders AS O
            JOIN Sales.OrderDetails AS OD
                ON O.orderid = OD.orderid)
        ON C.custid = O.custid;
