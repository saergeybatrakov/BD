/*соединение таблиц */
/*"Естественное" соединение таблиц customers и salepeople при помощи ключей 
ссылки из поля `customers`.`snum` на первичный ключ `salespeaple`.`snum`*/
SELECT 
    cname as 'Покупатель', sname 'Продавец'
FROM
    shop.customers,
    `shop`.`salespeaple`
WHERE
    `customers`.`snum` = `salespeaple`.`snum`;

   /* "естественное"Соединение трёх таблиц */
   SELECT 
    `customers`.`cname`,
    `salespeaple`.`sname`,
    `sales`.`sdate`,
    `sales`.`amount`
FROM
    shop.sales,
    shop.customers,
    `shop`.`salespeaple`
WHERE
    `sales`.`snum` = `salespeaple`.`snum` and sales.cnum =customers.cnum;

    /*"Неестественное соединение" двух таблиц (без использование ключевы полей)*/
SELECT 
    `customers`.`cname`,
    customers.city,
    `salespeaple`.`sname`,
    salespeaple.city
FROM
    customers,
    salespeaple
WHERE
    customers.city = salespeaple.city;

    /*Составные условия при соединении*/
SELECT 
    `customers`.`cname`,
    customers.city,
    `salespeaple`.`sname`,
    salespeaple.city
FROM
    customers,
    salespeaple
WHERE
    customers.city = salespeaple.city
        AND customers.city in  ('Томск', 'Омск');

	/*использование неравенств при соединениях */
SELECT 
    `customers`.`cname`,
    customers.city,
    `salespeaple`.`sname`,
    salespeaple.city
FROM
    customers,
    salespeaple
WHERE
    customers.city < salespeaple.city
        AND rating = 200;

	/*Использование псевдоним (alias) для таблиу */
/*Соединение одной таблицы с одной */
SELECT 
    `first`.cname, `second`.sname, `first`.rating
FROM
    customers `first`,
    customers `second`
WHERE
    `first`.rating = `second`.rating and `first`.cname < `second`.cname;

/* Псевдонимы для разных таблиц*/
SELECT 
    b.cname as 'Покупатель', a.sname as 'Продавец', b.rating as 'рейтинг покупателя'
FROM
    salespeaple a,
    customers b
WHERE
    a.snum = b.snum;

/*Самосоединение для таблицы с циклической зависимостью */
SELECT 
    f.empno, f.empname, s.empname
FROM
    employee f,
    employee s
WHERE
    f.manager = s.empno
