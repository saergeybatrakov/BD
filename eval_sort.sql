/*Использование выражений в предложении SELECT*/
SELECT 
  `salespeaple`.`snum`,
  `salespeaple`.`comm` * 100 as 'Комм. в %'
FROM
    shop.salespeaple;

/*Добавление текста в результате запроса */
SELECT 
  `salespeaple`.`snum`,
  `salespeaple`.`comm` * 100 as 'Комм. в %', '%'
FROM
    shop.salespeaple;

/*Форматирование отчёта средставми SQL */
SELECT 
'*' as'На дату', sdate as 'Дата', 'обслужено', count(*) 'Количество', 'Заказов'
FROM
    shop.sales
    group by sdate;

/*Выражение INTERVAL для вычисление дат*/
SELECT 
    sdate
FROM
    sales
WHERE
    sdate < '2024-09-01' + INTERVAL 14 DAY
        AND sdate > '2024-09-01' - INTERVAL 14 DAY;

/*Использование выражения INTERVAL для указания количества месяцев*/
SELECT 
    sdate
FROM
    sales
WHERE
    sdate > '2024-09-01'
        AND sdate < '2024-09-01' + INTERVAL 1 MONTH;

/*Сортировка значений */
SELECT 
    *
FROM
    sales
ORDER BY sdate DESC;

/*Сортировка по 2ум столбцам */
SELECT 
    *
FROM
    sales
ORDER BY sdate, amount DESC;

/*сортировка столбцов с указанием их номера */
SELECT 
    *
FROM
    sales
ORDER BY 3 DESC, 4;

/*Сортировка по агрегатным группам */
SELECT 
    snum, sdate, MAX(amount)
FROM
    sales
GROUP BY snum , sdate
ORDER BY snum , sdate;

/*Сортировка по значению, подсчитанному агрегатной функцией */
SELECT 
    snum, sdate, MAX(amount)
FROM
    sales
GROUP BY snum , sdate
ORDER BY snum , 3 desc;

/*Null- значение и сортировка  - mu SQL Выводит null значение впереди остальных при сортировки по возрастанию*/
SELECT 
    *
FROM
    shop.customers
order by rating;
