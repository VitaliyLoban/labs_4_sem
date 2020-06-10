use master;
create database TMPR_UNIVER;
use master
go
create database R_UNIVER
on primary
(name = N'R_UNIVER_mdf', filename = N'C:\UNIVER\R_UNIVER_mdf.mdf', 
   size = 5120Kb, maxsize=10240Kb, filegrowth=1024Kb
),
( name = N'R_UNIVER_ndf', filename = N'C:\UNIVER\R_UNIVER_ndf.ndf', 
    size = 5120Kb, maxsize=10240Kb,filegrowth=10%),
filegroup FG1
( name = N'R_UNIVER11_ndf', filename = N'C:\UNIVER\R_UNIVER11_ndf.ndf', 
   size = 10240Kb, maxsize=15Mb, filegrowth=1024Kb),
( name = N'R_UNIVER12_ndf', filename = N'C:\UNIVER\R_UNIVER12_ndf.ndf', 
   size = 2Mb, maxsize=5Mb, filegrowth=1024Kb),
filegroup FG2
( name = N'R_UNIVER21_ndf', filename = N'C:\UNIVER\R_UNIVER21_ndf.ndf', 
   size = 5Mb, maxsize=10Mb, filegrowth=1024Kb),
( name = N'R_UNIVER22_ndf', filename = N'C:\UNIVER\R_UNIVER22_ndf.ndf', 
   size = 2Mb, maxsize=5Mb, filegrowth=1024Kb)
log on
( name = N'R_UNIVER_log', filename=N'C:\UNIVER\R_NIVER_log.ldf',       
   size=5Mb,  maxsize=UNLIMITED, filegrowth=1Mb)
    go
use R_UNIVER;
create table FACULTY
(  FACULTY      char(10)   constraint  FACULTY_PK primary key,
   FACULTY_NAME varchar(50) default '???'
);
insert into FACULTY   (FACULTY,   FACULTY_NAME )
             values  ('ИДиП',   'Издателькое дело и полиграфия');

drop table FACULTY;
--select *from FACULTY;
create table AUDITORIUM_TYPE 
(  AUDITORIUM_TYPE  char(10) constraint AUDITORIUM_TYPE_PK  primary key,  
   AUDITORIUM_TYPENAME  varchar(30));
   drop table AUDITORIUM_TYPE;
   create table PROFESSION
 (  PROFESSION      char(20) constraint PROFESSION_PK  primary key,
   FACULTY         char(10) constraint PROFESSION_FACULTY_FK foreign key 
                            references FACULTY(FACULTY),
   PROFESSION_NAME varchar(100),    QUALIFICATION   varchar(50)   ); 
   drop table PROFESSION;

create table  PULPIT 
( PULPIT      char(20)  constraint PULPIT_PK  primary key,
 PULPIT_NAME  varchar(100), 
 FACULTY      char(10)   constraint PULPIT_FACULTY_FK foreign key 
                         references FACULTY(FACULTY)
)on FG1;
drop table PULPIT;
create table TEACHER
 (   TEACHER       char(10)  constraint TEACHER_PK  primary key,
  TEACHER_NAME  varchar(100), 
  GENDER        char(1) CHECK (GENDER in ('м', 'ж')),
  PULPIT        char(20) constraint TEACHER_PULPIT_FK foreign key 
                         references PULPIT(PULPIT) 
 )on FG1;
--drop table TEACHER;
create table SUBJECT
(
SUBJECT	char(10) constraint SUBJECT_PK  primary key, 
	 SUBJECT_NAME varchar(100) unique,
     PULPIT       char(20)    constraint SUBJECT_PULPIT_FK foreign key 
     references PULPIT(PULPIT)   
)on FG1;
--select *from SUBJECT;
--drop table SUBJECT;
create table AUDITORIUM 
( AUDITORIUM   char(20)  constraint AUDITORIUM_PK  primary key,              
 AUDITORIUM_TYPE     char(10) constraint  AUDITORI_UM_AUDITORIUM_TYPE_FK foreign key         
                      references AUDITORIUM_TYPE(AUDITORIUM_TYPE), 
 AUDITORIUM_CAPACITY  integer constraint  AUDITORIUM_CAPACITY_CHECK default 1  check (AUDITORIUM_CAPACITY between 1 and 300),  -- вместимость 
 AUDITORIUM_NAME      varchar(50)                                     
)on FG2;
create table GROUPS 
( IDGROUP     integer  identity(1,1) constraint GROUP_PK  primary key,              
 FACULTY     char(10) constraint  GROUPS_FACULTY_FK foreign key         
                      references FACULTY(FACULTY), 
 PROFESSION  char(20) constraint  GROUPS_PROFESSION_FK foreign key         
                      references PROFESSION(PROFESSION),
 YEAR_FIRST  smallint  check (YEAR_FIRST<=YEAR(GETDATE())),                  
  )on FG1;

create table STUDENT
( IDSTUDENT   integer  identity(1000,1) constraint STUDENT_PK  primary key,
 IDGROUP     integer  constraint STUDENT_GROUP_FK foreign key         
                      references GROUPS(IDGROUP),        
 NAME     nvarchar(100), 
 BDAY     date,
 STAMP    timestamp,
 INFO     xml,
 FOTO     varbinary
 )on FG2;
 drop database TMPR_UNIVER;
--------
 use R_UNIVER;
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE,  AUDITORIUM_TYPENAME )        values ('ЛК',            'Лекционная');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE,  AUDITORIUM_TYPENAME )         values ('ЛБ-К',          'Компьютерный класс');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE, AUDITORIUM_TYPENAME )         values ('ЛК-К',          'Лекционная с уст. проектором');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE,  AUDITORIUM_TYPENAME )          values  ('ЛБ-X',          'Химическая лаборатория');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE, AUDITORIUM_TYPENAME )        values  ('ЛБ-СК',   'Спец. компьютерный класс');
--------
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('СУБД',   'Системы управления базами данных','ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT)
                       values ('БД',     'Базы данных','ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('ИНФ',    'Информационные технологии','ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('ОАиП',  'Основы алгоритмизации и программирования','ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('ПЗ',     'Представление знаний в компьютерных системах','ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('ПСП',    'Программирование сетевых приложений','ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('МСОИ',  'Моделирование систем обработки информации', 'ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('ПИС',     'Проектирование информационных систем','ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('КГ',      'Компьютерная геометрия ','ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
           values ('ПМАПЛ',   'Полиграф. машины, автоматы и поточные линии', 'ПОиСОИ');
-------------
insert into  AUDITORIUM   (AUDITORIUM, AUDITORIUM_NAME,  
 AUDITORIUM_TYPE, AUDITORIUM_CAPACITY)   
values  ('206-1', '206-1','ЛБ-К', 15);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, 
AUDITORIUM_TYPE, AUDITORIUM_CAPACITY) 
values  ('301-1',   '301-1', 'ЛБ-К', 15);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, 
AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )   
values  ('236-1',   '236-1', 'ЛК',   60);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, 
AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )  
values  ('313-1',   '313-1', 'ЛК-К',   60);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, 
AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )  
values  ('324-1',   '324-1', 'ЛК-К',   50);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, 
AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )   
 values  ('413-1',   '413-1', 'ЛБ-К', 15);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, 
AUDITORIUM_TYPE, AUDITORIUM_CAPACITY ) 
values  ('423-1',   '423-1', 'ЛБ-К', 90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, 
AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )     
values  ('408-2',   '408-2', 'ЛК',  90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, 
AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )    
values  ('103-4',   '103-4', 'ЛК',  90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, 
AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )   
values  ('105-4',   '105-4', 'ЛК',  90);
-------------------------
insert into FACULTY   (FACULTY,   FACULTY_NAME )
             values  ('ИДиП',   'Издателькое дело и полиграфия');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('ХТиТ',   'Химическая технология и техника');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('ЛХФ',     'Лесохозяйственный факультет');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('ИЭФ',     'Инженерно-экономический факультет');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('ТТЛП',    'Технология и техника лесной промышленности');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('ТОВ',     'Технология органических веществ');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('ИТ',     'Факультет информационных технологий');
-----------------------------------
insert into GROUPS   (FACULTY,  PROFESSION, YEAR_FIRST )
         values ('ИДиП','1-40 01 02', 2013), --1
                ('ИДиП','1-40 01 02', 2012),
                ('ИДиП','1-40 01 02', 2011),
                ('ИДиП','1-40 01 02', 2010),
                ('ИДиП','1-47 01 01', 2013),---5 гр
                ('ИДиП','1-47 01 01', 2012),
                ('ИДиП','1-47 01 01', 2011),
                ('ИДиП','1-36 06 01', 2010),-----8 гр
                ('ИДиП','1-36 06 01', 2013),
                ('ИДиП','1-36 06 01', 2012),
                ('ИДиП','1-36 06 01', 2011),
                ('ХТиТ','1-36 01 08', 2013),---12 гр                                                  
                ('ХТиТ','1-36 01 08', 2012),
                ('ХТиТ','1-36 07 01', 2011),
                ('ХТиТ','1-36 07 01', 2010),
                ('ТОВ','1-48 01 02', 2012), ---16 гр 
                ('ТОВ','1-48 01 02', 2011),
                ('ТОВ','1-48 01 05', 2013),
                ('ТОВ','1-54 01 03', 2012),
                ('ЛХФ','1-75 01 01', 2013),--20 гр      
                ('ЛХФ','1-75 02 01', 2012),
                ('ЛХФ','1-75 02 01', 2011),
                ('ЛХФ','1-89 02 02', 2012),
                ('ЛХФ','1-89 02 02', 2011),  
                ('ТТЛП','1-36 05 01', 2013),
                ('ТТЛП','1-36 05 01', 2012),
                ('ТТЛП','1-46 01 01', 2012)--27 г
---------------------
insert into PROFESSION(FACULTY, PROFESSION, PROFESSION_NAME, QUALIFICATION)    values    ('ИДиП',  '1-40 01 02',   'Информационные системы и технологии', 'инженер-программист-системотехник' );
 insert into PROFESSION(FACULTY, PROFESSION, PROFESSION_NAME, QUALIFICATION)    values    ('ИДиП',  '1-47 01 01', 'Издательское дело', 'редактор-технолог' );
 insert into PROFESSION(FACULTY, PROFESSION,  PROFESSION_NAME, QUALIFICATION)    values    ('ИДиП',  '1-36 06 01',  'Полиграфическое оборудование и си-стемы обработки информации', 'инженер-электромеханик' );                     
 insert into PROFESSION(FACULTY, PROFESSION,  PROFESSION_NAME, QUALIFICATION)  values    ('ХТиТ',  '1-36 01 08',    'Конструирование и производство из-делий из композиционных материалов', 'инженер-механик' );
 insert into PROFESSION(FACULTY, PROFESSION,  PROFESSION_NAME, QUALIFICATION)      values    ('ХТиТ',  '1-36 07 01',  'Машины и аппараты химических производств и предприятий строительных материалов', 'инженер-механик' );
 insert into PROFESSION(FACULTY, PROFESSION, PROFESSION_NAME, QUALIFICATION)  values    ('ЛХФ',  '1-75 01 01',      'Лесное хозяйство', 'инженер лесного хозяйства' );
 insert into PROFESSION(FACULTY, PROFESSION,  PROFESSION_NAME, QUALIFICATION)   values    ('ЛХФ',  '1-75 02 01',   'Садово-парковое строительство', 'инже-нер садово-паркового строительства' );
 insert into PROFESSION(FACULTY, PROFESSION,  PROFESSION_NAME, QUALIFICATION)   values    ('ЛХФ',  '1-89 02 02',     'Туризм и природопользование', 'специ-алист в сфере туризма' );
 insert into PROFESSION(FACULTY, PROFESSION, PROFESSION_NAME, QUALIFICATION)  values    ('ИЭФ',  '1-25 01 07',  'Экономика и управление на предприятии', 'экономист-менеджер' );
 insert into PROFESSION(FACULTY, PROFESSION,  PROFESSION_NAME, QUALIFICATION)      values    ('ИЭФ',  '1-25 01 08',    'Бухгалтерский учет, анализ и аудит', 'экономист' );                      
 insert into PROFESSION(FACULTY, PROFESSION,     PROFESSION_NAME, QUALIFICATION)  values    ('ТТЛП',  '1-36 05 01',   'Машины и оборудование лесного ком-плекса', 'инженер-механик' );
 insert into PROFESSION(FACULTY, PROFESSION,   PROFESSION_NAME, QUALIFICATION)   values    ('ТТЛП',  '1-46 01 01',      'Лесоинженерное дело', 'инженер-технолог' );
 insert into PROFESSION(FACULTY, PROFESSION,     PROFESSION_NAME, QUALIFICATION)      values    ('ТОВ',  '1-48 01 02',  'Химическая технология органических веществ, материалов и изделий', 'инженер-химик-технолог' );
  insert into PROFESSION(FACULTY, PROFESSION,   PROFESSION_NAME, QUALIFICATION)    values    ('ТОВ',  '1-48 01 05',    'Химическая технология переработки древесины', 'инженер-химик-технолог' ); 
 insert into PROFESSION(FACULTY, PROFESSION,    PROFESSION_NAME, QUALIFICATION)  values    ('ТОВ',  '1-54 01 03',   'Физико-химические методы и приборы контроля качества продукции', 'инженер по сертификации' ); 
 

 ----------------------
 insert into STUDENT (IDGROUP,NAME, BDAY)
        values (2, 'Хартанович Екатерина Александровна','11.03.1995'),        
          (2, 'Горбач Елизавета Юрьевна',    '07.12.1995'),
           (3, 'Зыкова Кристина Дмитриевна',  '12.10.1995'),
           (4, 'Борисевич Ольга Анатольевна', '09.11.1995'),
           (5, 'Медведева Мария Андреевна',   '04.07.1995'),
           (3, 'Шенец Екатерина Сергеевна',   '08.01.1995'),
           (2,'Шитик Алина Игоревна',        '02.08.1995')       
insert into STUDENT (IDGROUP,NAME, BDAY)
    values (3, 'Силюк Валерия Ивановна',         '12.07.1994'),
           (4, 'Сергель Виолетта Николаевна',    '06.03.1994'),
           (5, 'Добродей Ольга Анатольевна',     '09.11.1994'),
           (4, 'Подоляк Мария Сергеевна',        '04.10.1994'),
           (2, 'Никитенко Екатерина Дмитриевна', '08.01.1994'),
           (2, 'Яцкевич Галина Иосифовна',       '02.08.1993'),
           (3, 'Осадчая Эла Васильевна',         '07.12.1993'),
           (4, 'Акулова Елена Геннадьевна',      '02.12.1993'),
           (5, 'Муковозчик Надежда Вячеславовна','09.11.1993'),
           (5, 'Войтко Елена Андреевна',         '04.07.1993'),
           (5, 'Плешкун Милана Анатольевна',     '08.03.1992'),
           (5, 'Буянова Мария Александровна',    '02.06.1992'),
           (3, 'Харченко Елена Геннадьевна',     '11.12.1992'),
           (4, 'Крученок Евгений Александрович', '11.05.1992'),
           (4, 'Бороховский Виталий Петрович',   '09.11.1992')
----------------------
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY )
  values  ('ИСиТ', 'Информационных систем и технологий ','ИДиП'  )
insert into PULPIT   (PULPIT, PULPIT_NAME,FACULTY )
values  ('ПОиСОИ','Полиграфического оборудования и систем обработки инфор-мации ', 'ИДиП'  )
insert into PULPIT   (PULPIT,PULPIT_NAME,FACULTY )
  values  ('БФ', 'Белорусской филологии','ИДиП'  )
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY )
   values  ('РИТ', 'Редакционно-издательских тенологий', 'ИДиП'  )            
insert into PULPIT   (PULPIT,  PULPIT_NAME,FACULTY )
   values  ('ПП', 'Полиграфических производств','ИДиП'  )                              
insert into PULPIT   (PULPIT, PULPIT_NAME,FACULTY)
    values  ('ЛВ', 'Лесоводства','ЛХФ')          
insert into PULPIT   (PULPIT,PULPIT_NAME,FACULTY)
  values  ('ОВ', 'Охотоведения','ЛХФ')    
insert into PULPIT   (PULPIT, PULPIT_NAME,FACULTY)
   values  ('ЛУ', 'Лесоустройства','ЛХФ')           
insert into PULPIT   (PULPIT,PULPIT_NAME,FACULTY)
  values  ('ЛЗиДВ', 'Лесозащиты и древесиноведения','ЛХФ')                
insert into PULPIT   (PULPIT,  PULPIT_NAME,FACULTY)
   values  ('ЛКиП', 'Лесных культур и почвоведения','ЛХФ') 
insert into PULPIT   (PULPIT,  PULPIT_NAME,FACULTY)
   values  ('ТиП', 'Туризма и природопользования','ЛХФ')
   -------------------------
   insert into  TEACHER    (TEACHER,   TEACHER_NAME, GENDER, PULPIT )
                       values  ('СМЛВ',    'Смелов Владимир Владиславович', 'м',  'ИСиТ');
insert into  TEACHER    (TEACHER,  TEACHER_NAME,GENDER, PULPIT )
                       values  ('АКНВЧ',    'Акунович Станислав Иванович', 'м', 'ИСиТ');
insert into  TEACHER    (TEACHER,  TEACHER_NAME,GENDER, PULPIT )
                       values  ('КЛСНВ',    'Колесников Виталий Леонидович', 'м', 'ИСиТ');
insert into  TEACHER    (TEACHER,  TEACHER_NAME,GENDER, PULPIT )
                       values  ('БРКВЧ',    'Бракович Андрей Игоревич', 'м', 'ИСиТ');
insert into  TEACHER    (TEACHER,  TEACHER_NAME,GENDER, PULPIT )
                       values  ('ДТК',     'Дятко Александр Аркадьевич', 'м', 'ИСиТ');
insert into  TEACHER    (TEACHER,  TEACHER_NAME,GENDER, PULPIT )
                       values  ('УРБ',     'Урбанович Павел Павлович', 'м', 'ИСиТ');
insert into  TEACHER    (TEACHER,  TEACHER_NAME,GENDER, PULPIT )
                      values  ('ГРН',     'Гурин Николай Иванович', 'м', 'ИСиТ');
insert into  TEACHER    (TEACHER,  TEACHER_NAME,GENDER, PULPIT )
                       values  ('ЖЛК',     'Жиляк Надежда Александровна',  'ж', 'ИСиТ');                     
insert into  TEACHER    (TEACHER,  TEACHER_NAME,GENDER, PULPIT )
                       values  ('МРЗ',     'Мороз Елена Станиславовна',  'ж',   'ИСиТ');                                                                                           
insert into  TEACHER    (TEACHER,  TEACHER_NAME,GENDER, PULPIT )
             values  ('БРТШВЧ',   'Барташевич Святослав Александрович', 'м','ПОиСОИ');
insert into  TEACHER    (TEACHER,  TEACHER_NAME,GENDER, PULPIT )
                       values  ('АРС',     'Арсентьев Виталий Арсентьевич', 'м', 'ПОиСОИ');                       
insert into  TEACHER    (TEACHER,  TEACHER_NAME,GENDER, PULPIT )
                       values  ('БРНВСК',   'Барановский Станислав Иванович', 'м', 'ЭТиМ');
 create table PROGRESS
 ( SUBJECT   char(10) constraint PROGRESS_SUBJECT_FK foreign key
                      references SUBJECT(SUBJECT),                
 IDSTUDENT integer  constraint PROGRESS_IDSTUDENT_FK foreign key         
                      references STUDENT(IDSTUDENT),        
 PDATE    date, 
 NOTE     integer check (NOTE between 1 and 10)
  )
insert into PROGRESS (SUBJECT,IDSTUDENT,PDATE, NOTE)
    values ('ОАиП', 1000,  '01.10.2013',6),
           ('ОАиП', 1001,  '01.10.2013',8),
           ('ОАиП', 1002,  '01.10.2013',7),
           ('ОАиП', 1003,  '01.10.2013',5),
           ('ОАиП', 1005,  '01.10.2013',4)
insert into PROGRESS (SUBJECT,IDSTUDENT,PDATE, NOTE)
    values   ('СУБД', 1014,  '01.12.2013',5),
           ('СУБД', 1015,  '01.12.2013',9),
           ('СУБД', 1016,  '01.12.2013',5),
           ('СУБД', 1017,  '01.12.2013',4)
insert into PROGRESS (SUBJECT,IDSTUDENT,PDATE, NOTE)
    values ('КГ',   1018,  '06.5.2013',4),
           ('КГ',   1019,  '06.05.2013',7),
           ('КГ',   1020,  '06.05.2013',7),
           ('КГ',   1021,  '06.05.2013',9),
           ('КГ',   1022,  '06.05.2013',5),
           ('КГ',   1023,  '06.05.2013',6)
		   insert into PROGRESS (SUBJECT,IDSTUDENT,PDATE, NOTE)
    values   ('СУБД', 1014,  '01.12.2013',5),
           ('СУБД', 1015,  '01.12.2013',9),
           ('СУБД', 1016,  '01.12.2013',5),
           ('СУБД', 1017,  '01.12.2013',4)
insert into PROGRESS (SUBJECT,IDSTUDENT,PDATE, NOTE)
    values ('КГ',   1018,  '06.5.2013',4),
           ('КГ',   1019,  '06.05.2013',7),
           ('КГ',   1020,  '06.05.2013',7),
           ('КГ',   1021,  '06.05.2013',9),
           ('КГ',   1022,  '06.05.2013',5),
           ('КГ',   1023,  '06.05.2013',6)
insert into PROGRESS (SUBJECT,IDSTUDENT,PDATE, NOTE)
    values ('ОХ',   1064,  '01.1.2013',6),
           ('ОХ',   1065,  '01.1.2013',4),
           ('ОХ',   1066,  '01.1.2013',9),
           ('ОХ',   1067,  '01.1.2013',5),
           ('ОХ',   1068,  '01.1.2013',8),
           ('ОХ',   1069,  '01.1.2013',4)
insert into PROGRESS (SUBJECT,IDSTUDENT,PDATE, NOTE)
    values ('ЭТ',   1055,  '01.1.2013',7),
           ('ЭТ',   1056,  '01.1.2013',8),
           ('ЭТ',   1057,  '01.1.2013',9),
           ('ЭТ',   1058,  '01.1.2013',4),
           ('ЭТ',   1059,  '01.1.2013',6)


-----------------
select * from FACULTY;
use R_UNIVER;
select		TEACHER_NAME , PULPIT	from TEACHER;
select		TEACHER_NAME  from TEACHER  where PULPIT = 'ИСиТ';
select TEACHER_NAME from TEACHER where PULPIT = 'ИСиТ' or PULPIT = 'ПОиСОИ';
select TEACHER_NAME from TEACHER where PULPIT ='ИСиТ' and GENDER ='ж';
select TEACHER_NAME[Имя преподавателей] from TEACHER where PULPIT = 'ИСиТ' and GENDER != 'м';
select distinct PULPIT from TEACHER;
select distinct AUDITORIUM_NAME,AUDITORIUM_CAPACITY,AUDITORIUM_TYPE from AUDITORIUM order by AUDITORIUM_CAPACITY;
select distinct top(2) AUDITORIUM_TYPE,AUDITORIUM_CAPACITY from AUDITORIUM order by AUDITORIUM_CAPACITY;
select distinct subject from PROGRESS where NOTE  between '8' and '10';
select distinct SUBJECT_NAME from SUBJECT where PULPIT In('ЛЗиДВ', 'ПОиСОИ','OВ');
select PROFESSION_NAME[Наименование специальности ],QUALIFICATION[Квалификация] from PROFESSION where QUALIFICATION like ('%химик%');
create table #STUDENT
(         
 NA    nvarchar(100), 
 BD     date,
 ); 
 drop table #STUDENT;
 use R_UNIVER;
 insert [#STUDENT]
 select NAME,BDAY  from STUDENT;
 select *from #STUDENT;
  select *from STUDENT;
 --------------
 use R_MyBase;
 select Название_показателя from Показатели;
 select Название_показателя from Показатели where Важность_показателя='Важно';
 select Название_предприятия from Анализы_предприятий where Значение_показателя between '5' and '7';
 select Название_предприятия from Анализы_предприятий where Показатель like('Сто%');
 select distinct top(1) Название_предприятия from Анализы_предприятий where Показатель ='Стоимость';
 --------------
 select		AUDITORIUM.AUDITORIUM , AUDITORIUM_TYPE.AUDITORIUM_TYPE from AUDITORIUM inner join AUDITORIUM_TYPE
 on AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE;
select AUDITORIUM.AUDITORIUM, AUDITORIUM_TYPE.AUDITORIUM_TYPE from AUDITORIUM inner join AUDITORIUM_TYPE 
on AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE and AUDITORIUM_TYPE.AUDITORIUM_TYPENAME like '%компьютер%';
select AUDITORIUM.AUDITORIUM , AUDITORIUM_TYPE.AUDITORIUM_TYPE from AUDITORIUM,AUDITORIUM_TYPE 
where AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE;
select AUDITORIUM.AUDITORIUM , AUDITORIUM_TYPE.AUDITORIUM_TYPE from AUDITORIUM,AUDITORIUM_TYPE 
where AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE and AUDITORIUM_TYPE.AUDITORIUM_TYPENAME like '%компьютер%';
-----
select FACULTY.FACULTY , PULPIT.PULPIT from FACULTY inner join PULPIT
on FACULTY.FACULTY = PULPIT.FACULTY;
---
Case 
when ( PROGRESS.NOTE between 6 and 8) then 
case 
when(PROGRESS.NOTE='6') then 'шесть' 
when(PROGRESS.NOTE='7') then 'семь' 
else 'восемь' 
end 
end [Результат] 
FROM ((((FACULTY Left Outer Join PULPIT ON FACULTY.FACULTY=PULPIT.PULPIT) 
Inner Join PROFESSION on PROFESSION.FACULTY=FACULTY.FACULTY) 
Inner Join GROUPS on GROUPS.PROFESSION=PROFESSION.PROFESSION) 
Inner Join _STUDENT on _STUDENT.IDGROUP=GROUPS.IDGROUP) 
Inner Join PROGRESS on PROGRESS.IDSTUDENT=_STUDENT.IDSTUDENT 
where PROGRESS.NOTE BETWEEN 6 AND 8 

Select FACULTY.FACULTY,PULPIT.PULPIT,PROFESSION.PROFESSION,GROUPS.FACULTY,STUDENT.NAME,PROGRESS.NOTE 
FROM ((((FACULTY Left Outer Join PULPIT ON FACULTY.FACULTY=PULPIT.PULPIT) 
Inner Join PROFESSION on PROFESSION.FACULTY=FACULTY.FACULTY) 
Inner Join GROUPS on GROUPS.PROFESSION=PROFESSION.PROFESSION) 
Inner Join STUDENT on STUDENT.IDGROUP=GROUPS.IDGROUP) 
Inner Join PROGRESS on PROGRESS.IDSTUDENT=STUDENT.IDSTUDENT 
where PROGRESS.NOTE BETWEEN 6 AND 8 
ORDER BY ( Case when ( PROGRESS.NOTE='7') then 1 
when ( PROGRESS.NOTE='8') then 2 
else 3 end ) 
Select PULPIT.PULPIT_NAME,isnull(TEACHER.TEACHER_NAME,'***') From PULPIT Left Outer JOIN TEACHER 
on PULPIT.PULPIT=TEACHER.PULPIT 
Select PULPIT.PULPIT_NAME,isnull(TEACHER.TEACHER_NAME,'***')[Pulpit] From TEACHER Left Outer JOIN PULPIT 
on TEACHER.PULPIT=PULPIT.PULPIT 
Select PULPIT.PULPIT_NAME,isnull(TEACHER.TEACHER_NAME,'***')[Pulpit] From TEACHER RIGHT OUTER JOIN PULPIT 
on TEACHER.PULPIT=PULPIT.PULPIT 
Select * From dbo.PULPIT FULL OUTER JOIN dbo.TEACHER 
on PULPIT.PULPIT=TEACHER.PULPIT 
Select AUDITORIUM.AUDITORIUM,AUDITORIUM_TYPE.AUDITORIUM_TYPENAME From AUDITORIUM Cross Join AUDITORIUM_TYPE 
Where AUDITORIUM.AUDITORIUM_TYPE=AUDITORIUM_TYPE.AUDITORIUM_TYPE 
-----
select PULPIT.PULPIT_NAME[Кафедра],isnull(TEACHER.TEACHER_NAME,'***')[Преподаватель]
from  TEACHER left outer join PULPIT on	PULPIT.FACULTY = TEACHER.PULPIT;
select PULPIT.PULPIT_NAME[Кафедра],isnull(TEACHER.TEACHER_NAME,'***')[Преподаватель]
from PULPIT left outer join TEACHER on	PULPIT.FACULTY = TEACHER.PULPIT;
select PULPIT.PULPIT_NAME[Кафедра],isnull(TEACHER.TEACHER_NAME,'***')[Преподаватель]
from  TEACHER right outer join PULPIT on	PULPIT.FACULTY = TEACHER.PULPIT;
--1 
Select PULPIT.PULPIT_NAME,TEACHER.TEACHER_NAME From PULPIT FULL Outer JOIN TEACHER 
on TEACHER.PULPIT=PULPIT.PULPIT 
where TEACHER.TEACHER_NAME is NULL 
--2 
Select PULPIT.PULPIT_NAME,TEACHER.TEACHER_NAME From PULPIT FULL Outer JOIN TEACHER 
on TEACHER.PULPIT=PULPIT.PULPIT 
where PULPIT.PULPIT_NAME is NULL 
--3 
Select PULPIT.PULPIT_NAME,TEACHER.TEACHER_NAME From PULPIT FULL Outer JOIN TEACHER 
on TEACHER.PULPIT=PULPIT.PULPIT 
where TEACHER.TEACHER_NAME is not NULL and PULPIT.PULPIT_NAME is not NULL
Select AUDITORIUM.AUDITORIUM,AUDITORIUM_TYPE.AUDITORIUM_TYPENAME From AUDITORIUM Cross Join AUDITORIUM_TYPE 
Where AUDITORIUM.AUDITORIUM_TYPE=AUDITORIUM_TYPE.AUDITORIUM_TYPE 
----
select Анализы_предприятий.Название_предприятия, Предприятия.Контактное_лицо from Анализы_предприятий inner join Предприятия
on Анализы_предприятий.Название_предприятия = Предприятия.Название_предприятия

select Предприятия.Название_предприятия, Анализы_предприятий.Значение_показателя from Предприятия cross join  Анализы_предприятий
where  Предприятия.Название_предприятия=Анализы_предприятий.Название_предприятия

select Предприятия.Название_предприятия, Анализы_предприятий.Значение_показателя from Предприятия inner join Анализы_предприятий on Предприятия.Название_предприятия = Анализы_предприятий.Название_предприятия
where Анализы_предприятий.Значение_показателя BETWEEN 5 AND 7 
ORDER BY ( Case when ( Анализы_предприятий.Значение_показателя ='5') then 1 
when ( Анализы_предприятий.Значение_показателя='6') then 2 
else 3 end )  
SELECT isnull (Анализы_предприятий.Название_предприятия, '**'),
Предприятия.Контактное_лицо
FROM   Анализы_предприятий Left Outer JOIN Предприятия
ON Анализы_предприятий.Название_предприятия = Предприятия.Название_предприятия 
 
SELECT isnull (Анализы_предприятий.Название_предприятия, '**'),
Предприятия.Контактное_лицо
FROM   Анализы_предприятий  right Outer JOIN Предприятия
ON Анализы_предприятий.Название_предприятия = Предприятия.Название_предприятия  

select Предприятия.Контактное_лицо , Анализы_предприятий.Название_предприятия from Предприятия,Анализы_предприятий 
where Предприятия.Название_предприятия=Анализы_предприятий.Название_предприятия and Анализы_предприятий.Название_предприятия like '%ИП%';

select Предприятия.Контактное_лицо , Анализы_предприятий.Название_предприятия from Предприятия,Анализы_предприятий 
where Предприятия.Название_предприятия=Анализы_предприятий.Название_предприятия and Анализы_предприятий.Название_предприятия in ('Лобан_ИП','Коваль_ИП');
-----lab7
select faculty.faculty, pulpit.pulpit_name, profession.profession from faculty,pulpit,profession 
where	faculty.faculty = pulpit.faculty and faculty.faculty=profession.faculty and profession in (select profession.profession from profession
where (profession_name like('%технологии%') or profession_name like('%технология%')))

select faculty.faculty,pulpit.pulpit_name,profession.profession from faculty inner join pulpit
on faculty.faculty = pulpit.faculty inner join profession on faculty.faculty = profession.faculty
where profession in (select profession.profession from profession 
where (profession_name like('%технологии%') or profession_name like('%технология%')))

select faculty.faculty,pulpit.pulpit_name,profession.profession from faculty inner join pulpit
on faculty.faculty = pulpit.faculty inner join profession
on faculty.faculty = profession.faculty 
where (profession_name like('%технологии%') or profession_name like('%технология%'))

select auditorium.auditorium_name,auditorium.auditorium_capacity,auditorium.auditorium_type from auditorium 
where auditorium.auditorium_name = (select top(1) auditorium.auditorium_name from auditorium 
where auditorium.auditorium_type  like('ЛК') or auditorium_type like('ЛБ-К') 
order by auditorium.auditorium_capacity desc)

select faculty.faculty_name from faculty
where not exists (select * from pulpit
where faculty.faculty=pulpit.faculty)

select top 1
(select avg(note) from progress 
where subject like 'СУБД'),
(select avg(note) from progress
where subject like 'КГ') from progress

select  faculty.faculty , pulpit.pulpit,progress.subject,progress.note from faculty,pulpit,progress
where progress.note <=all(select progress.note from progress
where progress.subject like 'СУБД')

select  faculty.faculty , pulpit.pulpit,progress.subject,progress.note from faculty,pulpit,progress
where progress.note >any(select progress.note from progress
where progress.subject like 'СУБД')


select Предприятия.Название_предприятия,Банковские_реквизиты.Расчетный_счет from Предприятия,Банковские_реквизиты
where  Предприятия.Название_предприятия=Банковские_реквизиты.Предприятие and Название_предприятия in (select Предприятия.Название_предприятия from Предприятия
where(Контактное_лицо like ('%Жека%') or Контактное_лицо like('%Витя%')))

select Предприятия.Название_предприятия,Банковские_реквизиты.Расчетный_счет from Предприятия inner join Банковские_реквизиты
on Предприятия.Название_предприятия = Банковские_реквизиты.Предприятие
where Предприятие in (select Предприятия.Название_предприятия from Предприятия
where(Контактное_лицо in('Витя','Виталя')))

select Предприятия.Название_предприятия,Банковские_реквизиты.Расчетный_счет from Предприятия inner join Банковские_реквизиты
on Предприятия.Название_предприятия = Банковские_реквизиты.Предприятие
where (Банковские_реквизиты.Расчетный_счет like('%45%'))

select Банковские_реквизиты.Предприятие from Банковские_реквизиты
where  exists (select * from Предприятия
where Банковские_реквизиты.Предприятие=Предприятия.Название_предприятия)

select top(1)
(select avg(Показатели.Коэфициент_показателя) from Показатели
where Важность_показателя like 'Важно')

select Предприятия.Название_предприятия,Предприятия.Контактное_лицо,Показатели.Название_показателя,Показатели.Коэфициент_показателя from Показатели,Предприятия
where Показатели.Коэфициент_показателя <=all(select Показатели.Коэфициент_показателя from Показатели
where Показатели.Важность_показателя like 'Важно')

select Предприятия.Название_предприятия,Предприятия.Контактное_лицо,Показатели.Название_показателя,Показатели.Коэфициент_показателя from Показатели,Предприятия
where Показатели.Коэфициент_показателя <=any(select Показатели.Коэфициент_показателя from Показатели
where Показатели.Важность_показателя like 'Важно')

select min(auditorium_capacity) [Минимальная_вместимость],
	   max(auditorium_capacity) [Максимальная_вместимость],
	   avg(auditorium_capacity) [Средняя_вместимость],
	   count (*)                [Кол-во аудиторий],
	   sum(auditorium_capacity) [Общая_вместимость всех аудиторий]
from auditorium 
select auditorium_name,
       min(auditorium_capacity) [Минимальная_вместимость],
	   max(auditorium_capacity) [Максимальная_вместимость],
	   avg(auditorium_capacity) [Средняя_вместимость],
	   sum(auditorium_capacity) [Общая_вместимость всех аудиторий]
from auditorium inner join auditorium_type 
on auditorium.auditorium_type=auditorium_type.auditorium_type
group by auditorium_name

select *
from (select case 
	when note between 4 and 5 then '4-5'
	when note between 6 and 7  then '6-7'
	when note between 8 and 9  then '8-9'
	when note = 10 then '10'
   end  [Отметки], COUNT (*) [Количество]    
FROM progress Group by Case 
	when note between 4 and 5 then '4-5'
	when note between 6 and 7  then '6-7'
	when note between 8 and 9  then '8-9'
	when note = 10 then '10'
   end ) as T
ORDER BY  Case [Отметки]
    when '4-5' then 3
	when '6-7'  then 2
	when '8-9'  then 1
	when '10' then 0
   end  
select faculty.faculty[факультет], groups.profession[специальность],student.course[курс],
round(avg(cast(progress.note as float(4))),2)[оценка]
from faculty inner join groups
on  groups.faculty=faculty.faculty inner join student  on groups.idgroup  = student.idgroup inner join progress
on student.idstudent = progress.idstudent
group by faculty.faculty,
 groups.profession,
 student.course

 select faculty.faculty[факультет], groups.profession[специальность],student.course[курс],
round(avg(cast(progress.note as float(4))),2)[оценка]
from faculty inner join groups
on  groups.faculty=faculty.faculty inner join student  on groups.idgroup  = student.idgroup inner join progress
on student.idstudent = progress.idstudent
where progress.subject like('%КГ%')
group by faculty.faculty,
 groups.profession,
 student.course

 select faculty.faculty[факультет], groups.profession[специальность],
 round(avg(cast(progress.note as float(4))),2)[оценка]
 from faculty inner join groups
on  groups.faculty=faculty.faculty inner join student  on groups.idgroup  = student.idgroup inner join progress
on student.idstudent = progress.idstudent
where faculty.faculty like('%ИДиП%')
group by rollup ( faculty.faculty,
 groups.profession,
 student.course
 )
  select faculty.faculty[факультет], groups.profession[специальность],
 round(avg(cast(progress.note as float(4))),2)[оценка]
 from faculty inner join groups
on  groups.faculty=faculty.faculty inner join student  on groups.idgroup  = student.idgroup inner join progress
on student.idstudent = progress.idstudent
where faculty.faculty like('%ИДиП%')
group by cube ( faculty.faculty,
 groups.profession,
 student.course
 )

 select faculty.faculty[факультет], groups.profession[специальность],
 round(avg(cast(progress.note as float(4))),2)[оценка]
 from faculty inner join groups
on  groups.faculty=faculty.faculty inner join student  on groups.idgroup  = student.idgroup inner join progress
on student.idstudent = progress.idstudent
where faculty.faculty like('%ХТиТ%')
group by  faculty.faculty,
 groups.profession,
 student.course
 union
 select faculty.faculty[факультет], groups.profession[специальность],
 round(avg(cast(progress.note as float(4))),2)[оценка]
 from faculty inner join groups
on  groups.faculty=faculty.faculty inner join student  on groups.idgroup  = student.idgroup inner join progress
on student.idstudent = progress.idstudent
where faculty.faculty like('%ИДиП%')
group by  faculty.faculty,
 groups.profession,
 student.course

  select faculty.faculty[факультет], groups.profession[специальность],
 round(avg(cast(progress.note as float(4))),2)[оценка]
 from faculty inner join groups
on  groups.faculty=faculty.faculty inner join student  on groups.idgroup  = student.idgroup inner join progress
on student.idstudent = progress.idstudent
where faculty.faculty like('%ХТиТ%')
group by  faculty.faculty,
 groups.profession,
 student.course
 union all
 select faculty.faculty[факультет], groups.profession[специальность],
 round(avg(cast(progress.note as float(4))),2)[оценка]
 from faculty inner join groups
on  groups.faculty=faculty.faculty inner join student  on groups.idgroup  = student.idgroup inner join progress
on student.idstudent = progress.idstudent
where faculty.faculty like('%ИДиП%')
group by  faculty.faculty,
 groups.profession,
 student.course

  select faculty.faculty[факультет], groups.profession[специальность],
 round(avg(cast(progress.note as float(4))),2)[оценка]
 from faculty inner join groups
on  groups.faculty=faculty.faculty inner join student  on groups.idgroup  = student.idgroup inner join progress
on student.idstudent = progress.idstudent
where faculty.faculty like('%ХТиТ%')
group by  faculty.faculty,
 groups.profession,
 student.course
 intersect
 select faculty.faculty[факультет], groups.profession[специальность],
 round(avg(cast(progress.note as float(4))),2)[оценка]
 from faculty inner join groups
on  groups.faculty=faculty.faculty inner join student  on groups.idgroup  = student.idgroup inner join progress
on student.idstudent = progress.idstudent
where faculty.faculty like('%ИДиП%')
group by  faculty.faculty,
 groups.profession,
 student.course

  select faculty.faculty[факультет], groups.profession[специальность],
 round(avg(cast(progress.note as float(4))),2)[оценка]
 from faculty inner join groups
on  groups.faculty=faculty.faculty inner join student  on groups.idgroup  = student.idgroup inner join progress
on student.idstudent = progress.idstudent
where faculty.faculty like('%ХТиТ%')
group by  faculty.faculty,
 groups.profession,
 student.course
 except
 select faculty.faculty[факультет], groups.profession[специальность],
 round(avg(cast(progress.note as float(4))),2)[оценка]
 from faculty inner join groups
on  groups.faculty=faculty.faculty inner join student  on groups.idgroup  = student.idgroup inner join progress
on student.idstudent = progress.idstudent
where faculty.faculty like('%ИДиП%')
group by  faculty.faculty,
 groups.profession,
 student.course

 select p1.subject, p1.note,
 (select count(*) from  progress p2
 where p2.subject = p1.subject and p2.note = p1.note ) [count]
 from progress p1
 group by  p1.subject , p1.note 
 having note = 9 or note = 8

 select Показатели.Название_показателя,
		min(Показатели.Коэфициент_показателя) [min],
		max(Показатели.Коэфициент_показателя) [max],
		count(*) [count],
		sum(Показатели.Коэфициент_показателя)[all]
from Показатели
group by Название_показателя

SELECT  *
 FROM (select Case 
   when Показатели.Коэфициент_показателя = 4 then 'Коэфициент = 4'
   when Показатели.Коэфициент_показателя = 5 then 'Коэфициент = 5'
   when Показатели.Коэфициент_показателя = 6 then 'Коэфициент = 6'
   end  [Коэфициенты от 4 до 6], COUNT (*) [Количество]    
FROM Показатели Group by Case 
  when Показатели.Коэфициент_показателя = 4 then 'Коэфициент = 4'
   when Показатели.Коэфициент_показателя = 5 then 'Коэфициент = 5'
   when Показатели.Коэфициент_показателя = 6 then 'Коэфициент = 6'
   end ) as T
ORDER BY  Case [Коэфициенты от 4 до 6]
   when 'Коэфициент = 4' then 3
   when 'Коэфициент = 5' then 2
   when 'Коэфициент = 6' then 1
   else 0
   end  

   select Предприятия.Название_предприятия,Показатели.Название_показателя,
   round(avg(cast(Показатели.Коэфициент_показателя as float (4))),2) [Коэфициент_показателя]
   from Предприятия, Показатели
   where Показатели.Коэфициент_показателя = 4
   group by Предприятия.Название_предприятия,Показатели.Название_показателя

   select Предприятия.Название_предприятия, Предприятия.Контактное_лицо,Предприятия.Телефон
   from Предприятия
   where Предприятия.Контактное_лицо in('maks','andrey','ilya')
   group by  rollup (Предприятия.Название_предприятия, Предприятия.Контактное_лицо,Предприятия.Телефон)

    select Предприятия.Название_предприятия, Предприятия.Контактное_лицо,Предприятия.Телефон
   from Предприятия
   where Предприятия.Контактное_лицо in('maks','andrey','ilya')
   group by  cube (Предприятия.Название_предприятия, Предприятия.Контактное_лицо,Предприятия.Телефон)

   select Предприятия.Название_предприятия, Предприятия.Контактное_лицо,Предприятия.Телефон
   from Предприятия
   where Предприятия.Контактное_лицо = 'maks' or Предприятия.Контактное_лицо='Витя'

 union
 select Предприятия.Название_предприятия, Предприятия.Контактное_лицо,Предприятия.Телефон
   from Предприятия
   where Предприятия.Контактное_лицо =  'andrey' or Предприятия.Контактное_лицо= 'Витя'

   select Предприятия.Название_предприятия, Предприятия.Контактное_лицо,Предприятия.Телефон
   from Предприятия
   where Предприятия.Контактное_лицо = 'maks' or Предприятия.Контактное_лицо='Витя'

 intersect
 select Предприятия.Название_предприятия, Предприятия.Контактное_лицо,Предприятия.Телефон
   from Предприятия
   where Предприятия.Контактное_лицо =  'andrey' or Предприятия.Контактное_лицо= 'Витя'
   ----
   select Предприятия.Название_предприятия, Предприятия.Контактное_лицо,Предприятия.Телефон
   from Предприятия
   where Предприятия.Контактное_лицо = 'maks' or Предприятия.Контактное_лицо='Витя'
 except
 select Предприятия.Название_предприятия, Предприятия.Контактное_лицо,Предприятия.Телефон
   from Предприятия
   where Предприятия.Контактное_лицо =  'andrey' or Предприятия.Контактное_лицо= 'Витя'
 ----
   select Предприятия.Название_предприятия, Предприятия.Контактное_лицо,Предприятия.Телефон
   from Предприятия
   where Предприятия.Контактное_лицо in('maks')
 group by  Предприятия.Название_предприятия, Предприятия.Контактное_лицо,Предприятия.Телефон
 intersect
 select Предприятия.Название_предприятия, Предприятия.Контактное_лицо,Предприятия.Телефон
   from Предприятия
   where Предприятия.Контактное_лицо in('andrey')
 group by  Предприятия.Название_предприятия, Предприятия.Контактное_лицо,Предприятия.Телефон

 
   select Предприятия.Название_предприятия, Предприятия.Контактное_лицо,Предприятия.Телефон
   from Предприятия
   where Предприятия.Контактное_лицо in('maks')
 group by  Предприятия.Название_предприятия, Предприятия.Контактное_лицо,Предприятия.Телефон
 except
 select Предприятия.Название_предприятия, Предприятия.Контактное_лицо,Предприятия.Телефон
   from Предприятия
   where Предприятия.Контактное_лицо in('andrey')
 group by  Предприятия.Название_предприятия, Предприятия.Контактное_лицо,Предприятия.Телефон

 select p1.Название_показателя, p1.Коэфициент_показателя,
 (select count(*) from  Показатели p2
 where p2.Название_показателя = p1.Название_показателя and p2.Коэфициент_показателя = p1.Коэфициент_показателя ) [count]
 from Показатели p1
 group by  p1.Название_показателя , p1.Коэфициент_показателя
 having Коэфициент_показателя = 4 or Коэфициент_показателя = 5

 ---
 create view [Предприятия_]
 as select  Предприятия.Название_предприятия, Предприятия.Контактное_лицо
 from Предприятия
 ---
 alter view [Предприятия_]
 as select Предприятия.Телефон
 from Предприятия
 ----
 drop view [Предприятия_]
----
create view [Сравнение_предприятий]
as select Предприятия.Название_предприятия,
		  Анализы_предприятий.Значение_показателя
from Предприятия inner join Анализы_предприятий
on Предприятия.Название_предприятия = Анализы_предприятий.Название_предприятия
select * from [Сравнение_предприятий]
----
create view  Большие_показатели(Предприятие,Показатель,Значение_показателя)
	as select Анализы_предприятий.Название_предприятия,Анализы_предприятий.Показатель,Анализы_предприятий.Значение_показателя
	from Анализы_предприятий
	where Анализы_предприятий.Значение_показателя > 5;
go
select * from Большие_показатели
----
alter view
 Большие_показатели(Предприятие,Показатель,Значение_показателя)
	as select Анализы_предприятий.Название_предприятия,Анализы_предприятий.Показатель,Анализы_предприятий.Значение_показателя
	from Анализы_предприятий
	where Анализы_предприятий.Значение_показателя > 6 with check option;
go
insert  Предприятия values('Купалинка',4231423,'Кто-то','м')
insert  Большие_показатели values('Купалинка','Зарплата',7)
---
create view Выборка(Предприятие,Показатель,Значение_показателя)
   as select top(2) Анализы_предприятий.Название_предприятия,Анализы_предприятий.Показатель,Анализы_предприятий.Значение_показателя
	from Анализы_предприятий
   order by Анализы_предприятий.Название_предприятия
---
alter view [Сравнение_предприятий] with schemabinding
as select Предприятия.Название_предприятия,
		  Анализы_предприятий.Значение_показателя
from dbo.Предприятия inner join dbo.Анализы_предприятий
on Предприятия.Название_предприятия = Анализы_предприятий.Название_предприятия

select * from account order by  typeDeposit
Declare @Char char='A',
        @VarChar varchar='B',
		@Datetime datetime,
		@Time time,
		@Int int,
		@Smallint smallint,
		@Numeric numeric(12,5);
Set @Datetime='12.12.2018';
Set @Time='00:00';
Select @Int=5;
Select @Numeric=8.4;
Select @Char;
Select @VarChar;
Select @Datetime;
Select @Time;
PRINT 'Int='+STR(@VariableInt);
PRINT 'Smallint='+STR(@VariableSmallint);
PRINT 'Numeric='+STR(@VariableNumeric);

Declare @capacity int =(select cast(sum(AUDITORIUM_CAPACITY) as int)from AUDITORIUM), @col float,@AVGvmes int,@col_a float,@poth float
if @capacity>200
Begin
Select @col = (select cast( count(*) as int) from AUDITORIUM),
              @AVGvmes = (select cast(AVG(AUDITORIUM_CAPACITY)as int) from AUDITORIUM)
SET @col_a= (select cast(COUNT(*) as int) from AUDITORIUM where AUDITORIUM_CAPACITY < @AVGvmes)
Set @poth=cast( @col_a/@col as float)*100;
SELECT @col  'Количество аудиторий',  @AVGvmes   'среднюю вместимость аудиторий',  @col_a   'количество аудиторий, вместимость которых меньше средней',cast (@poth as int)'% процент таких аудиторий'
End
else if @capacity<200
Select @capacity 'Общая вместимость';

PRINT 'число обработанных строк '+cast(@@ROWCOUNT as nvarchar(20));
PRINT 'версия SQL Server '+cast(@@VERSION as nvarchar(20));
PRINT 'системный идентификатор процесса '+cast(@@SPID as varchar(20));
PRINT 'код последней ошибки '+cast(@@ERROR as varchar(20));
PRINT 'имя сервера '+cast(@@SERVERNAME as varchar(20));
PRINT 'уровень вложенности транзакции '+cast(@@TRANCOUNT  as varchar(20));
PRINT 'проверка результата считывания строк результирующего набора '+cast(@@FETCH_STATUS  as varchar(20));
PRINT 'уровень вложенности текущей проце-дуры '+cast(@@NESTLEVEL as varchar(20));

DECLARE @Z float, @T float=0.8, @X float=0.8
if(@T>@X)
Begin
Set @Z=SIN(@T)*SIN(@T);
PRINT 'SIN('+cast(@T as varchar(10))+')*SIN('+cast(@T as varchar(10))+')='+cast(@Z as varchar(10))
END
else 
if(@T<@x)
BEGIN
Set @Z=4*(@T+@X)
PRINT '4*('+cast(@T as varchar(10))+'+'+cast(@X as varchar(10))+'='+cast(@Z as varchar(10))
END
else
BEGIN
SET @Z=1-EXP(@X-2)
PRINT '1-EXP('+cast(@X as varchar(10))+'-2)='+cast(@Z as varchar(10))
END

Declare @name nvarchar(29)='Макейчик Татьяна Леонидовна'
SET @name=replace(@name,'Татьяна Леонидовна','T.Л');
PRINT @name

DECLARE @dt datetime = getdate();
Select STUDENT.NAME, STUDENT.BDAY from STUDENT where MONTH(BDAY)=MONTH(dateadd(M, 1, @dt));

declare @day date
Select @day=PROGRESS.PDATE from PROGRESS where PROGRESS.SUBJECT='СУБД'
PRINT  DATENAME(weekday,@day)

Declare @col_N int=(select count(*) from PROGRESS)
if(@col_N>10)
Begin
Print 'Сессию здавало >10 человек';
PRINT 'Количество студенто получивших оценки - '+cast(@col_N as varchar(10));
end
else
Begin 
Print 'Сессию здавало <10 человек';
PRINT 'Количество студенто получивших оценки - '+cast(@col_N as varchar(10));
end 

Select case 
     when  SUBJECT='КГ' and NOTE between 0 and 6 then 'Плохо'
	 when SUBJECT='КГ' and NOTE between 6 and 8 then 'Нормально' 
	 when SUBJECT='КГ' and NOTE between 8 and 10 then 'Хорошо'
	 end NOTE , count(*) [Количество] 
from PROGRESS
GROUP BY CASE 
      when  SUBJECT='КГ' and NOTE between 0 and 6 then 'Плохо'
	 when SUBJECT='КГ' and NOTE between 6 and 8 then 'Нормально' 
	 when SUBJECT='КГ' and NOTE between 8 and 10 then 'Хорошо'
end

Create Table #table
(
id_user int identity(1,1),
name nvarchar(10),
lname nvarchar(10) 
)
Insert #table(name,lname)
values('jhgf','jhgf'),
      ('hgf','hgf'),
	  ('hgf','gfd'),
	  ('tgv','nb'),
	  ('qq','rec')
Declare @i int=1
while @i<6 
begin
Select id_user,name,lname from #table where #table.id_user=@i
SET @i=@i+1;
end

DECLARE @p int = 1
print @p+1
print @p+2 
RETURN
print @p+3

begin TRY
update PROGRESS set NOTE = 'j' where NOTE= '6'
end try
begin CATCH
print ERROR_NUMBER()
print ERROR_MESSAGE()
print ERROR_LINE()
print ERROR_PROCEDURE()
print ERROR_SEVERITY()
print ERROR_STATE()
end catch

Create Table ##table
(
id_user int identity(1,1),
name nvarchar(10),
lname nvarchar(10) 
)
Insert ##table(name,lname)
values('jhgf','gf'),
      ('ww','gfd'),
	  ('fds','bvc'),
	  ('bvc','vcx'),
	  ('bvc','bv')

Declare @j int=1
while @j<11 
begin
Select id_user,name,lname from ##table where ##table.id_user=@j
SET @j=@j+1;
end

use R_UNIVER;
exec	sp_helpindex 'pulpit'
exec    sp_helpindex 'faculty' 
exec    sp_helpindex 'auditorium' 
exec    sp_helpindex 'progress'
exec    sp_helpindex 'student'
exec    sp_helpindex 'subject'  
exec    sp_helpindex 'groups'  

create table	#localtable
(
tInd int,
tField nvarchar(max)
)

set nocount on
declare  @i int =0
while @i<1000
begin 
insert #localtable(tInd,tField)
values (FLOOR(2000*rand()),REPLICATE('string',10))
 print @i;
set @i=@i+1
end
go

select * from #localtable where tInd between 500 and 1000 order by tInd

	checkpoint;  
	 DBCC DROPCLEANBUFFERS;  
	CREATE clustered index #indexForLocalTable on #localtable(tind asc)

create table #lt
(
TKEY int, CC int identity(1,1),TF varchar(100)
)

  set nocount on;           
  declare @i int = 0;
  while   @i < 20000       -- добавление в таблицу 20000 строк
  begin
  INSERT #lt(TKEY, TF) values(floor(30000*RAND()), replicate('string ', 10));
  set @i = @i+1; 
  end;
  go
  SELECT count(*)[количество строк] from #lt;
  SELECT * from #lt

  CREATE index #lt_NONCLU on #lt(TKEY, CC)
      SELECT * from  #lt where  TKEY > 1500 and  CC < 4500;  
    SELECT * from  #lt order by  TKEY, CC
	SELECT * from  #lt where  TKEY = 556 and  CC > 3

	create table #ltt
(
TKEY int, CC int identity(1,1),TF varchar(100)
)
set nocount on;           
  declare @i int = 0;
  while   @i < 20000       -- добавление в таблицу 20000 строк
  begin
  INSERT #ltt(TKEY, TF) values(floor(30000*RAND()), replicate('string ', 10));
  set @i = @i+1; 
  end;
  go
  SELECT count(*)[количество строк] from #ltt;
  SELECT * from #ltt
CREATE  index #ltt_tkey on #lt(TKEY) INCLUDE (CC)
SELECT CC from #ltt where TKEY < 15000 


	create table #lttt
(
TKEY int, CC int identity(1,1),TF varchar(100)
)
set nocount on;           
  declare @i int = 0;
  while   @i < 20000       -- добавление в таблицу 20000 строк
  begin
  INSERT #lttt(TKEY, TF) values(floor(30000*RAND()), replicate('string ', 10));
  set @i = @i+1; 
  end;
  go
  SELECT count(*)[количество строк] from #lttt;
  SELECT * from #lttt
  SELECT TKEY from  #lttt where TKEY between 5000 and 19999; 
SELECT TKEY from  #lttt where TKEY>15000 and  TKEY < 20000  
SELECT TKEY from  #lttt where TKEY=17000
    CREATE  index #lttt_where on #lttt(TKEY) where (TKEY>=15000 and 
 TKEY < 20000);  


 	create table #ltttt
(
TKEY int, CC int identity(1,1),TF varchar(100)
)
set nocount on;           
  declare @i int = 0;
  while   @i < 20000       -- добавление в таблицу 20000 строк
  begin
  INSERT #ltttt(TKEY, TF) values(floor(30000*RAND()), replicate('string ', 10));
  set @i = @i+1; 
  end;
  go
  SELECT count(*)[количество строк] from #ltttt;
  SELECT * from #ltttt

  create index #ltttt_tkey on #ltttt(tkey)
    SELECT name [Индекс], avg_fragmentation_in_percent [Фрагментация (%)]
  FROM sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'), 
  OBJECT_ID(N'#ltttt'), NULL, NULL, NULL) ss
  JOIN sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id  
                 where name is not null;
     INSERT top(10000) #ltttt(TKEY, TF) select TKEY, TF from #ltttt;
	alter index #ltttt_tkey on #ltttt reorganize
	alter index #ltttt_tkey on #ltttt rebuild with(online = off)
	drop index #ltttt_tkey on #ltttt
	create index #ltttt_tkey on #ltttt(tkey) with(fillfactor = 65)
	    INSERT top(50)percent into #ltttt(TKEY, TF) select TKEY, TF  from #ltttt;

		SELECT name [Индекс], avg_fragmentation_in_percent [Фрагментация (%)]
FROM sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'), OBJECT_ID(N'#ltttt'), NULL, NULL, NULL) ss
       JOIN sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id  
                              where name is not null;

  	create table #lttttt
(
TKEY int, CC int identity(1,1),TF varchar(100)
)
  declare @i int = 0;
  while   @i < 20000       -- добавление в таблицу 20000 строк
  begin
  INSERT #lttttt(TKEY, TF) values(floor(30000*RAND()), replicate('string ', 10));
  set @i = @i+1; 
  end;
  go
  SELECT count(*)[количество строк] from #lttttt;
  SELECT * from #lttttt

  delete  from #lttttt
 TRUNCATE TABLE #lttttt
 create view  Количество_кафедр(Факультет,Колво_кафедр)
	as select Pulpit.faculty,count(PULPIT.PULPIT)
	from pulpit
group by pulpit.faculty, pulpit.pulpit
Create view[Количество_кафедр1] 
as select FACULTY.FACULTY_NAME[Факультет], 
count(*) [Количество кафедр] from FACULTY join PULPIT on FACULTY.FACULTY=PULPIT.PULPIT 
group by FACULTY.FACULTY_NAME 
go 
Select * from[Количество_кафедр1]