use L_My_Base

SELECT TOP(1)
(SELECT max(количество) FROM заказы WHERE ID_товара LIKE 1)[«начение ],
(SELECT max(количество) FROM заказы WHERE ID_товара LIKE 2)[«начение ],
(SELECT max(количество) FROM заказы WHERE ID_товара LIKE 3)[«начение ],
(SELECT max(количество) FROM заказы WHERE ID_товара LIKE 4)[«начение ],
(SELECT max(количество) FROM заказы WHERE ID_товара LIKE 5)[«начение ]
from заказы

select заказы.номер_заказа,“овары.наименование_товара
from заказы inner join товары
on заказы.ID_товара=товары.ID_“овара
and заказы.ID_заказчика in(select ID_покупател€ from покупатели where(ѕокупатель like '%Apple%'))

SELECT покупатель,телефон  FROM  покупатели f
WHERE  NOT EXISTS (SELECT * FROM заказы p
WHERE p.ID_заказчика = f.ID_покупател€)