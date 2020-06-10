create table TR_AUDIT
(
ID int identity,
STMT varchar(20)
check (STMT in ('INS', 'DEL', 'UPD')),
TRNAME varchar(50),
CC varchar(300)
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
--2
create trigger TR_TEACHER_DEL
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

	  delete TEACHER where TEACHER='Кирд'
	  select * from TR_AUDIT

	  --3
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

	  insert into  TEACHER values('Кирд', 'Кирдун', 'м', 'ИСиТ');
	  select * from TR_AUDIT
go
create trigger TRR_TEACHER   on TEACHER after INSERT, DELETE, UPDATE  
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

	  delete TEACHER where TEACHER='Кирд'
	  insert into  TEACHER values('Кирд', 'Кирдун', 'м', 'ИСиТ');
	  	  update TEACHER set GENDER = 'ж' where TEACHER='Кирд'
	  select * from TR_AUDIT
----------5
update TEACHER set GENDER = 'м' where TEACHER='Кирд'
 select * from TR_AUDIT

 ---next
 go
 use TMP_Bond_UNIVER
 	go  
	 
create trigger AUD_AFTER_DEL1 on FACULTY after DELETE  
as print 'AUD_AFTER_DEL1';
 return;  
go 
create trigger AUD_AFTER_DEL2 on FACULTY after DELETE  
as print 'AUD_AFTER_DEL2';
 return;  
go  
create trigger AUD_AFTER_DEL3 on FACULTY after DELETE  
as print 'AUD_AFTER_DEL3';
 return;  
go  
create trigger PTran 
	on PULPIT after INSERT, DELETE, UPDATE  
	as declare @c int = (select count (*) from PULPIT); 	 
	 if (@c >26) 
	 begin
       raiserror('Общая количество кафедр не может быть >26', 10, 1);
	 rollback; 
	 end; 
	 return;          

	insert into PULPIT(PULPIT) values ('ТТПЛ')

---------------------\\\\\\\\\\\\\\\\LAST\\\\\\\\\\\\--------------
go
use TMP_Bond_UNIVER;

--1

go
select PULPIT.FACULTY[факультет/@код], TEACHER.PULPIT[факультет/кафедра/@код],
	TEACHER.TEACHER_NAME[факультет/кафедра/преподаватель/@код]
		from TEACHER inner join PULPIT
			on TEACHER.PULPIT = PULPIT.PULPIT
				where TEACHER.PULPIT = 'ИСиТ' for xml path, root('Список_преподавателей_кафедры_ИСиТ');

--2

go
select AUDITORIUM.AUDITORIUM [Аудитория],
           AUDITORIUM.AUDITORIUM_TYPE [Наименование_типа], 
           AUDITORIUM.AUDITORIUM_CAPACITY [Вместимость] 
           from  AUDITORIUM join AUDITORIUM_TYPE
			on AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE
   where AUDITORIUM.AUDITORIUM_TYPE = 'ЛК' for xml AUTO, root('Список_аудиторий'), elements;

--3

go
declare @h int = 0,
@sbj varchar(3000) = '<?xml version="1.0" encoding="windows-1251" ?>
                      <дисциплины> 
                         <дисциплина код="КГиГ" название="Компьютерная геометрия и графикаа" кафедра="ИСиТ" /> 
                         <дисциплина код="ОЗИ" название="Основы защиты информации" кафедра="ИСиТ" /> 
						 <дисциплина код="МПп" название="Математическое программированиее" кафедра="ИСиТ" /> 
                      </дисциплины>';
exec sp_xml_preparedocument @h output, @sbj;
insert SUBJECT select [код], [название], [кафедра] from openxml(@h, '/дисциплины/дисциплина', 0)
	with([код] char(10), [название] varchar(100), [кафедра] char(20));      

--4
insert into STUDENT(IDGROUP, NAME, BDAY, INFO) values(22, 'Юрашевич Д.Э.', '12.10.1997', 
                                                         '<студент>
														    <паспорт серия="КН" номер="12345689" дата="15.03.2014" />
															<телефон>+375255689653</телефон>
															<адрес>
															   <страна>Беларусь</страна>
															   <город>Минск</город>
															   <улица>Белорусская</улица>
															   <дом>21</дом>
															   <квартира>1203</квартира>
															</адрес>
														  </студент>');
select * from STUDENT where NAME = 'Юрашевич Д.Э.';
update STUDENT set INFO = '<студент>
						      <паспорт серия="МС" номер="1328132" дата="15.03.2015" />
								<телефон>+375337897898</телефон>
								<адрес>
									<страна>Беларусь</страна>
									<город>Минск</город>
									<улица>Белорусская</улица>
									<дом>21</дом>
									<квартира>1203</квартира>
								</адрес>
							</студент>'
where NAME = 'Юрашевич Д.Э.';
select NAME[ФИО], INFO.value('(студент/паспорт/@серия)[1]', 'char(2)')[Серия паспорта],
	INFO.value('(студент/паспорт/@номер)[1]', 'varchar(20)')[Номер паспорта],
	INFO.query('/студент/адрес')[Адрес]
		from  STUDENT
			where NAME = 'Юрашевич Д.Э.';       

--5
go
create xml schema collection Student as 
N'<?xml version="1.0" encoding="utf-16" ?>
<xs:schema attributeFormDefault="unqualified" 
   elementFormDefault="qualified"
   xmlns:xs="http://www.w3.org/2001/XMLSchema">
<xs:element name="студент">
<xs:complexType><xs:sequence>
<xs:element name="паспорт" maxOccurs="1" minOccurs="1">
  <xs:complexType>
    <xs:attribute name="серия" type="xs:string" use="required" />
    <xs:attribute name="номер" type="xs:unsignedInt" use="required"/>
    <xs:attribute name="дата"  use="required">
	<xs:simpleType>  <xs:restriction base ="xs:string">
		<xs:pattern value="[0-9]{2}.[0-9]{2}.[0-9]{4}"/>
	 </xs:restriction> 	</xs:simpleType>
     </xs:attribute>
  </xs:complexType>
</xs:element>
<xs:element maxOccurs="3" name="телефон" type="xs:unsignedInt"/>
<xs:element name="адрес">   <xs:complexType><xs:sequence>
   <xs:element name="страна" type="xs:string" />
   <xs:element name="город" type="xs:string" />
   <xs:element name="улица" type="xs:string" />
   <xs:element name="дом" type="xs:string" />
   <xs:element name="квартира" type="xs:string" />
</xs:sequence></xs:complexType>  </xs:element>
</xs:sequence></xs:complexType>
</xs:element></xs:schema>';

alter table STUDENT alter column INFO xml(Student);

drop XML SCHEMA COLLECTION Student;

select Name, INFO from STUDENT where NAME='Юрашевич Д.Э.'
 use Yurashevich_MyBase

 go
 create table TR_AUDITR
(
ID int identity,
STMT varchar(20)
check (STMT in ('INS', 'DEL', 'UPD')),
TRNAME varchar(50),
CC varchar(300)
)
go
create  trigger TR_TEACHER_INSjjj
      on Driver after INSERT  
      as
      declare @a1 char(10), @a2 varchar(100), @a3 char(1), @a4 char(20), @in varchar(300);
      print 'Вставка';
      set @a1 = (select Фамилия from INSERTED);
      set @a2= (select Имя from INSERTED);
      set @a3= (select Отчество from INSERTED);
	  
      set @in = @a1+' '+ @a2 +' '+ @a3+ ' ' +@a4;
     insert into TR_AUDITR(STMT, TRNAME, CC)  
                            values('ins', 'TR_TEACHER_DEL', @in);        
      return;  
      go
 	 
insert into Driver(Фамилия,Имя,Отчество,Паспорт) values ('asdvsd','xfgngfndg','vsdfbsd',154154)


	go 
	create trigger Tov_INSTEAD_OF 
	on Route instead of DELETE 
	as 
raiserror (N'Удаление запрещено', 10, 1);
	return;

	delete from Route where Дальность=5;

	go
select Route.Дальность [Дальность],
           Route.Стоимость [Стоимость] 
           from  Route 
   where Route.Стоимость<9999999  for xml AUTO, root('Список'), elements;

