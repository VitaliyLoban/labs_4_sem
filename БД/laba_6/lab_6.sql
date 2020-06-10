use L_UNIVER
SELECT AUDITORIUM.AUDITORIUM, AUDITORIUM_TYPE.AUDITORIUM_TYPENAME FROM
AUDITORIUM INNER JOIN AUDITORIUM_TYPE ON AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE;
SELECT AUDITORIUM.AUDITORIUM, AUDITORIUM_TYPE.AUDITORIUM_TYPENAME FROM
AUDITORIUM INNER JOIN AUDITORIUM_TYPE ON AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE AND
AUDITORIUM_TYPE.AUDITORIUM_TYPENAME LIKE '%���������%';

SELECT AUDITORIUM.AUDITORIUM, AUDITORIUM_TYPE.AUDITORIUM_TYPENAME FROM AUDITORIUM, AUDITORIUM_TYPE
WHERE AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE;
SELECT T1.AUDITORIUM, T2.AUDITORIUM_TYPENAME FROM AUDITORIUM AS T1, AUDITORIUM_TYPE AS T2
WHERE T1.AUDITORIUM_TYPE = T2.AUDITORIUM_TYPE AND
T2.AUDITORIUM_TYPENAME LIKE '%���������%';

SELECT FACULTY.FACULTY [���������],PULPIT.PULPIT, PROGRESS.[SUBJECT], STUDENT.NAME, PROGRESS.NOTE,PROFESSION.PROFESSION_NAME,
CASE
WHEN (PROGRESS.NOTE = 6) THEN '�����'
WHEN (PROGRESS.NOTE = 7) THEN '����'
WHEN (PROGRESS.NOTE = 8) THEN '������'
END [������� ������ �� 6 �� 8]
FROM PROGRESS
INNER JOIN STUDENT ON STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
INNER JOIN GROUPS ON GROUPS.IDGROUP = STUDENT.IDGROUP
INNER JOIN PROFESSION ON GROUPS.PROFESSION = PROFESSION.PROFESSION
INNER JOIN [SUBJECT]  ON  [SUBJECT].[SUBJECT] = PROGRESS.[SUBJECT]
INNER JOIN PULPIT ON PULPIT.PULPIT = [SUBJECT].PULPIT
INNER JOIN FACULTY ON FACULTY.FACULTY = PULPIT.FACULTY
WHERE STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT AND PROGRESS.NOTE BETWEEN 6 AND 8 ORDER BY PROGRESS.NOTE DESC

SELECT FACULTY.FACULTY [���������],PULPIT.PULPIT, PROGRESS.[SUBJECT], STUDENT.NAME, PROGRESS.NOTE, PROFESSION.PROFESSION_NAME,
CASE
WHEN (PROGRESS.NOTE = 6) THEN '�����'
WHEN (PROGRESS.NOTE = 7) THEN '����'
WHEN (PROGRESS.NOTE = 8) THEN '������'
END [������� ������ �� 6 �� 8]
FROM PROGRESS 
INNER JOIN STUDENT ON STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
INNER JOIN GROUPS ON GROUPS.IDGROUP = STUDENT.IDGROUP
INNER JOIN PROFESSION ON GROUPS.PROFESSION = PROFESSION.PROFESSION
INNER JOIN [SUBJECT]  ON  [SUBJECT].[SUBJECT] = PROGRESS.[SUBJECT]
INNER JOIN PULPIT ON PULPIT.PULPIT = [SUBJECT].PULPIT
INNER JOIN FACULTY ON FACULTY.FACULTY = PULPIT.FACULTY
WHERE STUDENT.IDSTUDENT=PROGRESS.IDSTUDENT AND PROGRESS.NOTE BETWEEN 6 AND 8 
ORDER BY (CASE WHEN(PROGRESS.NOTE=7)THEN 1 WHEN (PROGRESS.NOTE=8)THEN 2 WHEN (PROGRESS.NOTE=6)THEN 3 END);

SELECT PULPIT.PULPIT[�������], ISNULL (TEACHER.TEACHER_NAME,'***')[�������������] FROM PULPIT LEFT OUTER JOIN TEACHER
ON PULPIT.PULPIT = TEACHER.PULPIT

SELECT isnull(TEACHER.TEACHER_NAME,'***')[�������������], PULPIT.PULPIT[�������] FROM TEACHER LEFT OUTER JOIN PULPIT 
ON PULPIT.PULPIT=TEACHER.PULPIT;

SELECT PULPIT.PULPIT[�������], ISNULL (TEACHER.TEACHER_NAME,'***')[�������������]  FROM TEACHER RIGHT OUTER JOIN PULPIT
ON PULPIT.PULPIT = TEACHER.PULPIT
 --9.1
SELECT * FROM TEACHER FULL OUTER JOIN PULPIT ON TEACHER.PULPIT = PULPIT.PULPIT
ORDER BY TEACHER_NAME

SELECT * FROM PULPIT FULL OUTER JOIN TEACHER ON TEACHER.PULPIT = PULPIT.PULPIT
ORDER BY TEACHER_NAME
--9.2
SELECT *FROM TEACHER LEFT OUTER JOIN PULPIT ON TEACHER.PULPIT = PULPIT.PULPIT
UNION
SELECT * FROM TEACHER RIGHT OUTER JOIN PULPIT ON TEACHER.PULPIT = PULPIT.PULPIT
ORDER BY TEACHER.TEACHER

--9.3
SELECT * FROM  PULPIT INNER JOIN TEACHER ON TEACHER.PULPIT=PULPIT.PULPIT
ORDER BY TEACHER.TEACHER
--10
SELECT * FROM TEACHER FULL OUTER JOIN PULPIT ON TEACHER.PULPIT = PULPIT.PULPIT
WHERE PULPIT.PULPIT IS NULL

SELECT * FROM TEACHER FULL OUTER JOIN PULPIT ON TEACHER.PULPIT = PULPIT.PULPIT
WHERE  TEACHER.PULPIT IS  NULL


SELECT * FROM TEACHER LEFT OUTER JOIN PULPIT ON TEACHER.PULPIT = PULPIT.PULPIT
WHERE PULPIT.PULPIT IS NULL
UNION
SELECT * FROM TEACHER INNER JOIN PULPIT ON TEACHER.PULPIT = PULPIT.PULPIT
UNION
SELECT * FROM TEACHER RIGHT OUTER JOIN PULPIT ON TEACHER.PULPIT = PULPIT.PULPIT
WHERE  TEACHER.PULPIT IS  NULL

SELECT * FROM TEACHER  INNER JOIN PULPIT ON TEACHER.PULPIT = PULPIT.PULPIT

--11
SELECT AUDITORIUM.AUDITORIUM, AUDITORIUM_TYPE.AUDITORIUM_TYPENAME FROM
AUDITORIUM CROSS JOIN AUDITORIUM_TYPE WHERE AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE;
GO

CREATE TABLE TIMETABLE
(
PARA INT,
[IDGROUP] INTEGER CONSTRAINT ID_GROUP_FK FOREIGN KEY REFERENCES GROUPS(IDGROUP),
AUDITORIUM NVARCHAR(20) CONSTRAINT TMTBL_AUDITORIUM_FK FOREIGN KEY REFERENCES AUDITORIUM(AUDITORIUM),
[SUBJECT] NVARCHAR(10) CONSTRAINT TMTBL_SUBJECT_FK FOREIGN KEY REFERENCES [SUBJECT](SUBJECT),
TEACHER NVARCHAR(10) CONSTRAINT TMTBL_TEACHER_FK FOREIGN KEY REFERENCES TEACHER(TEACHER),
[DAY OF THE WEEK] NVARCHAR(10)
)


INSERT INTO  TIMETABLE (PARA, IDGROUP, AUDITORIUM, [SUBJECT], TEACHER, [DAY OF THE WEEK])   
VALUES   (1, 2, '236-1','��','����','�������'),
		 (2, 1, '206-1','��','����','�������'),
		 (3, 5, '103-4','��','����','�������'),
		 (1, 4, '107-4','����','���','�������'),
		 (1, 5, '103-4','����','���','�������'),
		 (1, 6, '107-4','��','�����','�������'),
		 (1, 6, '107-4','��','�����','�������'),
		 (1, 6, '107-4','��','�����','�������')
GO

SELECT AUDITORIUM.AUDITORIUM_NAME[���������], isnull (TIMETABLE.AUDITORIUM, '��������� ���������')[������] 
FROM AUDITORIUM LEFT OUTER JOIN TIMETABLE
 ON AUDITORIUM.AUDITORIUM = TIMETABLE.AUDITORIUM 
 AND TIMETABLE.[DAY OF THE WEEK] = '�������'
 AND TIMETABLE.PARA = 1;


 SELECT TEACHER.TEACHER_NAME[���� � �������], TIMETABLE.PARA[����� ����] FROM TEACHER LEFT OUTER JOIN TIMETABLE
 ON TEACHER.TEACHER = TIMETABLE.TEACHER AND TIMETABLE.[DAY OF THE WEEK] = '�������'
 WHERE TIMETABLE.PARA IS NOT NULL

-----------------------------------------------------------------------------------------------------
SELECT * FROM AUDITORIUM FULL OUTER JOIN TIMETABLE ON AUDITORIUM.AUDITORIUM = TIMETABLE.AUDITORIUM
WHERE  TIMETABLE.AUDITORIUM IS  NULL AND TIMETABLE.[DAY OF THE WEEK] = '�������' 
AND TIMETABLE.PARA = 1


use L_My_Base
select ������.�����_������,������.������������_������ from ������ inner join ������ on  ������.ID_������ = ������.ID_������

select ������.�����_������,������.������������_������,
case
when (������.���� <3000) then '�������'
when (������.���� >4000) then '�������'
end[���������]
from ������
Inner join ������ On ������.ID_������=������.ID_������

SELECT ������.�����_������ ,����������.���������� FROM ���������� LEFT OUTER JOIN ������
ON ������.ID_��������� = ����������.ID_���������� order by ������.�����_������

SELECT  ������.�����_������,����������.���������� FROM  ������  Right OUTER JOIN ���������� 
ON ������.ID_��������� = ����������.ID_���������� order by ������.�����_������
