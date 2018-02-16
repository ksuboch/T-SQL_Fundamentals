USE TSQL2012;

SELECT empid, ordermonth, val,
    SUM(val) OVER(PARTITION BY empid -- извлекает строки, содержащие те-же строки, что и текущая
                    ORDER BY ordermonth -- упорядочивает содержимое окна
                    ROWS BETWEEN UNBOUNDED PRECEDING -- ограничивает окно от начала секционирования
                        AND CURRENT ROW) AS runval -- до текущей строки
FROM Sales.EmpOrders;

SELECT orderid, custid, val,
    ROW_NUMBER() OVER(ORDER BY val) AS rownum, -- последовательные номера
    RANK() OVER(ORDER BY val) AS rank, -- ранжирование
    DENSE_RANK() OVER(ORDER BY val) AS dr, -- ранжирование с учётом уникальности
    NTILE(10) OVER(ORDER BY val) AS ntile -- связывание строк в группы одинакового размера
FROM Sales.OrderValues
ORDER BY val;

SELECT orderid, custid, val,
    ROW_NUMBER() OVER(PARTITION BY custid
                        ORDER BY val) AS rownum
FROM Sales.OrderValues
ORDER BY custid, val;

SELECT COUNT(*) FROM
(
    SELECT DISTINCT val FROM Sales.OrderValues
) AS A;

SELECT COUNT(*) FROM
(
    SELECT DISTINCT val, ROW_NUMBER() OVER(ORDER BY val) AS rownum FROM Sales.OrderValues
) AS B;

SELECT COUNT(*) FROM
(
    SELECT val, ROW_NUMBER() OVER(ORDER BY val) AS rownum FROM Sales.OrderValues GROUP BY val
) AS C;
