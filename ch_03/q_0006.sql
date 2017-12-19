USE TSQL2012;

SELECT
    C.custid,
    C.companyname,
    O.orderid,
    OD.productid,
    OD.qty
FROM Sales.Customers AS C
  JOIN Sales.Orders AS O
    ON C.custid = O.custid
  JOIN Sales.OrderDetails AS OD
    ON O.orderid = OD.orderid;
