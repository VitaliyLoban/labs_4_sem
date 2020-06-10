use L_UNIVER;
--Триггер – это особый вид хранимой процедуры, предназначенной для обработки событий в БД.
-- Поддерживается два типа триггеров: DDL-триггеры и DML-триггеры. 

-- 1
--Разработать AFTER-триггер с именем TR_TEACHER_INS для таблицы TEACHER, 
--реагирующий на событие INSERT. Триггер TR_TEACHER_INS должен записывать стро-ки вводимых 
--данных в таблицу TR_AUDIT. В столбец СС помещаются значения столбцов вводимой строки. 

--Триггеры типа AFTER исполняются после выполнения оператора, вы-звавшего соответствующее событие.

go 
create table TR_AUDIT--вспомогательная таблица для отражения информации об операциях
(
ID int identity,--номер
STMT varchar(20) --DML оператор(сюда триггер помещает событие,на кот. он среагировал)
check (STMT in ('INS', 'DEL', 'UPD')),
TRNAME varchar(50), --имя триггера
CC varchar(300) -- коммент(значения столбцов вводимой строки из псевдотабл INSERTED)
--Эта таблица создается автоматически и в нее помещаются строки, добавленные оператором INSERT. 
)
	go
    create  trigger TR_TEACHER_INS 
      on TEACHER after INSERT  
      as
      declare @a1 char(10), @a2 varchar(100), @a3 char(1), @a4 char(20), @in varchar(300);
      print 'Вставка';
      set @a1 = (select TEACHER from INSERTED);
      set @a2= (select TEACHER_NAME from INSERTED);
      set @a3= (select GENDER from INSERTED);
	  set @a4 = (select PULPIT from INSERTED);
      set @in = @a1+' '+ @a2 +' '+ @a3+ ' ' +@a4;
      insert into TR_AUDIT(STMT, TRNAME, CC)  
                            values('INS', 'TR_TEACHER_INS', @in);	         
      return;  
      go

	  insert into  TEACHER values('Ив', 'Иванов', 'м', 'ИСиТ');
	  select * from TR_AUDIT

--2

--Создать AFTER-триггер с именем TR_TEACHER_DEL для таблицы TEACHER, реагирующий 
--на событие DELETE. Триггер TR_TEACHER_DEL должен записывать стро-ку данных в таблицу TR_AUDIT 
--для каждой удаляемой строки. В столбец СС помещаются значения столбца TEACHER удаляемой стро-ки. 

go
    create  trigger TR_TEACHER_DEL 
      on TEACHER after DELETE  
      as
      declare @a1 char(10), @a2 varchar(100), @a3 char(1), @a4 char(20), @in varchar(300);
      print 'Удаление';
      set @a1 = (select TEACHER from DELETED);
      set @a2= (select TEACHER_NAME from DELETED);
      set @a3= (select GENDER from DELETED);
	  set @a4 = (select PULPIT from DELETED);
      set @in = @a1+' '+ @a2 +' '+ @a3+ ' ' +@a4;
      insert into TR_AUDIT(STMT, TRNAME, CC)  
                            values('DEL', 'TR_TEACHER_DEL', @in);	         
      return;  
      go

	  delete TEACHER where TEACHER='Ив'
	  select * from TR_AUDIT

--3

--Создать AFTER-триггер с именем TR_TEACHER_UPD для таблицы TEACHER, реагирующий на событие UPDATE. 
--Триггер TR_TEACHER_UPD должен записывать стро-ку данных в таблицу TR_AUDIT для каждой изменяемой строки. 
--В столбец СС помещаются значения всех столбцов изменяемой строки до и после изменения.

go
    alter  trigger TR_TEACHER_DEL 
      on TEACHER after UPDATE  
      as
      declare @a1 char(10), @a2 varchar(100), @a3 char(1), @a4 char(20), @in varchar(300);
	  declare @ins int = (select count(*) from inserted),
              @del int = (select count(*) from deleted); 

      print 'Обновление';
      set @a1 = (select TEACHER from INSERTED);
      set @a2= (select TEACHER_NAME from INSERTED);
      set @a3= (select GENDER from INSERTED);
	  set @a4 = (select PULPIT from INSERTED);
      set @in = @a1+' '+ @a2 +' '+ @a3+ ' ' +@a4;
      set @a1 = (select TEACHER from deleted);
      set @a2= (select TEACHER_NAME from DELETED);
      set @a3= (select GENDER from DELETED);
	  set @a4 = (select PULPIT from DELETED);
      set @in =@in + '' + @a1+' '+ @a2 +' '+ @a3+ ' ' +@a4;
      insert into TR_AUDIT(STMT, TRNAME, CC)  
                            values('UPD', 'TR_TEACHER_UPD', @in);	         
      return;  
      go

	  update TEACHER set GENDER = 'ж' where TEACHER='Кирд'
	  select * from TR_AUDIT

	  delete from TR_AUDIT where STMT = 'UPD'

--4 

--Создать AFTER-триггер с именем TR_TEACHER для таблицы TEACHER, реа-гирующий на события 
--INSERT, DELETE, UPDATE. Триггер TR_TEACHER должен за-писывать строку данных в таблицу TR_AUDIT 
--для каждой изменяемой строки. В коде тригге-ра определить событие, активизировавшее триггер и 
--поместить в столбец СС соответству-ющую событию информацию. Разработать сце-нарий, демонстрирующий 
--работоспособность триггера. 

--Событие INSERT приводит к тому, что в таблицу INSERTED помещаются строки, добавленные оператором INSERT, вызвавшим это событие. Таблица DELETED остается пустой. 
--При возникновении события DELETE в таблицу DELETED копируются удаленные строки, а таблица INSERTED остается пустой. 
--При изменении строк таблицы с помощью оператора UPDATE заполняют-ся обе псевдотаблицы, при этом  INSERTED содержит обновленные версии строк, а таблица  DELETED  версию строк до их изменения.
go
create trigger TR_TEACHER   on TEACHER after INSERT, DELETE, UPDATE  
 as declare @a1 char(10), @a2 varchar(100), @a3 char(1), @a4 char(20), @in varchar(300);
	  declare @ins int = (select count(*) from inserted),
              @del int = (select count(*) from deleted); 
   if  @ins > 0 and  @del = 0
   begin
   print 'Событие: INSERT';
      set @a1 = (select TEACHER from INSERTED);
      set @a2= (select TEACHER_NAME from INSERTED);
      set @a3= (select GENDER from INSERTED);
	  set @a4 = (select PULPIT from INSERTED);
      set @in = @a1+' '+ @a2 +' '+ @a3+ ' ' +@a4;
      insert into TR_AUDIT(STMT, TRNAME, CC)  
                            values('INS', 'TR_TEACHER_INS', @in);	
	 end;
	else		  	 
    if @ins = 0 and  @del > 0
	begin
	print 'Событие: DELETE';
      set @a1 = (select TEACHER from DELETED);
      set @a2= (select TEACHER_NAME from DELETED);
      set @a3= (select GENDER from DELETED);
	  set @a4 = (select PULPIT from DELETED);
      set @in = @a1+' '+ @a2 +' '+ @a3+ ' ' +@a4;
      insert into TR_AUDIT(STMT, TRNAME, CC)  
                            values('DEL', 'TR_TEACHER_DEL', @in);
	  end;
	else	  
    if @ins > 0 and  @del > 0
	begin
	print 'Событие: UPDATE'; 
      set @a1 = (select TEACHER from INSERTED);
      set @a2= (select TEACHER_NAME from INSERTED);
      set @a3= (select GENDER from INSERTED);
	  set @a4 = (select PULPIT from INSERTED);
      set @in = @a1+' '+ @a2 +' '+ @a3+ ' ' +@a4;
      set @a1 = (select TEACHER from deleted);
      set @a2= (select TEACHER_NAME from DELETED);
      set @a3= (select GENDER from DELETED);
	  set @a4 = (select PULPIT from DELETED);
      set @in =@in + '' + @a1+' '+ @a2 +' '+ @a3+ ' ' +@a4;
      insert into TR_AUDIT(STMT, TRNAME, CC)  
                            values('UPD', 'TR_TEACHER_UPD', @in); 
	  end;
	  return;  

	  delete TEACHER where TEACHER='Ив'
	  insert into  TEACHER values('Ив', 'Иванов', 'м', 'ИСиТ');
	  	  update TEACHER set GENDER = 'ж' where TEACHER='Кирд'
	  select * from TR_AUDIT

--5--Разработать сценарий, который демонстрирует на примере базы данных X_BSTU, что провер-ка
-- ограничения целостности выполняется до срабатывания AFTER-триггера.

--!!!!AFTER-триггера он вызывается после выполнения активизирующего его оператора. Поэтому, 
--если оператор нарушает ограничение целостности, то возникшая ошибка не допускает вы-полнения этого оператора и соответствующих  триггеров.

 
 alter table AUDITORIUM
	add constraint AUDITORIUM_CAPACITY  check(  AUDITORIUM_CAPACITY<=1005)
	go 	
	update AUDITORIUM set  AUDITORIUM_CAPACITY = 10000 where AUDITORIUM_NAME = '103-4';

--6
--Создать для таблицы TEACHER три AFTER-триггера с именами: TR_TEACHER_ DEL1, TR_TEACHER_DEL2 и TR_TEACHER_ DEL3. 
--Триггеры должны реагировать на собы-тие DELETE и формировать соответствующие строки в таблицу TR_AUDIT. 
-- Получить полный список триггеров, связан-ных с таблицей TEACHER. Упорядочить вы-полнение триггеров для 
--таблицы TEACHER, реагирующих на событие DELETE следующим образом: первым должен выполняться триггер с 
--именем TR_TEACHER_DEL3, последним – триггер TR_TEACHER_DEL2. 
--Примечание: использовать системные пред-ставления SYS.TRIGGERS и SYS.TRIGGERS_ EVENTS, 
--а также систем-ную процедуру SP_SETTRIGGERORDERS. 


Insert into FACULTY(FACULTY) values ('Кирдун')
--use S_UNIVER
	go   
create trigger AUD_AFTER_DEL1 on FACULTY after DELETE  
as print 'AUD_AFTER_DEL_1';
 return;  
go 
create trigger AUD_AFTER_DEL2 on FACULTY after DELETE  
as print 'AUD_AFTER_DEL_2';
 return;  
go  
create trigger AUD_AFTER_DEL3 on FACULTY after DELETE  
as print 'AUD_AFTER_DEL_3';
 return;  
go    

--Проверить порядок выполнения триггеров можно с помощью запроса:
select t.name, e.type_desc 
  from sys.triggers  t join  sys.trigger_events e  on t.object_id = e.object_id  
  where OBJECT_NAME(t.parent_id)='FACULTY' and e.type_desc = 'DELETE' ;  
--Изменение порядка выполнения триггеров:	
exec  SP_SETTRIGGERORDER @triggername = 'AUD_AFTER_DEL3', 
	                        @order='First', @stmttype = 'DELETE';
exec  SP_SETTRIGGERORDER @triggername = 'AUD_AFTER_DEL2', 
	                        @order='Last', @stmttype = 'DELETE';

select t.name, e.type_desc 
  from sys.triggers  t join  sys.trigger_events e  on t.object_id = e.object_id  
  where OBJECT_NAME(t.parent_id)='FACULTY' and e.type_desc = 'DELETE';
 
--7

--Разработать сценарий, демонстрирующий на примере базы данных X_BSTU утверждение: 
--AFTER-триггер является частью транзакции,в рамках кот выполняется оператор,активизировавший триггер.


use L_UNIVER
go 
	create trigger PTran 
	on PULPIT after INSERT, DELETE, UPDATE  
	as declare @c int = (select count (*) from PULPIT); 	 
	 if (@c >26) 
	 begin
       raiserror('Общее количество кафедр не может быть >26', 10, 1);
	 rollback; 
	 end; 
	 return;          

	insert into PULPIT values ('ТТПЛ', 'EE', 'ИТ')

--8

--Создать для таблицы FACULTY INSTEAD OF-триггер, запрещающий удаление строк в таблице. 
--Разработать сценарий, который демонстри-рует на примере базы данных X_BSTU, 
--что проверка ограничения целостности выполнена, если есть INSTEADOF-триггер.

--С помощью оператора DROP удалить все DML-триггеры, созданные в этой лабораторной работе.

--Триггер типа INSTEAD OF выполняется вместо оператора, вызвавшего событие. 
--Выполнение INSTEADOF-триггера предшествует проверке установленных для таблицы ограничений целостности.


	go 
	create trigger F_INSTEAD_OF --
	on FACULTY instead of DELETE 
	as 
raiserror(N'Удаление запрещено', 10, 1);
	return;

	 delete FACULTY where FACULTY = 'ИДиП'

	 drop trigger F_INSTEAD_OF
	 drop trigger PTran
	 drop trigger TR_TEACHER
	 drop trigger TR_TEACHER_DEL
	 drop trigger TR_TEACHER_INS
	 drop trigger AUD_AFTER_DEL1
	 drop trigger AUD_AFTER_DEL2
	 drop trigger AUD_AFTER_DEL3
	 
	
go

--задание №9 DDL-trigger
create trigger DDPROGRESSs on database
for DDL_DATABASE_LEVEL_EVENTS 
as declare  @t varchar(50) = EVENTDATA().value('(/EVENT_INSTANCE/EventType)[1]','varchar(50)');
declare  @t1 varchar(50) = EVENTDATA().value('(/EVENT_INSTANCE/EventType)[1]','varchar(50)');
declare  @t2 varchar(50) = EVENTDATA().value('(/EVENT_INSTANCE/EventType)[1]','varchar(50)');

if @t1='SESSIA'
begin
print 'Тип события: '+@t;
print 'Имя объекта: '+@t1;
print 'Тип события: '+@t2;
raiserror(N'операции с таблицей SESSIA запрещены',16,1);
rollback;
end;

alter table SESSIA drop Column SUBJ
------------------------------------------------------МОЯ БД-------------------------------------------------
----DDl-тригер которыйзапрещает вносить изменения в таблицу
--use L_MyBase
--go	
--	create  trigger DDL_PRODAJI1 on database 
--	for DDL_DATABASE_LEVEL_EVENTS  
--          as   declare @t varchar(50)= EVENTDATA().value('(/EVENT_INSTANCE/EventType)[1]', 'varchar(50)');
--          declare @t1 varchar(50)= 	 EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]', 'varchar(50)');
--          declare @t2 varchar(50)= 	 EVENTDATA().value('(/EVENT_INSTANCE/ObjectType)[1]', 'varchar(50)'); 
--  if @t1 = 'ТОВАРЫ1' 
--   begin
--   print 'Тип события: '+@t;
--   print 'Имя объекта: '+@t1;
--   print 'Тип объекта: '+@t2;
--   raiserror( N'операции с таблицей Товары запрещены', 16, 1);  
--   rollback;    
--   end;

--   alter table ТОВАРЫ1 Drop Column  Количество_на_складе;

--   -------------------------------------------------------------6------------------------
--   use Товары
--	go   
--create trigger AUD_AFTER_UPDA on Товары after UPDATE  
--as print 'AUD_AFTER_UPDATE_A';
-- return;  
--go 
--create trigger AUD_AFTER_UPDB on Товары after UPDATE  
--as print 'AUD_AFTER_UPDATE_B';
-- return;  
--go  
--create trigger AUD_AFTER_UPDC on Товары after UPDATE  
--as print 'AUD_AFTER_UPDATE_C';
-- return;  
--go    

--select t.name, e.type_desc 
--  from sys.triggers  t join  sys.trigger_events e  on t.object_id = e.object_id  
--  where OBJECT_NAME(t.parent_id)='Товары' and 
--	                                                                        e.type_desc = 'UPDATE' ;  
--exec  SP_SETTRIGGERORDER @triggername = 'AUD_AFTER_UPDC', 
--	                        @order='First', @stmttype = 'UPDATE';
--exec  SP_SETTRIGGERORDER @triggername = 'AUD_AFTER_UPDA', 
--	                        @order='Last', @stmttype = 'UPDATE';

--							select t.name, e.type_desc 
--  from sys.triggers  t join  sys.trigger_events e  on t.object_id = e.object_id  
--  where OBJECT_NAME(t.parent_id)='Товары' and 
---------------------------------------8------------------
--use Товары
--	go 
--	create trigger Tov_INSTEAD_OF 
--	on Товары instead of DELETE 
--	as 
--raiserror (N'Удаление запрещено', 10, 1);
--	return;

--delete from Товары where Наименование = 'Молоко';  	                                                                        e.type_desc = 'UPDATE' ;  