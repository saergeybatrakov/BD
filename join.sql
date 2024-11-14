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
    
    f.manager = s.empno;

/*Примеры соединений*/
/* Поиск тех продавцов, которые не назначены покупателям, но обслуживали их заказы */
SELECT 
    b.cname as 'Клиент', a.amount as 'Сумма заказов', c.sname as 'Обслуживающий заказ продавец', d.sname as '"Свой" продавец'
FROM
    sales a,
    customers b,
    salespeaple c,
    salespeaple d
WHERE
    a.cnum = b.cnum AND a.snum <> b.snum
        AND a.snum = c.snum and b.snum = d.snum;

	/* Поиск образов */
/* Выводим три колонки, в каждой - покупатель с орпеделённым значением рейтинга */
SELECT 
    a.cnum, a.cname, b.cnum, c.cnum
FROM
    customers a,
    customers b,
    customers c
WHERE
    a.rating = 100 AND b.rating = 200
        AND c.rating = 300
	ORDER BY a.cnum , b.cnum , c.cnum;

	/* Соединение таблиц, не входящих в результаты запроса */
SELECT 
    b.cnum, b.cname, b.city
FROM
    customers a,
    customers b
WHERE
    a.snum = 101 AND a.city = b.city;

/* Выводим пары покупатеолей, обслуживаемы одним и тем же продавцом */
SELECT 
    sname, salespeaple.snum, a.cname, b.cname
FROM
    customers a,
    customers b,
    salespeaple
WHERE
    a.snum = b.snum
        AND salespeaple.snum = a.snum
	        AND a.cname < b.cname
		ORDER BY snum;

		/* Оператор join в сочении с using() */
SELECT 
    city 'Общий город', cname 'Покупатель', sname 'Продавец'
FROM
    customers
        JOIN
	    salespeaple USING (city)
	    order by 1;

	/* Запрос, эквиалентный предыдущему */
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

/* "Левое" и 'Правое' соединение */
SELECT 
    customers.cname, salespeaple.sname
FROM
    customers
        LEFT JOIN
	    salespeaple USING (snum);

	SELECT 
	    customers.cname, salespeaple.sname
	FROM
	    customers
	        RIGHT JOIN
		    salespeaple USING (snum);

		SELECT 
		    customers.cname, salespeaple.sname
		FROM
		    customers
		         JOIN
			    salespeaple USING (snum);

			/* Пример соединения при помощи оператора ON */
SELECT 
    a.empname as 'Менеджер', b.empname as 'Подчинённый'
FROM
    shop.employee a
        JOIN
	    employee b ON a.empno = b.manager;

	/* При левом соединение справа выводятся NULL-значения для тех значений слева, которые не сопоставлены ни одному значению справа */
SELECT 
    a.empname as 'Менеджер', b.empname as 'Подчинённый'
FROM
    shop.employee a
        left JOIN
	    employee b ON a.empno = b.manager;

	/* При правом соединение слева выводятся NULL-значения для тех значений справа, которые не сопоставлены ни одному значению слева */
SELECT 
    a.empname as 'Менеджер', b.empname as 'Подчинённый'
FROM
    shop.employee a
        right JOIN
	    employee b ON a.empno = b.manager;

	/* Натураьное соединение таблиц sales и salespeaple - автоматическое соединение по одноимеённым столбцам */
SELECT 
    sdate, amount, sname
FROM
    sales a
        NATURAL JOIN
	    salespeaple b
	        NATURAL JOIN
		    customers c
		WHERE
		    b.city = 'Новосибирск';

		   SELECT 
		    a.sdate, a.amount, sname, cname
		FROM
		    sales a
		        JOIN
			    salespeaple b ON (b.snum),
			    sales d
			        JOIN
				    customers c ON (c.cnum)
				WHERE
				    a.sdate = d.sdate
				        AND a.amount = d.amount
					        AND a.cnum = d.cnum
						        AND a.snum = d.snum
							        AND d.snum = b.snum
								        AND a.cnum = c.cnum; 

									    /* спользование join для объединения результатов выборки из трёх таблиц */
SELECT 
    *
FROM
    sales a
        NATURAL LEFT JOIN
	    salespeaple b
	        JOIN
		    customers c USING (cnum);

		/* При правом объединении таблиц customers и sales natural right join salespeaple получаем список 
всех покупателей из таблицы customers и null значения там, где покупателям не назначен продавкц */
SELECT 
    *
FROM
    sales a
        NATURAL right JOIN
	    salespeaple b
	        right JOIN
		    customers c USING (cnum);

		SELECT 
		    *
		FROM
		    sales a
		        NATURAL right JOIN
			    salespeaple b
			        right JOIN
				    customers c USING (cnum);

				/* С таблицей, полученной в результате соединений, можно использовать условия в предложении where */
SELECT 
    *
FROM
    sales a
        NATURAL right JOIN
	    salespeaple b
	        right JOIN
		    customers c USING (cnum)
		    where c.city = 'Новосибирск';



