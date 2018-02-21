USE TSQL2012;

IF OBJECT_ID('dbo.Customers', 'U') IS NOT NULL
    DROP TABLE dbo.Customers;
GO

CREATE TABLE dbo.Customers
(
    custid      INT         NOT NULL,
    companyname VARCHAR(25) NOT NULL,
    phone       VARCHAR(20) NOT NULL,
    address     VARCHAR(50) NOT NULL,
    CONSTRAINT PK_Customers PRIMARY KEY(custid)
);

INSERT INTO dbo.Customers(custid, companyname, phone, address)
VALUES
    (1, 'cust 1', '(111) 111-1111', 'address 1'),
    (2, 'cust 2', '(222) 222-2222', 'address 2'),
    (3, 'cust 3', '(333) 333-3333', 'address 3'),
    (4, 'cust 4', '(444) 444-4444', 'address 4'),
    (5, 'cust 5', '(555) 555-5555', 'address 5');

IF OBJECT_ID('dbo.CustomersStage', 'U') IS NOT NULL
    DROP TABLE dbo.CustomersStage;
GO

CREATE TABLE dbo.CustomersStage
(
    custid      INT NOT NULL,
    companyname VARCHAR(25) NOT NULL,
    phone       VARCHAR(20) NOT NULL,
    address     VARCHAR(50) NOT NULL,
    CONSTRAINT PK_CustomersStage PRIMARY KEY(custid)
);

INSERT INTO dbo.CustomersStage(custid, companyname, phone, address)
VALUES
    (2, 'AAAAA',        '(222) 222-22222',  'address 2'),
    (3, 'cust 3',       '(333) 333-3333',   'address 3'),
    (5, 'BBBBB',        'CCCCC',            'DDDDD'),
    (6, 'cust 6 (new)', '(666) 666-6666',   'address 6'),
    (7, 'cust 7 (new)', '(777) 777-7777',   'address 7');

SELECT * FROM dbo.Customers;

SELECT * FROM dbo.CustomersStage;

MERGE INTO dbo.Customers AS Tgt
USING dbo.CustomersStage AS Src
    ON Tgt.custid = Src.custid
WHEN MATCHED THEN
    UPDATE SET
        Tgt.companyname = Src.companyname,
        Tgt.phone = Src.phone,
        Tgt.address = Src.address
WHEN NOT MATCHED THEN
    INSERT (custid, companyname, phone, address)
    VALUES (Src.custid, Src.companyname, Src.phone, Src.address);

SELECT * FROM dbo.Customers;

MERGE dbo.Customers AS Tgt
USING dbo.CustomersStage AS Src
    ON Tgt.custid = Src.custid
WHEN MATCHED THEN
    UPDATE SET
        Tgt.companyname = Src.companyname,
        Tgt.phone = Src.phone,
        Tgt.address = Src.address
WHEN NOT MATCHED THEN
    INSERT (custid, companyname, phone, address)
    VALUES (Src.custid, Src.companyname, Src.phone, Src.address)
WHEN NOT MATCHED BY SOURCE THEN
    DELETE;

SELECT * FROM dbo.Customers;

MERGE INTO dbo.Customers AS Tgt
USING dbo.CustomersStage AS Src
    ON Tgt.custid = Src.custid
WHEN MATCHED AND
    (Tgt.companyname <> Src.companyname
    OR Tgt.phone <> Src.phone
    OR Tgt.address <> Src.address) THEN
    UPDATE SET
        Tgt.companyname = Src.companyname,
        Tgt.phone = Src.phone,
        Tgt.address = Src.address
WHEN NOT MATCHED THEN
    INSERT (custid, companyname, phone, address)
    VALUES (Src.custid, Src.companyname, Src.phone, Src.address);
