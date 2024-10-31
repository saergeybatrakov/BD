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
    city LIKE 'Нов_%';

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
