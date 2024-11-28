/* Объединение запросов при помощи оператора UNION */
/* Запросы должны быть совместимы по объединению - типы данных в столбцах и количество столбцов должны совпадать */
/* Значение NULL совпадёт с любым типом данных, поэтому можно использовать в одном из объединяемых запросов столбец NULL */
SELECT 
    snum as 'Номера продавцов и покупателей', sname as 'Имена продавцов и покупателей', null
FROM
    salespeaple
WHERE
    city = 'Новосибирск' 
UNION SELECT 
    cnum, cname, rating
FROM
    customers
WHERE
    city = 'Новосибирск';

/* Повторяющиеся значения, полученные в результате объединения, выводятся в одном экземпляре */    
SELECT 
    city
FROM
    salespeaple 
UNION SELECT 
    city
FROM
    customers;

/* UNION ALL позволяет выводить повторяющиеся значения */
SELECT 
    city
FROM
    salespeaple 
UNION ALL SELECT 
    city
FROM
    customers;

/* При объединении запросов можно использовать константы и выражения при условии сохранения совместимости столбцов */
select a.snum, sname as 'Имя продавца', 'Максимальный на', sdate as 'дату' from salespeaple a, sales b
where a.snum = b.snum and b.amount = (select max(amount) from sales c where c.sdate = b.sdate) 
union select a.snum, sname, 'Минимальный на', sdate from salespeaple a, sales b 
where a.snum = b.snum and b.amount = (select min(amount) from sales c where c.sdate = b.sdate);

/* В запросах на соединении можно использовать order by для сортировки результатов */
select a.snum, sname as 'Имя продавца', 'Максимальный на', sdate as 'дату', amount as 'сумма заказа' from salespeaple a, sales b
where a.snum = b.snum and b.amount = (select max(amount) from sales c where c.sdate = b.sdate) 
union select a.snum, sname, 'Минимальный на', sdate, amount as 'сумма заказа' from salespeaple a, sales b 
where a.snum = b.snum and b.amount = (select min(amount) from sales c where c.sdate = b.sdate)
order by 2, 4;

/* Поиск продавцов, присутствующих и отсутствующих в таблице "Продажи" (sales) */
SELECT 
    s.snum, sname, 'есть заказы'
FROM
    salespeaple s,
    sales o
WHERE
    s.snum = o.snum 
UNION SELECT 
    snum, sname, NULL
FROM
    salespeaple s
WHERE
    NOT EXISTS( SELECT 
            *
        FROM
            sales o
        WHERE
            s.snum = o.snum)
ORDER BY 1;

/* Запрос находит тех продавцов, кто отсутствует в таблице "Продажи" и напротив них записывает значение 0 */
SELECT 
    snum, COUNT(snum) as 'количество заказов'
FROM
    sales
GROUP BY snum 
UNION SELECT 
    snum, 0
FROM
    salespeaple
WHERE
    NOT snum IN (SELECT 
            snum
        FROM
            sales)
ORDER BY 1;

/* Находит продавцов и покупателей, живущих в одном городе и выводит "Не найдено совпадений" для тех, кто не живет в одном городе с остальными */
SELECT 
    salespeaple.snum, sname, cname, comm
FROM
    salespeaple,
    customers
WHERE
    salespeaple.city = customers.city 
UNION SELECT 
    snum, sname, 'Не найдено совпадений', comm
FROM
    salespeaple
WHERE
    NOT city IN (SELECT 
            city
        FROM
            customers)
ORDER BY 2 DESC;

/* Выводим информацию о продавцах, которым назначено больше одного покупателя или не больше */
select NULL as 'Номер продавца', 'Имя продавца', 'Количество назначенных покупателей'
union
select snum, sname, 'больше одного покупателя' from salespeaple s 
where 1 < (select count(*) from customers where snum = s.snum)
union
select snum, sname, 'не больше одного покупателя'
from salespeaple s 
where 1 >= (select count(*) from customers where snum = s.snum);
