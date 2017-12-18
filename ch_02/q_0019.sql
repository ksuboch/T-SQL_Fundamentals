USE TSQL2012;

SELECT
    SUBSTRING('abcde', 1, 3);

SELECT
    RIGHT('abcde', 3);

SELECT
    LEN(N'abcde');

SELECT
    DATALENGTH(N'abcde');

SELECT
    CHARINDEX(' ', 'Ицик Бен-Ган');

SELECT
    PATINDEX('%[0-9]%', 'abcd123efgh');

SELECT
    REPLACE('1-a 2-b', '-', ':');

SELECT
    empid,
    lastname,
    LEN(lastname) - LEN(REPLACE(lastname, 'о', '')) AS numoccur
FROM
    HR.Employees;

SELECT
    REPLICATE('abc', 3);

SELECT
    RIGHT(REPLICATE('0', 9) + CAST(supplierid AS VARCHAR(10)), 10) AS strsupplierid
FROM Production.Suppliers;

SELECT
    STUFF('xyz', 2, 1, 'abc');

SELECT
    UPPER('Ицик Бен-Ган'),
    LOWER('Ицик Бен-Ган');

SELECT
    RTRIM(LTRIM('  abc  '));

SELECT
    FORMAT(1759, 'd10');

SELECT
    empid,
    lastname
FROM
    HR.Employees
WHERE
    lastname LIKE N'Д%';

SELECT
    empid,
    lastname
FROM
    HR.Employees
WHERE
    lastname LIKE N'_у%';

SELECT
    empid,
    lastname
FROM
    HR.Employees
WHERE
    lastname LIKE N'[АБЛ]%';

SELECT
    empid,
    lastname
FROM
    HR.Employees
WHERE
    lastname LIKE N'[А-К]%';

SELECT
    empid,
    lastname
FROM
    HR.Employees
WHERE
    lastname LIKE N'[^А-К]%';
