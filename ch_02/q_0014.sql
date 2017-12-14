USE TSQL2012;

SELECT
    productid,
    productname,
    categoryid,
    CASE categoryid
        WHEN 1 THEN 'Напитки'
        WHEN 2 THEN 'Приправы'
        WHEN 3 THEN 'Сладости'
        WHEN 4 THEN 'Молочные продукты'
        WHEN 5 THEN 'Зерно/крупы'
        WHEN 6 THEN 'Мясо/птица'
        WHEN 7 THEN 'Овощи'
        WHEN 8 THEN 'Морепродукты'
        ELSE 'Категория не определена'
    END AS cateegoryname
FROM Production.Products;

SELECT
    orderid,
    custid,
    val,
    CASE
        WHEN val < 1000.00 THEN 'Less than 1000'
        WHEN val BETWEEN 1000.00 AND 3000.00 THEN 'From 1000 to 3000'
        WHEN val > 3000 THEN 'More than 3000'
        ELSE 'Unknown'
    END AS valuecategory
FROM Sales.OrderValues;

SELECT
    ISNULL(NULL, 'Not NULL'),
    ISNULL(1, 'Not NULL'),
    IIF(1 > 0, '1 > 0', '1 < 0') AS Tern,
    CHOOSE(1, 'one', 'two', 'three') AS Chose;
