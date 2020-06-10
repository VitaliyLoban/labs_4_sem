use L_UNIVER
SELECT * from TEACHER
select*from PROGRESS
select PULPIT,TEACHER from TEACHER
select TEACHER_NAME from TEACHER where PULPIT='ИСиТ'
select TEACHER_NAME from TEACHER where PULPIT='ИСиТ' OR PULPIT='ПОиСОИ'
select TEACHER_NAME from TEACHER where PULPIT='ИСиТ'AND GENDER='ж'	
select TEACHER_NAME[Имя преподователя] from TEACHER where PULPIT!='ИСиТ'AND GENDER!='ж'
select distinct PULPIT from TEACHER
select AUDITORIUM_CAPACITY,AUDITORIUM from AUDITORIUM order by AUDITORIUM_CAPACITY
select distinct Top(2) AUDITORIUM_CAPACITY,AUDITORIUM_TYPE from AUDITORIUM order by AUDITORIUM_CAPACITY DESC;
select distinct SUBJECT,NOTE from  PROGRESS where NOTE between 8 AND 10
select distinct SUBJECT,PULPIT from SUBJECT where PULPIT in ('ЛЗиДВ', 'ПОиСОИ','ОВ' )
select PROFESSION_NAME[Наименование специальности],QUALIFICATION[Квалификация] from PROFESSION where QUALIFICATION like'%химик%'
create table #Data(ФИО nvarchar(100),Дата_рождения date)
INSERT INTO #Data( ФИО,Дата_рождения) select NAME,BDAY  From STUDENT
select *from #Data
Select avg(NOTE) from PROGRESS where NOTE between 5 AND 10