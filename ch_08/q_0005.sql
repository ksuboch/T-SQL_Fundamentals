USE TSQL2012;

IF OBJECT_ID('dbo.T1', 'U') IS NOT NULL
    DROP TABLE dbo.T1;

CREATE TABLE dbo.T1
(
    keycol INT NOT NULL IDENTITY(1, 1)
        CONSTRAINT PK_T1 PRIMARY KEY,
    datacol VARCHAR(10) NOT NULL
        CONSTRAINT CHK_T1_datacol CHECK(datacol LIKE '[A-Za-z]%')
);

INSERT INTO dbo.T1(datacol) VALUES('AAAAA');
INSERT INTO dbo.T1(datacol) VALUES('CCCCC');
INSERT INTO dbo.T1(datacol) VALUES('BBBBB');

SELECT * FROM dbo.T1;

SELECT $identity FROM dbo.T1;

DECLARE @new_key AS INT;

INSERT INTO dbo.T1(datacol) VALUES('AAAAA');

SET @new_key = SCOPE_IDENTITY();

SELECT @new_key AS new_key;

SELECT
    SCOPE_IDENTITY() AS [SCOPE_IDENTITY],
    @@identity AS [@@identity],
    IDENT_CURRENT('dbo.T1') AS [IDENT_CURRENT];

INSERT INTO dbo.T1(datacol) VALUES('12345');

INSERT INTO dbo.T1(datacol) VALUES('EEEEE');

SELECT * FROM dbo.T1;

SET IDENTITY_INSERT dbo.T1 ON;

INSERT INTO dbo.T1(keycol, datacol) VALUES(5, 'FFFFF');

SET IDENTITY_INSERT dbo.T1 OFF;

INSERT INTO dbo.T1(datacol) VALUES('GGGGG');

SELECT * FROM dbo.T1;
