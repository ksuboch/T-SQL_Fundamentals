USE TSQL2012;

IF OBJECT_ID('dbo.Sequences', 'U') IS NOT NULL
    DROP TABLE dbo.Sequences;

CREATE TABLE dbo.Sequences
(
    id VARCHAR(10) NOT NULL
        CONSTRAINT PK_Sequences PRIMARY KEY(id),
    val INT NOT NULL
);

INSERT INTO dbo.Sequences VALUES('SEQ1', 0);

DECLARE @nextval AS INT;

UPDATE dbo.Sequences
    SET @nextval = val += 1
WHERE id = 'SEQ1';

SELECT @nextval;

IF OBJECT_ID('dbo.Sequences', 'U') IS NOT NULL
    DROP TABLE dbo.Sequences;
