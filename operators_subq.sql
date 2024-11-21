/* оператор exsists*/
/*поздапросы с оператором exsists возвращают логическое значение true/false */
/*при наличии дюбого не пустого результата, выводимого подзапросом, exsists принимает значение true.
при отсутствии данных, возвращаемых  подзапросом, exsists принимает значение false*/
SELECT 
    cnum, cname, city
FROM
    customers
WHERE
    EXISTS( SELECT 
            *
        FROM
            customers
        WHERE
            city = 'новосибирск');

/*примеры использования exsists с коррелированными подзапросами*/
/*результатом запроса является о покупателях, которых обслуживают продавцы,
за которыми закреплены более одного покупателя*/
SELECT 
    *
FROM
    customers `outer`
WHERE
    EXISTS( SELECT 
            *
        FROM
            customers `inner`
        WHERE
            `inner`.snum = `outer`.snum
                AND `inner`.cnum <> `outer`.cnum);

/*комбинирование exsists с соединениями*/
/*вывод информации о покупателях, используя результаты предыдущего запроса*/
SELECT distinct
    `first`.snum, sname, `first`.city
FROM
    salespeaple `first`, customers `second`
WHERE
    EXISTS( SELECT 
            *
        FROM
            customers `third`
        WHERE
            `second`.snum = `third`.snum
                AND `second`.cnum <> `third`.cnum
                and `first`.snum = `second`.snum);

/*использование not exsists*/
/*для каждого null-значения в поле snum основной запрос выводит отдельную строку в виде результата,
т.к. инвертируется логическое значение, возвращаемой оператором exsists*/
SELECT 
    *
FROM
    customers `outer`
WHERE
    NOT EXISTS( SELECT 
            *
        FROM
            customers `inner`
        WHERE
            `inner`.snum = `outer`.snum
                AND `inner`.cnum <> `outer`.cnum);

/*пример сложного подзапроса с exsists*/
/*выводим информацию о продавцах, которыйе обслуживают покупателей с более, чем одним заказом*/
SELECT 
    *
FROM
    salespeaple `first`
WHERE
    EXISTS( SELECT 
            *
        FROM
            customers `second`
        WHERE
            `first`.snum = `second`.snum
                AND 1 < (SELECT 
                    COUNT(*)
                FROM
                    sales
                WHERE
                    sales.cnum = `second`.cnum));

/*специальный оператор any (some)*/
/*запрос выводит продавца, живущих с покупателями в 1 городе*/
SELECT 
    *
FROM
    salespeaple
WHERE
    city = ANY (SELECT 
            city
        FROM
            customers);

SELECT 
    *
FROM
    salespeaple
WHERE
    city = some (SELECT 
            city
        FROM
            customers);


/*запросы с операторами in / exists  вместо any*/
/*результат эквивалентен результату предыдущего запроса */
SELECT 
    *
FROM
    salespeaple
WHERE
    city in (SELECT 
            city
        FROM
            customers);

/*any, в отличии от in, может применяться с неравенствами */
/*запрос выволдит тех продавцов, чьи имена предшествуют именам покупателейв алфавитном порядке*/
SELECT 
    *
FROM
    salespeaple
WHERE
    sname < any (SELECT 
            cname
        FROM
            customers);

/*эквивалентный предыдущему запрос можно реализовать при помощи exists*/
/* различия в применении any и exists в том, что any работает в трехзначной логике, а exists - в двузначной */
SELECT 
    *
FROM
    salespeaple `outer`
WHERE
    EXISTS( SELECT 
            *
        FROM
            customers `inner`
        WHERE
            `outer`.sname < `inner`.cname);

/*пример работы any с числовыми значениями - отбираются все рейтинги, которые больше минимального,
 возвращаемого подзапросом*/
SELECT 
    *
FROM
    customers
WHERE
    rating > ANY (SELECT 
            rating
        FROM
            customers
        WHERE
            city = 'новосибирск');


/*отбираем те заказы, которые сделаны на большую сумму,
чем хотя бы один из заказов от 12 сентября 2024*/
SELECT 
    *
FROM
    sales
WHERE
    amount > ANY (SELECT 
            amount
        FROM
            sales
        WHERE
            sdate = '2024-09-12');

/*пример использования any с соеднениями*/
/*отбираем информацио  заказах на сумму, меньшую, чем любой заказ, 
сделанный покупателем из омска */
SELECT 
    *
FROM
    sales
WHERE
    amount < ANY (SELECT 
            amount
        FROM
            sales a, customers b
        WHERE
            a.cnum = b.cnum and b.city = 'омск');

/*эквивалентный запрос состовляется при помощи агрегатной функции, подзапроса и соединения */
SELECT 
    *
FROM
    sales
WHERE
    amount < (SELECT 
            MAX(amount)
        FROM
            sales a,
            customers b
        WHERE
            a.cnum = b.cnum AND b.city = 'омск');

     /*специальный оператор all*/       
      SELECT 
    *
FROM
    customers
WHERE
    rating < all (SELECT 
            rating
        FROM

            customers 
        WHERE
			city = 'омск');
              /*аналогичный предыдущему запрос с использованием exists. 
              этот запрос работате с null значениями*/
	SELECT 
    *
FROM
    customers `outer`
WHERE
    NOT EXISTS( SELECT 
            *
        FROM
            customers `inner`
        WHERE
            `outer`.rating <= `inner`.rating
                AND `inner`.city = 'омск');            

     /*применение all с неравенствами */         
SELECT 
    *
FROM
    customers
WHERE
    rating <> ALL (SELECT 
            rating
        FROM
            customers
        WHERE
            city = 'омск');  

	/*аналог предыдущего запросва с all*/
  SELECT 
    *
FROM
    customers
WHERE not 
    rating = ALL (SELECT 
            rating
        FROM
            customers
        WHERE
            city = 'омск');            
/*пример использования count()  вместо exists*/              
  SELECT 
    *
FROM
    customers `outer`
WHERE
    1 > (SELECT 
            COUNT(*)
        FROM
            customers `inner`
        WHERE
            `outer`.rating <= `inner`.rating
                AND `inner`.city = 'омск');   
