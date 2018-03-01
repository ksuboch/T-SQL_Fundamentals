USE TSQL2012;

IF OBJECT_ID('dbo.T1_Audit', 'U') IS NOT NULL
    DROP TABLE dbo.T1_Audit;

IF OBJECT_ID('dbo.T1', 'U') IS NOT NULL
    DROP TABLE dbo.T1;

CREATE TABLE dbo.T1
(
    keycol  INT         NOT NULL PRIMARY KEY,
    datacol VARCHAR(10) NOT NULL
);

CREATE TABLE dbo.T1_Audit
(
    audit_lsn   INT         NOT NULL IDENTITY PRIMARY KEY,
    dt          DATETIME    NOT NULL DEFAULT(SYSDATETIME()),
    login_name  SYSNAME     NOT NULL DEFAULT(ORIGINAL_LOGIN()),
    keycol      INT         NOT NULL,
    datacol     VARCHAR(10) NOT NULL
);
GO

CREATE TRIGGER trg_T1_insert_audit ON dbo.T1 AFTER INSERT
AS
SET NOCOUNT ON;

INSERT INTO dbo.T1_Audit(keycol, datacol)
    SELECT keycol, datacol FROM inserted;
GO

INSERT INTO dbo.T1(keycol, datacol) VALUES(10, 'a');
INSERT INTO dbo.T1(keycol, datacol) VALUES(30, 'x');
INSERT INTO dbo.T1(keycol, datacol) VALUES(20, 'g');

SELECT audit_lsn, dt, login_name, keycol, datacol
FROM dbo.T1_Audit;

IF OBJECT_ID('dbo.T1_Audit', 'U') IS NOT NULL
    DROP TABLE dbo.T1_Audit;

IF OBJECT_ID('dbo.T1', 'U') IS NOT NULL
    DROP TABLE dbo.T1;
