use L_UNIVER
SELECT * from TEACHER
select*from PROGRESS
select PULPIT,TEACHER from TEACHER
select TEACHER_NAME from TEACHER where PULPIT='����'
select TEACHER_NAME from TEACHER where PULPIT='����' OR PULPIT='������'
select TEACHER_NAME from TEACHER where PULPIT='����'AND GENDER='�'	
select TEACHER_NAME[��� �������������] from TEACHER where PULPIT!='����'AND GENDER!='�'
select distinct PULPIT from TEACHER
select AUDITORIUM_CAPACITY,AUDITORIUM from AUDITORIUM order by AUDITORIUM_CAPACITY
select distinct Top(2) AUDITORIUM_CAPACITY,AUDITORIUM_TYPE from AUDITORIUM order by AUDITORIUM_CAPACITY DESC;
select distinct SUBJECT,NOTE from  PROGRESS where NOTE between 8 AND 10
select distinct SUBJECT,PULPIT from SUBJECT where PULPIT in ('�����', '������','��' )
select PROFESSION_NAME[������������ �������������],QUALIFICATION[������������] from PROFESSION where QUALIFICATION like'%�����%'
create table #Data(��� nvarchar(100),����_�������� date)
INSERT INTO #Data( ���,����_��������) select NAME,BDAY  From STUDENT
select *from #Data
Select avg(NOTE) from PROGRESS where NOTE between 5 AND 10