/* Подзапросы */
/* Простейшая форма подзапроса - сравнение нужного значения с результатом выполнения подзапроса
Подзапрос должен возвращать единственное значение */

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
					            sname = 'Петров');

					/* Если подзапрос может вернуть несколько значений, то возможно использование оператора IN во внешнем запросе */
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
					            sname = 'Петров');

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
										            city = 'Тверь');

										/* Список продаж покупателю с номером 201*/
SELECT 
    amount, sdate, salespeaple.sname
FROM
    sales
        NATURAL JOIN
	    salespeaple
	WHERE
	    snum IN (SELECT 
		            snum
			        FROM
				            sales
					        WHERE
						            cnum = 201);

						/* Комиссионные продавцов, обслуживающих покупателей из Санкт-Петербурга */
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

					/* Использование агрегатных функций в подзапросах */
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

					/* Пример использования выражений в подзапросе */            
SELECT 
    *
FROM
    sales
WHERE
    amount > (SELECT 
	            500 + AVG(amount)
		        FROM
			            sales
				        WHERE
					            sdate = '2024-09-12'
						                AND sdate < '2024-09-12' + INTERVAL 15 DAY);

							/* Подзапросы в предложении HAVING */
/* Находим, сколько групп покупателей имеют рейтинги больше, чем средний рейтинг по Новосибирску*/
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
