use L_My_Base
select * from Товары
select Наименование_товара,цена from Товары
select Наименование_товара,цена from Товары where Цена=4145
select Наименование_товара,цена from Товары where Цена between 4100 and 4800
select Наименование_товара,цена[цена_товара] from Товары where Цена!=4145 and Цена!=4234
select distinct цена from Товары
select Наименование_товара,цена from Товары order by цена desc
select distinct Наименование_товара,цена from Товары where цена in(4777,2356)
select avg(цена)[средняя_цена_товаров]from Товары
