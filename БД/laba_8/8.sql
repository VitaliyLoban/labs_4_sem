USE L_UNIVER;
GO
--Основное назначение группировки с помощью секции GROUP BY – разбиение множества строк, 
--сформированного  секциями FROM и WHERE, на группы в соответствии со значениями в заданных столбцах, 
--а также выполнение вычисле-ний над группами строк с помощью наиболее часто используемых функций

--1
SELECT MIN(AUDITORIUM_CAPACITY)[МИНИМАЛЬНАЯ ВМЕСТИТЕЛЬНОСТЬ],
MAX(AUDITORIUM_CAPACITY)[МАКСИМАЛЬНАЯ ВМЕСТИТЕЛЬНОСТЬ],
AVG(AUDITORIUM_CAPACITY)[СРЕДНЯЯ ВМЕСТИТЕЛЬНОСТЬ],
COUNT(*) [КОЛИЧЕСТВО АУДИТОРИЙ],
SUM(AUDITORIUM_CAPACITY)[СУММА ВСЕХ МЕСТ]
FROM AUDITORIUM

--2
SELECT  t1.AUDITORIUM_TYPENAME, 
sum(AUDITORIUM_CAPACITY)[СУММА ВСЕХ МЕСТ],
max(AUDITORIUM_CAPACITY)[MAX ВМЕСТИМОСТЬ],
MIN(AUDITORIUM_CAPACITY)[MIN ВМЕСТИМОСТЬ],
AVG(AUDITORIUM_CAPACITY)[СРЕДНЯЯ ВМЕСТИМОСТЬ],
COUNT(*)[ВСЕГО АУДИТОРИЙ]
FROM AUDITORIUM_TYPE t1 INNER JOIN AUDITORIUM t2 on t1.AUDITORIUM_TYPE = t2.AUDITORIUM_TYPE 
GROUP BY AUDITORIUM_TYPENAME;

--3
SELECT * FROM (SELECT CASE
WHEN NOTE = 10 THEN '10'
WHEN NOTE BETWEEN 8 AND 9 THEN '8-9'
WHEN NOTE BETWEEN 6 AND 7 THEN '6-7'
WHEN NOTE BETWEEN 4 AND 5 THEN '4-5'
ELSE 'МЕНЬШЕ 4-ЕХ'
END [ОЦЕНКИ], COUNT(*)[КОЛИЧЕСТВО]
FROM PROGRESS GROUP BY CASE

WHEN NOTE = 10 THEN '10'
WHEN NOTE BETWEEN 8 AND 9 THEN '8-9'
WHEN NOTE BETWEEN 6 AND 7 THEN '6-7'
WHEN NOTE BETWEEN 4 AND 5 THEN '4-5'
ELSE 'МЕНЬШЕ 4-ЕХ'
END)  AS T
ORDER BY CASE [Оценки]
	WHEN '10' then 1 
	WHEN '8-9' then 2
	WHEN '6-7' then 3
	WHEN '4-5' then 4
	ELSE 0
	END

--4
SELECT f.FACULTY, g.PROFESSION, 
round(avg(cast(pr.NOTE as float (4))),2)[Средний балл]
FROM FACULTY f 
 JOIN GROUPS g on f.FACULTY = g.FACULTY
 JOIN STUDENT s on g.IDGROUP = s.IDGROUP
 JOIN PROGRESS pr ON s.IDSTUDENT = pr.IDSTUDENT
GROUP BY f.FACULTY, g.PROFESSION

--5
SELECT f.FACULTY, g.PROFESSION, 
round(avg(cast(pr.NOTE as float (4))),2)[Средний балл]
FROM FACULTY f 
 JOIN GROUPS g on f.FACULTY = g.FACULTY
 JOIN STUDENT s on g.IDGROUP = s.IDGROUP
 JOIN PROGRESS pr ON s.IDSTUDENT = pr.IDSTUDENT
WHERE pr.[SUBJECT] in('БД','ОАиП')
GROUP BY f.FACULTY, g.PROFESSION

--6
SELECT f.FACULTY, gr.PROFESSION,  prg.[SUBJECT], AVG(prg.NOTE)[AVG NOTE]
FROM FACULTY f  JOIN GROUPS gr ON f.FACULTY = gr.FACULTY
 JOIN STUDENT std ON std.IDGROUP = gr.IDGROUP
 JOIN PROGRESS prg ON prg.IDSTUDENT = std.IDSTUDENT
WHERE f.FACULTY = 'ИДиП'
GROUP BY f.FACULTY, gr.PROFESSION, prg.[SUBJECT];

SELECT f.FACULTY, gr.PROFESSION,  prg.[SUBJECT], AVG(prg.NOTE)[AVG NOTE]
FROM FACULTY f  JOIN GROUPS gr ON f.FACULTY = gr.FACULTY
 JOIN STUDENT std ON std.IDGROUP = gr.IDGROUP
 JOIN PROGRESS prg ON prg.IDSTUDENT = std.IDSTUDENT
WHERE f.FACULTY = 'ИДиП'
GROUP BY ROLLUP (f.FACULTY, gr.PROFESSION, prg.[SUBJECT]);

--7
SELECT f.FACULTY, gr.PROFESSION,  prg.[SUBJECT], AVG(prg.NOTE)[AVG NOTE]
FROM FACULTY f  JOIN GROUPS gr ON f.FACULTY = gr.FACULTY
 JOIN STUDENT std ON std.IDGROUP = gr.IDGROUP
 JOIN PROGRESS prg ON prg.IDSTUDENT = std.IDSTUDENT
WHERE f.FACULTY = 'ИДиП'
GROUP BY CUBE (f.FACULTY, gr.PROFESSION, prg.[SUBJECT])

--8
SELECT f.FACULTY, gr.PROFESSION,  prg.SUBJECT, AVG(prg.NOTE)[AVG NOTE]
FROM FACULTY f  JOIN GROUPS gr ON f.FACULTY = gr.FACULTY
 JOIN STUDENT std ON std.IDGROUP = gr.IDGROUP
 JOIN PROGRESS prg ON prg.IDSTUDENT = std.IDSTUDENT
WHERE f.FACULTY = 'ИДиП'
GROUP BY ROLLUP (f.FACULTY, gr.PROFESSION, prg.[SUBJECT])
UNION
SELECT f.FACULTY, gr.PROFESSION,  prg.SUBJECT, AVG(prg.NOTE)[AVG NOTE]
FROM FACULTY f  JOIN GROUPS gr ON f.FACULTY = gr.FACULTY
 JOIN STUDENT std ON std.IDGROUP = gr.IDGROUP
 JOIN PROGRESS prg ON prg.IDSTUDENT = std.IDSTUDENT
WHERE f.FACULTY = 'ХТиТ'
GROUP BY ROLLUP (f.FACULTY, gr.PROFESSION, prg.[SUBJECT])

--8.2
SELECT f.FACULTY, gr.PROFESSION,  prg.SUBJECT, AVG(prg.NOTE)[AVG NOTE]
FROM FACULTY f  JOIN GROUPS gr ON f.FACULTY = gr.FACULTY
 JOIN STUDENT std ON std.IDGROUP = gr.IDGROUP
 JOIN PROGRESS prg ON prg.IDSTUDENT = std.IDSTUDENT
WHERE f.FACULTY = 'ИДиП'
GROUP BY ROLLUP (f.FACULTY, gr.PROFESSION, prg.[SUBJECT])
UNION ALL
SELECT f.FACULTY, gr.PROFESSION,  prg.SUBJECT, AVG(prg.NOTE)[AVG NOTE]
FROM FACULTY f  JOIN GROUPS gr ON f.FACULTY = gr.FACULTY
 JOIN STUDENT std ON std.IDGROUP = gr.IDGROUP
 JOIN PROGRESS prg ON prg.IDSTUDENT = std.IDSTUDENT
WHERE f.FACULTY = 'ХТиТ'
GROUP BY ROLLUP (f.FACULTY, gr.PROFESSION, prg.[SUBJECT])

--9
SELECT f.FACULTY, gr.PROFESSION,  prg.SUBJECT, AVG(prg.NOTE)[AVG NOTE]
FROM FACULTY f  JOIN GROUPS gr ON f.FACULTY = gr.FACULTY
 JOIN STUDENT std ON std.IDGROUP = gr.IDGROUP
 JOIN PROGRESS prg ON prg.IDSTUDENT = std.IDSTUDENT
WHERE f.FACULTY = 'ИДиП'
GROUP BY ROLLUP (f.FACULTY, gr.PROFESSION, prg.[SUBJECT])
INTERSECT
SELECT f.FACULTY, gr.PROFESSION,  prg.SUBJECT, AVG(prg.NOTE)[AVG NOTE]
FROM FACULTY f  JOIN GROUPS gr ON f.FACULTY = gr.FACULTY
 JOIN STUDENT std ON std.IDGROUP = gr.IDGROUP
 JOIN PROGRESS prg ON prg.IDSTUDENT = std.IDSTUDENT
WHERE f.FACULTY = 'ХТиТ'
GROUP BY ROLLUP (f.FACULTY, gr.PROFESSION, prg.[SUBJECT])

--10
SELECT f.FACULTY, gr.PROFESSION,  prg.SUBJECT, AVG(prg.NOTE)[AVG NOTE]
FROM FACULTY f  JOIN GROUPS gr ON f.FACULTY = gr.FACULTY
 JOIN STUDENT std ON std.IDGROUP = gr.IDGROUP
 JOIN PROGRESS prg ON prg.IDSTUDENT = std.IDSTUDENT
WHERE f.FACULTY = 'ИДиП'
GROUP BY ROLLUP (f.FACULTY, gr.PROFESSION, prg.[SUBJECT])
EXCEPT
SELECT f.FACULTY, gr.PROFESSION,  prg.SUBJECT, AVG(prg.NOTE)[AVG NOTE]
FROM FACULTY f  JOIN GROUPS gr ON f.FACULTY = gr.FACULTY
 JOIN STUDENT std ON std.IDGROUP = gr.IDGROUP
 JOIN PROGRESS prg ON prg.IDSTUDENT = std.IDSTUDENT
WHERE f.FACULTY = 'ХТиТ'
GROUP BY f.FACULTY, gr.PROFESSION, prg.[SUBJECT]

--11
SELECT  pr1.[SUBJECT], pr1.NOTE,
(SELECT COUNT(*) FROM PROGRESS pr2 WHERE pr1.[SUBJECT] = pr2.[SUBJECT] and pr2.NOTE = pr1.NOTE)[кол-во студентов]
 FROM PROGRESS pr1
 GROUP BY pr1.[SUBJECT], pr1.NOTE
 HAVING pr1.NOTE between 8 and 9
 ORDER BY [кол-во студентов] DESC;
 
 --for my base
 --qq
 use L_My_Base

SELECT  min(цена)   [Минимальная цена], 
        max(цена)   [Максимальная цена],  
        count(*)     [Количество товаров],
        sum(цена)   [ общая сумма]
From  Товары
--qq
select  j.ID_Товара,
		max(k.цена)
from заказы j inner join Товары k
on j.ID_Товара=k.ID_товара
and k.количество>1500
group by j.ID_Товара
--qq
select *from(select case
		when Количество between 1and 50 then 'малый заказ' 
		when Количество between 51and 100 then 'средний заказ' 
		when Количество between 101and 1000 then 'крупный заказ' 
		end [вид_заказа],count(*)[количество]
		from заказы group by case
		when Количество between 1and 50 then 'малый заказ' 
		when Количество between 51and 100 then 'средний заказ' 
		when Количество between 101and 1000 then 'крупный заказ' end)as T
		ORDER BY  Case [вид_заказа]
		when 'малый заказ' then 2
		when 'средний заказ' then 1 
		when 'крупный заказ' then 0
		 end
--qq
select  a.наименование_товара,
		b.покупатель,
		j.количество,
		a.цена,
		round(avg(cast(a.цена*j.Количество as float(4))),2)[стоимость]
		from Товары a inner join заказы j
		on a.ID_товара=j.ID_Товара
		inner join покупатели b
		on  b.ID_покупателя=j.ID_заказчика
		group by a.цена,a.наименование_товара,b.Покупатель,j.количество
		
	
	SELECT k.наименование_товара ,k.цена, k.количество 
	from товары k inner join Заказы j 
	on k.ID_товара=j.ID_Товара
	where k.наименование_товара like '%телефон%' or k.наименование_товара like '%ноутбук%'
	group by k.наименование_товара,k.цена,k.количество
	union
	--except
	--INTERSECT
	--union all
	SELECT k.наименование_товара ,k.цена, k.количество 
	from товары k inner join Заказы j 
	on k.ID_товара=j.ID_Товара
	where k.наименование_товара like '%планшет%' or k.наименование_товара like '%ноутбук%'
	group by k.наименование_товара,k.цена,k.количество