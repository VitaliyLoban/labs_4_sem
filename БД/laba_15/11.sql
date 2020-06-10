use TMP_Bond_UNIVER
declare @pulp varchar(25),@t char(300)=' ';
--declare subje cursor for 
--select SUBJECT.SUBJECT from SUBJECT where PULPIT='ИСиТ'
open subje
fetch subje into @pulp
print 'Дисциплины '
while @@FETCH_STATUS=0
begin 
set @t= rtrim(@pulp)+','+@t
fetch subje into @pulp
end
set @t= SUBSTRING(@t,1,(len(@t)-1))
print @t
close subje
--2
go
 declare @tech varchar(30), @gen varchar (2)
 declare teachaer_1 cursor global  for 
 select TEACHER.TEACHER_NAME, TEACHER.GENDER from TEACHER 
 where TEACHER.GENDER='м'
 open  teachaer_1
 fetch teachaer_1 into @tech,@gen
 print @tech+' '+@gen
 go
  declare @tech varchar(30), @gen varchar (2)
  fetch teachaer_1 into @tech,@gen
 print @tech+' '+@gen
 go
 --3
 declare @rt varchar(20),@ry varchar(20), @ri varchar(20)
 declare stat_curs cursor local dynamic for
  select TEACHER,TEACHER.TEACHER_NAME, TEACHER.GENDER from TEACHER where TEACHER.PULPIT='ПОиСОИ'
open stat_curs
print 'Количество строк:'+ cast(@@CURSOR_ROWS as varchar(5))
update TEACHER set TEACHER_NAME='qwerty' where TEACHER='АРС'
delete TEACHER  where TEACHER='ШМК'
insert TEACHER (TEACHER,PULPIT) values ('AAA','ПОиСОИ')

fetch stat_curs into @rt,@ry,@ri
while @@FETCH_STATUS=0
begin
print @rt+' '+@ry+' '+@ri
fetch stat_curs into @rt,@ry,@ri
end
close stat_curs
select @@FETCH_STATUS
--4

close stat_curs
deallocate stat_curs
declare @rn int, @tc char(30)
declare teach cursor local dynamic scroll for 
select ROW_NUMBER() over (order by TEACHER_NAME) RN, TEACHER_NAME
from TEACHER where PULPIT='ИСиТ'
open teach
fetch teach into @rn,@tc
print 'следующая        '+cast (@rn as varchar(3))+'['+RTrim (@tc)+']'
fetch last from teach into @rn,@tc
print 'последняя        '+cast (@rn as varchar(3))+'['+RTrim (@tc)+']'
fetch first from teach into @rn,@tc
print ' первая          '+cast (@rn as varchar(3))+'['+RTrim (@tc)+']'
fetch absolute 7 from teach into @rn,@tc
print '7  с начала      '+cast (@rn as varchar(3))+'['+RTrim (@tc)+']'
fetch absolute -6 from teach into @rn,@tc
print '6  с конца       '+cast (@rn as varchar(3))+'['+RTrim (@tc)+']'
fetch relative 5 from teach into @rn,@tc
print '5 с текущей поз  '+cast (@rn as varchar(3))+'['+RTrim (@tc)+']'
fetch relative -5 from teach into @rn,@tc
print '5 назад с тек    '+cast (@rn as varchar(3))+'['+RTrim (@tc)+']'
fetch next from teach into @rn,@tc
print 'след   тек поз   '+cast (@rn as varchar(3))+'['+RTrim (@tc)+']'
fetch prior from teach into @rn,@tc
print 'предыдущ с текущ '+cast (@rn as varchar(3))+'['+RTrim (@tc)+']'
close teach
--5
--3
go
 declare @rt varchar(20),@ry varchar(20), @ri varchar(20)
 declare new_curs cursor local dynamic for
  select TEACHER,TEACHER.TEACHER_NAME, TEACHER.GENDER from TEACHER where TEACHER.PULPIT='ПОиСОИ' for update
open new_curs
fetch new_curs into @rt,@ry,@ri
delete TEACHER where current of new_curs
fetch new_curs into @rt,@ry,@ri
update TEACHER set TEACHER_NAME='xxнпщнЫВ' where current of new_curs
select * from TEACHER where TEACHER.PULPIT='ПОиСОИ'
--6
go

select * from PROGRESS
go
create view [down] as
 select * from PROGRESS
 go
 select * from info

delete  from info 
from info inner join down
on down.IDSTUDENT=info.IDSTUDENT
where down.NOTE=4

--8.2
declare @ids int , @note int
declare sel cursor local dynamic
for  select PROGRESS.IDSTUDENT, PROGRESS.NOTE
from PROGRESS for update
 open sel
 fetch relative 8 from sel into @ids,@note
print '  do  '+cast (@ids as varchar(20))+'['+RTrim (@note)+']'
 update PROGRESS set NOTE=NOTE+1 where  current of sel
 fetch relative 0  from sel into @ids,@note
 print 'posle    '+  cast(@ids as varchar(20)) +'['+RTrim (@note)+']'
 close sel


--12
use Yurashevich_MyBase
declare @idg varchar(50) , @stag int
declare st cursor  local dynamic
for select Driver.Имя, Driver.Стаж
from Driver for update
open st
fetch relative 2 from st into @idg,@stag
print 'before  '+ cast (@idg as varchar(50))+ '['+RTrim (@stag)+']'
update Driver set Стаж=Стаж+2  where current of st
fetch relative 0 from st into @idg,@stag
print 'after  '+ cast (@idg as varchar(50))+ '['+RTrim (@stag)+']'
close st
use TMP_Bond_UNIVER
--13
set nocount on
	if  exists (select * from  SYS.OBJECTS        -- таблица X есть?
	            where OBJECT_ID= object_id(N'DBO.X') )	            
	drop table X;           
	declare @c int, @flag char = 'c';           -- commit или rollback?
	SET IMPLICIT_TRANSACTIONS  ON   -- включ. режим неявной транзакции
	    create table X(K int );                         -- начало транзакции 
		insert X values (1),(2),(3);
		set @c = (select count(*) from X);
		print 'количество строк в таблице X: ' + cast( @c as varchar(2));
		if @flag = 'c'  commit;                   -- завершение транзакции: фиксация 
	          else      rollback;                              -- завершение транзакции: откат  
      SET IMPLICIT_TRANSACTIONS  OFF   -- выключ. режим неявной транзакции
	-- действует режим автофиксации
	if  exists (select * from  SYS.OBJECTS       -- таблица X есть?
	            where OBJECT_ID= object_id(N'DBO.X') )
	print 'таблица X есть';  else print 'таблицы X нет'

begin try
	begin tran                 -- начало  явной транзакции
		insert FACULTY values ('ДФ', 'Факультет других наук');
	    --insert FACULTY values ('ПиМ', 'Факультет print-технологий и медиакоммуникаций');
	commit tran;               -- фиксация транзакции
end try
begin catch
	print 'ошибка: '+ case 
		when error_number() = 2627 and patindex('%FACULTY_PK%', error_message()) > 0 then 'дублирование товара'
		else 'неизвестная ошибка: '+ cast(error_number() as  varchar(5))+ error_message()  
	end; 
	if @@trancount > 0 rollback tran; -- если значение больше нуля, то транзакция не завершена 	  
end catch;

select * from FACULTY;
declare @point varchar(32);
begin try
	begin tran                              

		set @point = 'p1'; 
		save tran @point;  -- контрольная точка p1

		insert STUDENT(IDGROUP, NAME, BDAY, INFO, FOTO) values (20,'Екатерина', '1997-08-02', NULL, NULL),
							  (20,'Александра', '1997-08-06', NULL, NULL),
							  (20,'Елизавета', '1997-08-01', NULL, NULL),
							  (20,'Ольга', '1997-08-03', NULL, NULL);    

		set @point = 'p2'; 
		save tran @point; -- контрольная точка p2 (перезаписали, назвали по-другому)

		insert STUDENT(IDGROUP, NAME, BDAY, INFO, FOTO) values (20, 'Особенный Студент', '1997-08-02', NULL, NULL); 
	commit tran;                                              
end try
begin catch
	print 'ошибка: '+ case 
		when error_number() = 2627 and patindex('%STUDENT_PK%', error_message()) > 0 then 'дублирование студента' 
		else 'неизвестная ошибка: '+ cast(error_number() as  varchar(5)) + error_message()  
	end; 
    if @@trancount > 0 -- если транзакция не завершена
	begin
	   print 'контрольная точка: '+ @point;
	   rollback tran @point; -- откат к последней контрольной точке
	   commit tran; -- фиксация изменений, выполненных до контрольной точки 
	end;     
end catch;

select * from STUDENT where IDGROUP=20; 
delete STUDENT where IDGROUP=20; 



--4. Разработать два сцена-рия: A и B на примере базы данных X_BSTU. 
--Сценарий A представляет собой явную транзакцию с уровнем изолированности READ UNCOMMITED, 
--сценарий B – явную транзакцию с уровнем изолированности READ COMMITED (по умолчанию). 
--Сценарий A должен демонстрировать, что уровень READ UNCOMMITED допускает неподтвержденное, 
--неповторяющееся и фантомное чтение. 


------A----------

set transaction isolation level READ UNCOMMITTED
begin transaction


-----t1----------

select @@SPID, 'insert FACULTY' 'результат', *
from FACULTY WHERE FACULTY = 'ИТ';
select @@SPID, 'update PULPIT' 'результат', *
from PULPIT WHERE FACULTY = 'ИТ';
commit;

-----t2----------

-----B-----------

begin transaction
select @@SPID
insert FACULTY VALUES ('ИТ2','Информационных технологий');
update PULPIT set FACULTY = 'ИТ' WHERE PULPIT = 'ИСиТ'

-----t1----------
-----t2----------

ROLLBACK;




--5. Разработать два сцена-рия: A и B на примере базы данных X_BSTU. 
--Сценарий A представляет собой явную транзакцию с уровнем изолированности READ COMMITED. 
--Сценарий B – явную транзакцию с уровнем изолированности READ COMMITED. 
--Сценарий A должен демонстрировать, что уровень READ COMMITED не допускает неподтвержденного чтения, 
--но при этом возможно  неповторяющееся и фантомное чтение. 

-----A--------

set transaction isolation level READ COMMITTED
begin transaction
select count(*) from PULPIT
where FACULTY = 'ИТ';

-----t1-------
-----t2-------

select 'update PULPIT' 'результат', count(*)
from PULPIT where FACULTY = 'ИТ';
commit;

------B----

begin transaction

------t1-----

update PULPIT set FACULTY = 'ИТ' where PULPIT = 'ИСиТ';
commit;

------t2------

--6. Разработать два сцена-рия: A и B на примере базы данных X_BSTU. 
--Сценарий A представляет собой явную транзакцию с уровнем изолированности REPEATABLE READ. 
--Сце-нарий B – явную транзакцию с уровнем изолированности READ COMMITED. 

--------A---------

set transaction isolation level REPEATABLE READ
begin transaction
select TEACHER FROM TEACHER
WHERE PULPIT = 'ПОиСОИ';

--------t1---------
--------t2---------

select case
    when TEACHER = 'ПТР' THEN 'insert TEACHER'
	else ' '
	end 'результат', TEACHER
FROM TEACHER WHERE PULPIT = 'ПОиСОИ';
commit;

--- B ---	
begin transaction 	  
--- t1 --------------------
insert TEACHER values ('ИИИ', 'Иванов Иван Иванович', 'м', 'ИСиТ                ');
commit; 
--- t2 --------------------

select * from TEACHER

--7. Разработать два сцена-рия: A и B на примере базы данных X_BSTU. 
--Сценарий представляет собой явную транзакцию с уровнем изолированности SNAPSHOT. 
--Сценарий B – явную транзакцию с уровнем изолированности READ COM-MITED. 

   use master;
	go
	alter database TMP_Bond_UNIVER set allow_snapshot_isolation on


	-- A ---
    set transaction isolation level SNAPSHOT 
	begin transaction 
	waitfor delay '00:00:05'
	select TEACHER from TEACHER where PULPIT = 'ПОиСОИ';

	-------------------------- t1 ------------------ 
          delete TEACHER where TEACHER = 'АРС';  
          insert TEACHER values ('ИВН', 'Иванов Сергей Борисович', 'м', 'ПОиСОИ              ');
          update TEACHER set TEACHER = 'ШМКВ' where TEACHER = 'ШМК';
	-------------------------- t2 -----------------
	select TEACHER from TEACHER  where PULPIT = 'ПОиСОИ';
	commit; 
	
	
	--- B ---	


	begin transaction 	  
	waitfor delay '00:00:05'
	-------------------------- t1 --------------------
delete TEACHER where TEACHER = 'ЮДНКВ';  
          insert TEACHER values ('ПТР', 'Петров Петр Петрович', 'м', 'ПОиСОИ');
          update TEACHER set TEACHER = 'БРТ' where TEACHER = 'БРТШВЧ';
          commit; 
	-------------------------- t2 --------------------


--8. Разработать два сцена-рия: A и B на примере базы данных X_BSTU. 
--Сценарий представляет собой явную транзакцию с уровнем изолированности SE-RIALIZABLE. 
--Сценарий B – явную транзакцию с уровнем изолированности READ COM-MITED. 
--Сценарий A должен демонстрировать отсутствие фантомного, неподтвержденного и не-повторяющегося чтения.

use TMP_Bond_UNIVER;
      -- A ---
          set transaction isolation level SERIALIZABLE 
	begin transaction 
		  delete TEACHER where TEACHER = 'АРС';  
          insert TEACHER values ('ИВНaф', 'Ивановaф Сергей Борисович', 'м', 'ЛУ');
          update TEACHER set TEACHER = 'ШМКВ' where TEACHER = 'ШМК';
          select TEACHER from TEACHER  where PULPIT = 'ЛУ';
	-------------------------- t1 -----------------
	begin tran
	 select TEACHER from TEACHER  where PULPIT = 'ЛУ';
	-------------------------- t2 ------------------ 
	commit; 	
	--- B ---	
	begin transaction 	  
	delete TEACHER where TEACHER = 'АРС';  
          insert TEACHER values ('ИВНa', 'Ивановa Сергей Борисович', 'м', 'ПОиСОИ              ');
          update TEACHER set TEACHER = 'ШМКВ' where TEACHER = 'ШМК';
          select TEACHER from TEACHER  where PULPIT = 'ЛУ';
          -------------------------- t1 --------------------
          commit; 
           select TEACHER from TEACHER  where PULPIT = 'ЛУ';
      -------------------------- t2 --------------------







--9-- ВЛОЖЕННЫЕ ТРАНЗАКЦИИ
-- Транзакция, выполняющаяся в рамках другой транзакции, называется вложенной. 
-- оператор COMMIT вложенной транзакции действует только на внутренние операции вложенной транзакции; 
-- оператор ROLLBACK внешней транзакции отменяет зафиксированные операции внутренней транзакции; 
-- оператор ROLLBACK вложенной транзакции действует на опе-рации внешней и внутренней транзакции, 
-- а также завершает обе транзакции; 
-- уровень вложенности транзакции можно определить с помощью системной функции @@TRANCOUT. 

select (select count(*) from dbo.PULPIT where FACULTY = 'ИДиП') 'Кафедры ИДИПа', 
(select count(*) from FACULTY where FACULTY.FACULTY = 'ИДиП') 'ИДИП'; 

select * from PULPIT

begin tran
	begin tran
	update PULPIT set PULPIT_NAME='Кафедра ИДиПа' where PULPIT.FACULTY = 'ИДиП';
	commit;
if @@TRANCOUNT > 0 rollback;

-- Здесь внутренняя транзакция завершается фиксацией своих операций; 
-- оператор ROLLBACK внешней транзакции отменяет зафиксированные операции внутренней транзакции. 