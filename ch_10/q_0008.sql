USE TSQL2012;

CREATE TABLE dbo.##Globals
(
    id SYSNAME NOT NULL PRIMARY KEY,
    val SQL_VARIANT NOT NULL
);

INSERT INTO dbo.##Globals(id, val) VALUES(N'i', CAST(10 AS INT));

SELECT val FROM dbo.##Globals WHERE id = N'i';

DROP TABLE dbo.##Globals;
