USE TSQL2012;

IF OBJECT_ID('dbo.Digits', 'U') IS NOT NULL DROP TABLE dbo.Digits;
CREATE TABLE dbo.Digits(digit INT NOT NULL PRIMARY KEY);

INSERT INTO dbo.Digits(digit)
    VALUES (0), (1), (2), (3), (4), (5), (6), (7), (8), (9);

SELECT digit FROM dbo.Digits;

SELECT
    D3.digit * 100 + D2.digit * 10 + D1.digit AS n
FROM            dbo.Digits AS D1
    CROSS JOIN  dbo.Digits AS D2
    CROSS JOIN  dbo.Digits AS D3
ORDER BY n;
