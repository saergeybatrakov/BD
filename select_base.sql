/*Использование языка SQL для выборки информации из таблиц */

/* Простая выборка из таблицы */
SELECT 
    `salespeaple`.`sname`,
    `salespeaple`.`city`,
    `salespeaple`.`comm`
FROM `shop`.`salespeaple`;

/* Отбор без повторающихся значений */
SELECT distinct
`sales`.`snum`,
`sales`.`sdate`
FROM `shop`.`sales`;

/* Отбор по условию (предложение where) */
/* Отбор продавцов из определённых городов */
SELECT 
    `salespeaple`.`sname`,`salespeaple`.`comm`
FROM
    `shop`.`salespeaple`
WHERE
    `salespeaple`.`city` = 'Сочи' or `salespeaple`.`city` = 'Новосибирск';

/* Отбор продавцов из определённых городов */
SELECT 
`customers`.`cname`,
`customers`.`city`
FROM
   `shop`.`customers`
WHERE
    `customers`.`rating` >200;

SELECT 
`customers`.`cname`,
`customers`.`city`
FROM
   `shop`.`customers`
WHERE
    `customers`.`rating` >=200;

SELECT 
`customers`.`cname`,
`customers`.`city`
FROM
   `shop`.`customers`
WHERE
    `customers`.`rating` <>200;

SELECT 
`customers`.`cname`,
`customers`.`city`
FROM
   `shop`.`customers`
WHERE
   not `customers`.`rating` = 200;

   /* Применение условий отбора для NULL-значений*/
SELECT 
`customers`.`cname`,
`customers`.`city`
FROM
   `shop`.`customers`
WHERE
    `customers`.`rating` <>200 or `customers`.`rating` = 200;
    /* NULL - значения (неизвестный результат сравнения) не выводятся в результат отбора */

/*составные условия с лоигическими операторами or, and, not*/
SELECT 
`customers`.`cname`,
`customers`.`city`
FROM
   `shop`.`customers`
WHERE
    `customers`.`city` = 'Новосибирск' and not `customers`.`rating` > 200;

SELECT 
`customers`.`cname`,
`customers`.`city`
FROM
   `shop`.`customers`
WHERE
   not `customers`.`city` = 'Новосибирск' and not `customers`.`rating` > 200;

SELECT 
`customers`.`cname`,
`customers`.`city`
FROM
   `shop`.`customers`
WHERE
   not (`customers`.`city` = 'Новосибирск' and `customers`.`rating` > 200);

/* Пример отбора по датам*/
SELECT 
    `sales`.`snum`,
    `sales`.`cnum`,
    `sales`.`sdate`,
    `sales`.`amount`
FROM
    `shop`.`sales`
WHERE
    (`sales`.`sdate` > '2024-08-31'
	        AND `sales`.`sdate` < '2024-10-01')
	        AND (NOT (`sales`.`sdate` > '2024-09-12'
				        AND `sales`.`sdate` < '2024-09-16'))
			        AND NOT cnum = 203 or (cnum=203) and (`sales`.`sdate` > '2024-09-30'
					        AND `sales`.`sdate` < '2024-10-31');


