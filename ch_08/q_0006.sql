USE TSQL2012;

CREATE SEQUENCE dbo.SeqOrderIDs AS INT
    MINVALUE 1
    CYCLE;

ALTER SEQUENCE dbo.SeqOrderIDs
    NO CYCLE;

SELECT NEXT VALUE FOR dbo.SeqOrderIDs;

IF OBJECT_ID('dbo.T1', 'U') IS NOT NULL
    DROP TABLE dbo.T1;

CREATE TABLE dbo.T1
(
    keycol INT NOT NULL
        CONSTRAINT PK_T1 PRIMARY KEY,
    datacol VARCHAR(10) NOT NULL
);

DECLARE @neworder AS INT = NEXT VALUE FOR dbo.SeqOrderIDs;
INSERT INTO dbo.T1(keycol, datacol) VALUES(@neworder, 'a');

SELECT * FROM dbo.T1;

INSERT INTO dbo.T1(keycol, datacol)
    VALUES(NEXT VALUE FOR dbo.SeqOrderIDs, 'b');

SELECT * FROM dbo.T1;

UPDATE dbo.T1
    SET keycol = NEXT VALUE FOR dbo.SeqOrderIDs;

SELECT * FROM dbo.T1;

SELECT current_value
FROM sys.sequences
WHERE OBJECT_ID = OBJECT_ID('dbo.SeqOrderIDs');

INSERT INTO dbo.T1(keycol, datacol)
    SELECT
        NEXT VALUE FOR dbo.SeqOrderIDs OVER (ORDER BY hiredate),
        LEFT(firstname, 1) + LEFT(lastname, 1)
    FROM HR.Employees;

SELECT * FROM dbo.T1;

ALTER TABLE dbo.T1
    ADD CONSTRAINT DFT_T1_keycol
        DEFAULT (NEXT VALUE FOR dbo.SeqOrderIDs)
        FOR keycol;

INSERT INTO dbo.T1(datacol) VALUES('c')

SELECT * FROM dbo.T1

DECLARE @first AS SQL_VARIANT;

EXEC sys.sp_sequence_get_range
    @sequence_name = N'dbo.SeqOrderIDs',
    @range_size = 1000,
    @range_first_value = @first OUTPUT;

SELECT @first;

IF OBJECT_ID('dbo.T1', 'U') IS NOT NULL
    DROP TABLE dbo.T1;

IF OBJECT_ID('dbo.SeqOrderIDs', 'So') IS NOT NULL
    DROP SEQUENCE dbo.SeqOrderIDs;
