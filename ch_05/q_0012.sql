USE TSQL2012;

IF OBJECT_ID('dbo.GetCustOrders') IS NOT NULL
    DROP FUNCTION dbo.GetCustOrders;
GO

CREATE FUNCTION dbo.GetCustOrders
    (@cid AS INT) RETURNS TABLE
AS
    RETURN
    SELECT
        orderid,
        custid,
        empid,
        orderdate,
        requireddate,
        shippeddate,
        shipperid,
        freight,
        shipname,
        shipaddress,
        shipcity,
        shipregion,
        shippostalcode,
        shipcountry
    FROM Sales.Orders
    WHERE custid = @cid;
GO

SELECT
    orderid,
    custid
FROM dbo.GetCustOrders(1) AS O

SELECT
    O.orderid,
    O.custid,
    OD.productid,
    OD.qty
FROM dbo.GetCustOrders(1) AS O
    JOIN Sales.OrderDetails AS OD
        ON O.orderid = OD.orderid

IF OBJECT_ID('dbo.GetCustOrders') IS NOT NULL
    DROP FUNCTION dbo.GetCustOrders;
