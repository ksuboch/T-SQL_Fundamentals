USE TSQL2012;

SELECT *
FROM dbo.EmpCloseOrders
    CROSS JOIN (VALUES('A'),
        ('B'),
        ('C'),
        ('D')) AS Custs(cutid);

SELECT *
FROM (SELECT empid, custid,
        CASE custid
        WHEN 'A' THEN A
        WHEN 'B' THEN B
        WHEN 'C' THEN C
        WHEN 'D' THEN D
    END AS qty
    FROM dbo.EmpCloseOrders
    CROSS JOIN (VALUES('A'),
            ('B'),
            ('C'),
            ('D')) AS Custs(custid)) AS D
WHERE qty IS NOT NULL;

SELECT empid, custid, qty
FROM dbo.EmpCloseOrders
    UNPIVOT(qty FOR custid IN(A, B, C, D)) AS U;

IF OBJECT_ID('dbo.EmpCloseOrders', 'U') IS NOT NULL
    DROP TABLE dbo.EmpCloseOrders;
