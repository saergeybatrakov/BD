/*подзапросы */
/*простейшая форма подзапроса - сравнении нужного значения с результатом выполнения поздапроса
подзапрос должен вызвращасть единственное значение*/
SELECT 
    *
FROM
    sales
WHERE
    snum = (SELECT 
            snum
        FROM
            salespeaple
        WHERE
            sname = 'Саша');
         
         
         /*если подзапрос может верноть несколько значений, 
         то возамоно использование оператора in во внешнем запросе*/
      SELECT 
    *
FROM
    sales
WHERE
    snum in (SELECT 
            snum
        FROM
            salespeaple
        WHERE
            sname = 'Саша');      
            
            
            SELECT 
    *
FROM
    sales
WHERE
    snum IN (SELECT 
            snum
        FROM
            salespeaple
        WHERE
            city = 'Новосибирск');

/*Список продаж покупателей с номером "201"*/

SELECT 
    amount, sdate, salespeaple.snum, salespeaple.sname
FROM
    sales natural join salespeaple
WHERE
    snum IN (SELECT 
            snum
        FROM
            sales
        WHERE
            cnum = '201');

/*Комиссионные продавцов, обслуживающие покупателей из "Санкт-Петербург"*/

SELECT 
    comm
FROM
    salespeaple
WHERE
    snum IN (SELECT 
            snum
        FROM
            customers
        WHERE
            city = 'Санкт-Петербург');
            
/*Использование агрегатных функций в подзапросах*/

SELECT 
    *
FROM
    sales
WHERE
    amount > (SELECT 
            AVG(amount)
        FROM
            sales
        WHERE
            sdate = '2024-09-12');


SELECT 
    *
FROM
    sales
WHERE
    amount > (SELECT 
            500+AVG(amount)
        FROM
            sales
        WHERE
            sdate = '2024-09-12' and sdate < '2024-09-12' + interval 15 day);

/* Подзапросы в предложении HAVING */
SELECT 
    rating, COUNT(DISTINCT cnum)
FROM
    customers
GROUP BY rating
HAVING rating > (SELECT 
        AVG(rating)
    FROM
        customers
    WHERE
        city = 'Новосибирск');

/* Связанные (коррелированные) подзапросы */
/* Поиск информации о покупателях, сделавших заказы 12 сентября 2024 года */
SELECT 
    *
FROM
    customers `outer`
WHERE
    '2024-09-12' IN (SELECT 
            sdate
        FROM
            sales `inner`
        WHERE
            `outer`.cnum = `inner`.cnum);

/* Последовательность выполнения коррелированных подзапросов:
1. Выбирается строка из таблицы, указанной во внешнем запросе 
2. Значения из этой строки сохраняются для получения результата при проверке условия `outer`.cnum = `inner`.cnum 
3. Выполняется подзапрос 
4. Вычисляется условие равенства значений из строки, выбранной во внешнем запросе каждой строки из внуутреннего запорса
5. Если в результате сравнения внешней и внетренней строки получаем trye, то строка из внешнего запроса выводится в результате коррелированного запроса
6. Выбирается следущая строка и процедура повторяется заново
*/

/* Аналогичный результат можно получить при помощи соединения */
SELECT 
    `first`.cnum,
    `first`.cname,
    `first`.city,
    `first`.rating,
    `first`.snum
FROM
    customers `first`,
    sales `second`
WHERE
    `first`.cnum = `second`.cnum
        AND `second`.sdate = '2024-09-12';

/* В коррелированных запросах можно использовать подзапросы с агрегатными функциями */
/* Получем всех продавцов, которые обслуживают (закреплёны) более одного покупателя */
/* При ссылке в предложении where из подзапроса на "свою" таблицу, название таблицы перед полем можно не указывать */
SELECT 
    snum, sname
FROM
    salespeaple main
WHERE
    1 < (SELECT 
            COUNT(*)
        FROM
            customers
        WHERE
            snum = main.snum);

/* Поиск аномалий в данных при помощи связанных запросов */
/* Находим все продажи, которые обслуживались не закреплёнными за покупателями продавцами */
SELECT 
    *
FROM
    sales main
WHERE
    NOT snum = (SELECT 
            snum
        FROM
            customers
        WHERE
            cnum = main.cnum);

/* Автокорреляция (связанный подзапрос для таблице, которая ссылается на саму себя) */
/* Все заказы, стоимость которых выше средней для каждого покупателя */
/* Пример зароса, когда аналогичный результат невоможно получить ответ путём соединениятаблиц с собой */
SELECT 
    *
FROM
    sales `outer`
WHERE
    amount > (SELECT 
            AVG(amount)
        FROM
            sales `inner`
        WHERE
            `inner`.cnum = `outer`.cnum);

/* Использование выражений в позапросе при автокорреляции */
/* Поиск заказов в два раза больше, чем средний для каждого покупателя */
SELECT 
    *
FROM
    sales `outer`
WHERE
    amount > (SELECT 
            AVG(amount * 2)
        FROM
            sales `inner`
        WHERE
            `inner`.cnum = `outer`.cnum);

/* HAVING с коррелированными запросами */
/* Подзапрос отбирает только те группы, для которых значение суммы на 43 больше, чем максимальное значение на выбранную дату */
 SELECT 
    sdate, SUM(amount)
FROM
    sales a
GROUP BY sdate
HAVING SUM(amount) > (SELECT 
        43 + MAX(amount)
    FROM
        sales b
    WHERE
        a.sdate = b.sdate);
