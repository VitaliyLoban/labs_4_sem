use L_My_Base

SELECT TOP(1)
(SELECT max(����������) FROM ������ WHERE ID_������ LIKE 1)[�������� ],
(SELECT max(����������) FROM ������ WHERE ID_������ LIKE 2)[�������� ],
(SELECT max(����������) FROM ������ WHERE ID_������ LIKE 3)[�������� ],
(SELECT max(����������) FROM ������ WHERE ID_������ LIKE 4)[�������� ],
(SELECT max(����������) FROM ������ WHERE ID_������ LIKE 5)[�������� ]
from ������

select ������.�����_������,������.������������_������
from ������ inner join ������
on ������.ID_������=������.ID_������
and ������.ID_��������� in(select ID_���������� from ���������� where(���������� like '%Apple%'))

SELECT ����������,�������  FROM  ���������� f
WHERE  NOT EXISTS (SELECT * FROM ������ p
WHERE p.ID_��������� = f.ID_����������)