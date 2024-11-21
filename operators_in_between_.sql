/* Операторы in, between, like, is null и агрегатные функции*/
/* in - выборка из множества значений*/

SELECT 
    `customers`.`cnum`,
    `customers`.`cname`,
    `customers`.`city`,
    `customers`.`rating`,
    `customers`.`snum`
FROM
    `shop`.`customers`
WHERE
    `customers`.`city` IN ('Новосибирск' , 'Омск');

SELECT 
    `sales`.`sdate`,
    `sales`.`amount`
FROM `shop`.`sales`
where `sales`.`sdate` in ('2024-09-12', '2024-09-13', '2024-09-17');

/* between - выборка из диапазона значений*/
SELECT 
    `sales`.`sdate`, `sales`.`amount`
FROM
    `shop`.`sales`
WHERE
    `sales`.`sdate` BETWEEN '2024-09-12' AND '2024-09-17';

SELECT 
    `salespeaple`.`sname`,
    `salespeaple`.`city`,
    `salespeaple`.`comm`
FROM `shop`.`salespeaple`
where `salespeaple`.`comm` between (0.09+0.01) and (0.11-0.01);

/* Исключение границ диапазона при помощи комбинации between и  in*/
SELECT 
    `salespeaple`.`sname`,
    `salespeaple`.`city`,
    `salespeaple`.`comm`
FROM
    `shop`.`salespeaple`
WHERE
    `salespeaple`.`comm` BETWEEN 0.09 AND 0.11
        AND NOT `salespeaple`.`comm` IN (0.09 , 0.11);

SELECT 
    `customers`.`cnum`,
    `customers`.`cname`,
    `customers`.`city`,
    `customers`.`rating`,
    `customers`.`snum`
FROM
    `shop`.`customers`
WHERE
    `customers`.`city` between 'Н' and 'Омск';

/* Оператор LIKE */

/* '%' - любое количество любых символов, '_' - один любой символ */

SELECT 
    `customers`.`cnum`,
    `customers`.`cname`,
    `customers`.`city`,
    `customers`.`rating`,
    `customers`.`snum`
FROM
    `shop`.`customers`
WHERE
    city LIKE 'Н%';

SELECT 
    `customers`.`cnum`,
    `customers`.`cname`,
    `customers`.`city`,
    `customers`.`rating`,
    `customers`.`snum`
FROM
    `shop`.`customers`
WHERE
    city LIKE 'Нов_%';customerscustomers;

SELECT 
    `customers`.`cnum`,
    `customers`.`cname`,
    `customers`.`city`,
    `customers`.`rating`,
    `customers`.`snum`
FROM
    `shop`.`customers`
WHERE
    cname LIKE '%ри%';

/*Применение символов ислючения при помощи scape */
SELECT 
    `customers`.`cnum`,
    `customers`.`cname`,
    `customers`.`city`,
    `customers`.`rating`,
    `customers`.`snum`
FROM
    `shop`.`customers`
WHERE
    cname LIKE '%/%%' escape '/';
    
 /* Оператор Is NULL*/

SELECT 
    `customers`.`cnum`,
    `customers`.`cname`,
    `customers`.`city`,
    `customers`.`rating`,
    `customers`.`snum`
FROM
    `shop`.`customers`
WHERE
 snum is not null;

/* В MySQL не выполняется эвивалентный предыдущему запрос с условием not is null
SELECT 
    `customers`.`cnum`,
    `customers`.`cname`,
    `customers`.`city`,
    `customers`.`rating`,
    `customers`.`snum`
FROM
    `shop`.`customers`
WHERE
    snum is not null;
*/

/* NOT c IN*/
SELECT 
    `customers`.`cnum`,
    `customers`.`cname`,
    `customers`.`city`,
    `customers`.`rating`,
    `customers`.`snum`
FROM
    `shop`.`customers`
WHERE
    `customers`.`city` NOT IN ('Новосибирск' , 'Омск');

SELECT 
    `customers`.`cnum`,
    `customers`.`cname`,
    `customers`.`city`,
    `customers`.`rating`,
    `customers`.`snum`
FROM
    `shop`.`customers`
WHERE
   not `customers`.`city` NOT IN ('Новосибирск' , 'Омск');

/* Комбинирование is null  с другими операторами отбора */
SELECT 
    `customers`.`cnum`,
    `customers`.`cname`,
    `customers`.`city`,
    `customers`.`rating`,
    `customers`.`snum`
FROM
    `shop`.`customers`
WHERE
   city LIKE 'Нов%' or `customers`.`rating` IS NULL;

SELECT 
    `customers`.`cnum`,
    `customers`.`cname`,
    `customers`.`city`,
    `customers`.`rating`,
    `customers`.`snum`
FROM
    `shop`.`customers`
WHERE
  not (city LIKE 'Нов%' and `customers`.`rating` IS NULL);

/* Агрегатные функции */
/*count(), sum(), avg(), max(), min() */

/*Подсчёт суммы чисел по определённому столбцу */
SELECT 
    SUM(amount)
FROM
    sales;
    
    /*Подсчёт количества строк */
    SELECT 
    COUNT(*)
FROM
    sales
WHERE
    sdate > '2024-09-01'
        AND sdate < '2024-09-30';

/*Подсчёт среднего значения за определённый период*/
SELECT 
    AVG(amount)
FROM
    sales
WHERE
    sdate > '2024-09-01'
        AND sdate <= '2024-09-30';

SELECT 
    AVG(sdate)
FROM
    sales
    where sdate > '2024-09-15'
        AND sdate <= '2024-09-30';

SELECT 
    AVG(amount)
FROM
    sales
WHERE
    sdate > '2024-09-01'
        AND sdate <= '2024-09-30';

SELECT 
    AVG(sdate)
FROM
    sales
    where sdate > '2024-09-15'
        AND sdate <= '2024-09-30';
        
  /*При использовании distinct внутри функции count() подсчитывается уникальное значение в столбце */      
SELECT 
    COUNT(distinct city)
FROM
    customers;
/*Null значение игнорируются при подсчёте по одному столбцу */
SELECT 
    COUNT(rating)
FROM
    customers;

/*ункция MAX() и MIN() работают со строковыми значениями, ориентируясь на алфавитный порядок*/
SELECT 
    MAX(cname)
FROM
    customers;

SELECT 
    min(cname)
FROM
    customers;

/*Группировка максимальных значений продаж по каждому продавцу*/
SELECT 
    snum, MAX(amount)
FROM
    sales
GROUP BY snum;

/*Группировка значений по нескольким столбцам*/
SELECT
	shum,sdate, MAX(amount)
FROM
	sales
GROUP BY snum, sdate;

/* Отбор значений после группировки осуществляется с помощью специального вырпжения HAVING*/
/* WHERE отбирает строки до группировки и не может содержать агрегатные функции */
SELECT 
    snum, sdate, MAX(amount)
FROM
    sales
GROUP BY snum , sdate
HAVING MAX(amount) > 1000;	

SELECT 
    snum, sdate, MAX(amount)
FROM
    sales
GROUP BY snum , sdate
HAVING MAX(amount) > 1000;

/* HAVING можно использовать только для сгрупированных столбцов*/
SELECT 
    snum, sdate, MAX(amount)
FROM
    sales
GROUP BY snum , sdate
HAVING sdate > '2024-09-15';

/* Если в группировке не используется поле, по которому нужно сделать отбор, то используется только выражение where*/
SELECT 
    snum, sdate, MAX(amount)
FROM
    sales
where sdate > '2024-09-15'
HAVING snum;

/**/
SELECT 
    snum, MAX(amount)
FROM
    sales
where sdate > '2024-09-15'
GROUP by snum
HAVING snum in (101, 106)
