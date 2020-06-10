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
             values  ('����',   '����������� ���� � ����������');

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
  GENDER        char(1) CHECK (GENDER in ('�', '�')),
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
 AUDITORIUM_CAPACITY  integer constraint  AUDITORIUM_CAPACITY_CHECK default 1  check (AUDITORIUM_CAPACITY between 1 and 300),  -- ����������� 
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
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE,  AUDITORIUM_TYPENAME )        values ('��',            '����������');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE,  AUDITORIUM_TYPENAME )         values ('��-�',          '������������ �����');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE, AUDITORIUM_TYPENAME )         values ('��-�',          '���������� � ���. ����������');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE,  AUDITORIUM_TYPENAME )          values  ('��-X',          '���������� �����������');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE, AUDITORIUM_TYPENAME )        values  ('��-��',   '����. ������������ �����');
--------
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('����',   '������� ���������� ������ ������','����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT)
                       values ('��',     '���� ������','����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('���',    '�������������� ����������','����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('����',  '������ �������������� � ����������������','����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('��',     '������������� ������ � ������������ ��������','����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('���',    '���������������� ������� ����������','����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('����',  '������������� ������ ��������� ����������', '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('���',     '�������������� �������������� ������','����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('��',      '������������ ��������� ','����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
           values ('�����',   '��������. ������, �������� � �������� �����', '������');
-------------
insert into  AUDITORIUM   (AUDITORIUM, AUDITORIUM_NAME,  
 AUDITORIUM_TYPE, AUDITORIUM_CAPACITY)   
values  ('206-1', '206-1','��-�', 15);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, 
AUDITORIUM_TYPE, AUDITORIUM_CAPACITY) 
values  ('301-1',   '301-1', '��-�', 15);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, 
AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )   
values  ('236-1',   '236-1', '��',   60);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, 
AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )  
values  ('313-1',   '313-1', '��-�',   60);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, 
AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )  
values  ('324-1',   '324-1', '��-�',   50);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, 
AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )   
 values  ('413-1',   '413-1', '��-�', 15);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, 
AUDITORIUM_TYPE, AUDITORIUM_CAPACITY ) 
values  ('423-1',   '423-1', '��-�', 90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, 
AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )     
values  ('408-2',   '408-2', '��',  90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, 
AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )    
values  ('103-4',   '103-4', '��',  90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, 
AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )   
values  ('105-4',   '105-4', '��',  90);
-------------------------
insert into FACULTY   (FACULTY,   FACULTY_NAME )
             values  ('����',   '����������� ���� � ����������');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('����',   '���������� ���������� � �������');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('���',     '����������������� ���������');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('���',     '���������-������������� ���������');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('����',    '���������� � ������� ������ ��������������');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('���',     '���������� ������������ �������');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('��',     '��������� �������������� ����������');
-----------------------------------
insert into GROUPS   (FACULTY,  PROFESSION, YEAR_FIRST )
         values ('����','1-40 01 02', 2013), --1
                ('����','1-40 01 02', 2012),
                ('����','1-40 01 02', 2011),
                ('����','1-40 01 02', 2010),
                ('����','1-47 01 01', 2013),---5 ��
                ('����','1-47 01 01', 2012),
                ('����','1-47 01 01', 2011),
                ('����','1-36 06 01', 2010),-----8 ��
                ('����','1-36 06 01', 2013),
                ('����','1-36 06 01', 2012),
                ('����','1-36 06 01', 2011),
                ('����','1-36 01 08', 2013),---12 ��                                                  
                ('����','1-36 01 08', 2012),
                ('����','1-36 07 01', 2011),
                ('����','1-36 07 01', 2010),
                ('���','1-48 01 02', 2012), ---16 �� 
                ('���','1-48 01 02', 2011),
                ('���','1-48 01 05', 2013),
                ('���','1-54 01 03', 2012),
                ('���','1-75 01 01', 2013),--20 ��      
                ('���','1-75 02 01', 2012),
                ('���','1-75 02 01', 2011),
                ('���','1-89 02 02', 2012),
                ('���','1-89 02 02', 2011),  
                ('����','1-36 05 01', 2013),
                ('����','1-36 05 01', 2012),
                ('����','1-46 01 01', 2012)--27 �
---------------------
insert into PROFESSION(FACULTY, PROFESSION, PROFESSION_NAME, QUALIFICATION)    values    ('����',  '1-40 01 02',   '�������������� ������� � ����������', '�������-�����������-�������������' );
 insert into PROFESSION(FACULTY, PROFESSION, PROFESSION_NAME, QUALIFICATION)    values    ('����',  '1-47 01 01', '������������ ����', '��������-��������' );
 insert into PROFESSION(FACULTY, PROFESSION,  PROFESSION_NAME, QUALIFICATION)    values    ('����',  '1-36 06 01',  '��������������� ������������ � ��-����� ��������� ����������', '�������-��������������' );                     
 insert into PROFESSION(FACULTY, PROFESSION,  PROFESSION_NAME, QUALIFICATION)  values    ('����',  '1-36 01 08',    '��������������� � ������������ ��-����� �� �������������� ����������', '�������-�������' );
 insert into PROFESSION(FACULTY, PROFESSION,  PROFESSION_NAME, QUALIFICATION)      values    ('����',  '1-36 07 01',  '������ � �������� ���������� ����������� � ����������� ������������ ����������', '�������-�������' );
 insert into PROFESSION(FACULTY, PROFESSION, PROFESSION_NAME, QUALIFICATION)  values    ('���',  '1-75 01 01',      '������ ���������', '������� ������� ���������' );
 insert into PROFESSION(FACULTY, PROFESSION,  PROFESSION_NAME, QUALIFICATION)   values    ('���',  '1-75 02 01',   '������-�������� �������������', '����-��� ������-��������� �������������' );
 insert into PROFESSION(FACULTY, PROFESSION,  PROFESSION_NAME, QUALIFICATION)   values    ('���',  '1-89 02 02',     '������ � ������������������', '�����-����� � ����� �������' );
 insert into PROFESSION(FACULTY, PROFESSION, PROFESSION_NAME, QUALIFICATION)  values    ('���',  '1-25 01 07',  '��������� � ���������� �� �����������', '���������-��������' );
 insert into PROFESSION(FACULTY, PROFESSION,  PROFESSION_NAME, QUALIFICATION)      values    ('���',  '1-25 01 08',    '������������� ����, ������ � �����', '���������' );                      
 insert into PROFESSION(FACULTY, PROFESSION,     PROFESSION_NAME, QUALIFICATION)  values    ('����',  '1-36 05 01',   '������ � ������������ ������� ���-������', '�������-�������' );
 insert into PROFESSION(FACULTY, PROFESSION,   PROFESSION_NAME, QUALIFICATION)   values    ('����',  '1-46 01 01',      '�������������� ����', '�������-��������' );
 insert into PROFESSION(FACULTY, PROFESSION,     PROFESSION_NAME, QUALIFICATION)      values    ('���',  '1-48 01 02',  '���������� ���������� ������������ �������, ���������� � �������', '�������-�����-��������' );
  insert into PROFESSION(FACULTY, PROFESSION,   PROFESSION_NAME, QUALIFICATION)    values    ('���',  '1-48 01 05',    '���������� ���������� ����������� ���������', '�������-�����-��������' ); 
 insert into PROFESSION(FACULTY, PROFESSION,    PROFESSION_NAME, QUALIFICATION)  values    ('���',  '1-54 01 03',   '������-���������� ������ � ������� �������� �������� ���������', '������� �� ������������' ); 
 

 ----------------------
 insert into STUDENT (IDGROUP,NAME, BDAY)
        values (2, '���������� ��������� �������������','11.03.1995'),        
          (2, '������ ��������� �������',    '07.12.1995'),
           (3, '������ �������� ����������',  '12.10.1995'),
           (4, '��������� ����� �����������', '09.11.1995'),
           (5, '��������� ����� ���������',   '04.07.1995'),
           (3, '����� ��������� ���������',   '08.01.1995'),
           (2,'����� ����� ��������',        '02.08.1995')       
insert into STUDENT (IDGROUP,NAME, BDAY)
    values (3, '����� ������� ��������',         '12.07.1994'),
           (4, '������� �������� ����������',    '06.03.1994'),
           (5, '�������� ����� �����������',     '09.11.1994'),
           (4, '������� ����� ���������',        '04.10.1994'),
           (2, '��������� ��������� ����������', '08.01.1994'),
           (2, '������� ������ ���������',       '02.08.1993'),
           (3, '������� ��� ����������',         '07.12.1993'),
           (4, '������� ����� �����������',      '02.12.1993'),
           (5, '���������� ������� ������������','09.11.1993'),
           (5, '������ ����� ���������',         '04.07.1993'),
           (5, '������� ������ �����������',     '08.03.1992'),
           (5, '������� ����� �������������',    '02.06.1992'),
           (3, '�������� ����� �����������',     '11.12.1992'),
           (4, '�������� ������� �������������', '11.05.1992'),
           (4, '����������� ������� ��������',   '09.11.1992')
----------------------
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY )
  values  ('����', '�������������� ������ � ���������� ','����'  )
insert into PULPIT   (PULPIT, PULPIT_NAME,FACULTY )
values  ('������','���������������� ������������ � ������ ��������� �����-����� ', '����'  )
insert into PULPIT   (PULPIT,PULPIT_NAME,FACULTY )
  values  ('��', '����������� ���������','����'  )
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY )
   values  ('���', '�����������-������������ ���������', '����'  )            
insert into PULPIT   (PULPIT,  PULPIT_NAME,FACULTY )
   values  ('��', '��������������� �����������','����'  )                              
insert into PULPIT   (PULPIT, PULPIT_NAME,FACULTY)
    values  ('��', '�����������','���')          
insert into PULPIT   (PULPIT,PULPIT_NAME,FACULTY)
  values  ('��', '������������','���')    
insert into PULPIT   (PULPIT, PULPIT_NAME,FACULTY)
   values  ('��', '��������������','���')           
insert into PULPIT   (PULPIT,PULPIT_NAME,FACULTY)
  values  ('�����', '���������� � ����������������','���')                
insert into PULPIT   (PULPIT,  PULPIT_NAME,FACULTY)
   values  ('����', '������ ������� � ������������','���') 
insert into PULPIT   (PULPIT,  PULPIT_NAME,FACULTY)
   values  ('���', '������� � ������������������','���')
   -------------------------
   insert into  TEACHER    (TEACHER,   TEACHER_NAME, GENDER, PULPIT )
                       values  ('����',    '������ �������� �������������', '�',  '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME,GENDER, PULPIT )
                       values  ('�����',    '�������� ��������� ��������', '�', '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME,GENDER, PULPIT )
                       values  ('�����',    '���������� ������� ����������', '�', '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME,GENDER, PULPIT )
                       values  ('�����',    '�������� ������ ��������', '�', '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME,GENDER, PULPIT )
                       values  ('���',     '����� ��������� ����������', '�', '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME,GENDER, PULPIT )
                       values  ('���',     '��������� ����� ��������', '�', '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME,GENDER, PULPIT )
                      values  ('���',     '����� ������� ��������', '�', '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME,GENDER, PULPIT )
                       values  ('���',     '����� ������� �������������',  '�', '����');                     
insert into  TEACHER    (TEACHER,  TEACHER_NAME,GENDER, PULPIT )
                       values  ('���',     '����� ����� �������������',  '�',   '����');                                                                                           
insert into  TEACHER    (TEACHER,  TEACHER_NAME,GENDER, PULPIT )
             values  ('������',   '���������� ��������� �������������', '�','������');
insert into  TEACHER    (TEACHER,  TEACHER_NAME,GENDER, PULPIT )
                       values  ('���',     '��������� ������� �����������', '�', '������');                       
insert into  TEACHER    (TEACHER,  TEACHER_NAME,GENDER, PULPIT )
                       values  ('������',   '����������� ��������� ��������', '�', '����');
 create table PROGRESS
 ( SUBJECT   char(10) constraint PROGRESS_SUBJECT_FK foreign key
                      references SUBJECT(SUBJECT),                
 IDSTUDENT integer  constraint PROGRESS_IDSTUDENT_FK foreign key         
                      references STUDENT(IDSTUDENT),        
 PDATE    date, 
 NOTE     integer check (NOTE between 1 and 10)
  )
insert into PROGRESS (SUBJECT,IDSTUDENT,PDATE, NOTE)
    values ('����', 1000,  '01.10.2013',6),
           ('����', 1001,  '01.10.2013',8),
           ('����', 1002,  '01.10.2013',7),
           ('����', 1003,  '01.10.2013',5),
           ('����', 1005,  '01.10.2013',4)
insert into PROGRESS (SUBJECT,IDSTUDENT,PDATE, NOTE)
    values   ('����', 1014,  '01.12.2013',5),
           ('����', 1015,  '01.12.2013',9),
           ('����', 1016,  '01.12.2013',5),
           ('����', 1017,  '01.12.2013',4)
insert into PROGRESS (SUBJECT,IDSTUDENT,PDATE, NOTE)
    values ('��',   1018,  '06.5.2013',4),
           ('��',   1019,  '06.05.2013',7),
           ('��',   1020,  '06.05.2013',7),
           ('��',   1021,  '06.05.2013',9),
           ('��',   1022,  '06.05.2013',5),
           ('��',   1023,  '06.05.2013',6)
		   insert into PROGRESS (SUBJECT,IDSTUDENT,PDATE, NOTE)
    values   ('����', 1014,  '01.12.2013',5),
           ('����', 1015,  '01.12.2013',9),
           ('����', 1016,  '01.12.2013',5),
           ('����', 1017,  '01.12.2013',4)
insert into PROGRESS (SUBJECT,IDSTUDENT,PDATE, NOTE)
    values ('��',   1018,  '06.5.2013',4),
           ('��',   1019,  '06.05.2013',7),
           ('��',   1020,  '06.05.2013',7),
           ('��',   1021,  '06.05.2013',9),
           ('��',   1022,  '06.05.2013',5),
           ('��',   1023,  '06.05.2013',6)
insert into PROGRESS (SUBJECT,IDSTUDENT,PDATE, NOTE)
    values ('��',   1064,  '01.1.2013',6),
           ('��',   1065,  '01.1.2013',4),
           ('��',   1066,  '01.1.2013',9),
           ('��',   1067,  '01.1.2013',5),
           ('��',   1068,  '01.1.2013',8),
           ('��',   1069,  '01.1.2013',4)
insert into PROGRESS (SUBJECT,IDSTUDENT,PDATE, NOTE)
    values ('��',   1055,  '01.1.2013',7),
           ('��',   1056,  '01.1.2013',8),
           ('��',   1057,  '01.1.2013',9),
           ('��',   1058,  '01.1.2013',4),
           ('��',   1059,  '01.1.2013',6)


-----------------
select * from FACULTY;
use R_UNIVER;
select		TEACHER_NAME , PULPIT	from TEACHER;
select		TEACHER_NAME  from TEACHER  where PULPIT = '����';
select TEACHER_NAME from TEACHER where PULPIT = '����' or PULPIT = '������';
select TEACHER_NAME from TEACHER where PULPIT ='����' and GENDER ='�';
select TEACHER_NAME[��� ��������������] from TEACHER where PULPIT = '����' and GENDER != '�';
select distinct PULPIT from TEACHER;
select distinct AUDITORIUM_NAME,AUDITORIUM_CAPACITY,AUDITORIUM_TYPE from AUDITORIUM order by AUDITORIUM_CAPACITY;
select distinct top(2) AUDITORIUM_TYPE,AUDITORIUM_CAPACITY from AUDITORIUM order by AUDITORIUM_CAPACITY;
select distinct subject from PROGRESS where NOTE  between '8' and '10';
select distinct SUBJECT_NAME from SUBJECT where PULPIT In('�����', '������','O�');
select PROFESSION_NAME[������������ ������������� ],QUALIFICATION[������������] from PROFESSION where QUALIFICATION like ('%�����%');
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
 select ��������_���������� from ����������;
 select ��������_���������� from ���������� where ��������_����������='�����';
 select ��������_����������� from �������_����������� where ��������_���������� between '5' and '7';
 select ��������_����������� from �������_����������� where ���������� like('���%');
 select distinct top(1) ��������_����������� from �������_����������� where ���������� ='���������';
 --------------
 select		AUDITORIUM.AUDITORIUM , AUDITORIUM_TYPE.AUDITORIUM_TYPE from AUDITORIUM inner join AUDITORIUM_TYPE
 on AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE;
select AUDITORIUM.AUDITORIUM, AUDITORIUM_TYPE.AUDITORIUM_TYPE from AUDITORIUM inner join AUDITORIUM_TYPE 
on AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE and AUDITORIUM_TYPE.AUDITORIUM_TYPENAME like '%���������%';
select AUDITORIUM.AUDITORIUM , AUDITORIUM_TYPE.AUDITORIUM_TYPE from AUDITORIUM,AUDITORIUM_TYPE 
where AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE;
select AUDITORIUM.AUDITORIUM , AUDITORIUM_TYPE.AUDITORIUM_TYPE from AUDITORIUM,AUDITORIUM_TYPE 
where AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE and AUDITORIUM_TYPE.AUDITORIUM_TYPENAME like '%���������%';
-----
select FACULTY.FACULTY , PULPIT.PULPIT from FACULTY inner join PULPIT
on FACULTY.FACULTY = PULPIT.FACULTY;
---
Case 
when ( PROGRESS.NOTE between 6 and 8) then 
case 
when(PROGRESS.NOTE='6') then '�����' 
when(PROGRESS.NOTE='7') then '����' 
else '������' 
end 
end [���������] 
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
select PULPIT.PULPIT_NAME[�������],isnull(TEACHER.TEACHER_NAME,'***')[�������������]
from  TEACHER left outer join PULPIT on	PULPIT.FACULTY = TEACHER.PULPIT;
select PULPIT.PULPIT_NAME[�������],isnull(TEACHER.TEACHER_NAME,'***')[�������������]
from PULPIT left outer join TEACHER on	PULPIT.FACULTY = TEACHER.PULPIT;
select PULPIT.PULPIT_NAME[�������],isnull(TEACHER.TEACHER_NAME,'***')[�������������]
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
select �������_�����������.��������_�����������, �����������.����������_���� from �������_����������� inner join �����������
on �������_�����������.��������_����������� = �����������.��������_�����������

select �����������.��������_�����������, �������_�����������.��������_���������� from ����������� cross join  �������_�����������
where  �����������.��������_�����������=�������_�����������.��������_�����������

select �����������.��������_�����������, �������_�����������.��������_���������� from ����������� inner join �������_����������� on �����������.��������_����������� = �������_�����������.��������_�����������
where �������_�����������.��������_���������� BETWEEN 5 AND 7 
ORDER BY ( Case when ( �������_�����������.��������_���������� ='5') then 1 
when ( �������_�����������.��������_����������='6') then 2 
else 3 end )  
SELECT isnull (�������_�����������.��������_�����������, '**'),
�����������.����������_����
FROM   �������_����������� Left Outer JOIN �����������
ON �������_�����������.��������_����������� = �����������.��������_����������� 
 
SELECT isnull (�������_�����������.��������_�����������, '**'),
�����������.����������_����
FROM   �������_�����������  right Outer JOIN �����������
ON �������_�����������.��������_����������� = �����������.��������_�����������  

select �����������.����������_���� , �������_�����������.��������_����������� from �����������,�������_����������� 
where �����������.��������_�����������=�������_�����������.��������_����������� and �������_�����������.��������_����������� like '%��%';

select �����������.����������_���� , �������_�����������.��������_����������� from �����������,�������_����������� 
where �����������.��������_�����������=�������_�����������.��������_����������� and �������_�����������.��������_����������� in ('�����_��','������_��');
-----lab7
select faculty.faculty, pulpit.pulpit_name, profession.profession from faculty,pulpit,profession 
where	faculty.faculty = pulpit.faculty and faculty.faculty=profession.faculty and profession in (select profession.profession from profession
where (profession_name like('%����������%') or profession_name like('%����������%')))

select faculty.faculty,pulpit.pulpit_name,profession.profession from faculty inner join pulpit
on faculty.faculty = pulpit.faculty inner join profession on faculty.faculty = profession.faculty
where profession in (select profession.profession from profession 
where (profession_name like('%����������%') or profession_name like('%����������%')))

select faculty.faculty,pulpit.pulpit_name,profession.profession from faculty inner join pulpit
on faculty.faculty = pulpit.faculty inner join profession
on faculty.faculty = profession.faculty 
where (profession_name like('%����������%') or profession_name like('%����������%'))

select auditorium.auditorium_name,auditorium.auditorium_capacity,auditorium.auditorium_type from auditorium 
where auditorium.auditorium_name = (select top(1) auditorium.auditorium_name from auditorium 
where auditorium.auditorium_type  like('��') or auditorium_type like('��-�') 
order by auditorium.auditorium_capacity desc)

select faculty.faculty_name from faculty
where not exists (select * from pulpit
where faculty.faculty=pulpit.faculty)

select top 1
(select avg(note) from progress 
where subject like '����'),
(select avg(note) from progress
where subject like '��') from progress

select  faculty.faculty , pulpit.pulpit,progress.subject,progress.note from faculty,pulpit,progress
where progress.note <=all(select progress.note from progress
where progress.subject like '����')

select  faculty.faculty , pulpit.pulpit,progress.subject,progress.note from faculty,pulpit,progress
where progress.note >any(select progress.note from progress
where progress.subject like '����')


select �����������.��������_�����������,����������_���������.���������_���� from �����������,����������_���������
where  �����������.��������_�����������=����������_���������.����������� and ��������_����������� in (select �����������.��������_����������� from �����������
where(����������_���� like ('%����%') or ����������_���� like('%����%')))

select �����������.��������_�����������,����������_���������.���������_���� from ����������� inner join ����������_���������
on �����������.��������_����������� = ����������_���������.�����������
where ����������� in (select �����������.��������_����������� from �����������
where(����������_���� in('����','������')))

select �����������.��������_�����������,����������_���������.���������_���� from ����������� inner join ����������_���������
on �����������.��������_����������� = ����������_���������.�����������
where (����������_���������.���������_���� like('%45%'))

select ����������_���������.����������� from ����������_���������
where  exists (select * from �����������
where ����������_���������.�����������=�����������.��������_�����������)

select top(1)
(select avg(����������.����������_����������) from ����������
where ��������_���������� like '�����')

select �����������.��������_�����������,�����������.����������_����,����������.��������_����������,����������.����������_���������� from ����������,�����������
where ����������.����������_���������� <=all(select ����������.����������_���������� from ����������
where ����������.��������_���������� like '�����')

select �����������.��������_�����������,�����������.����������_����,����������.��������_����������,����������.����������_���������� from ����������,�����������
where ����������.����������_���������� <=any(select ����������.����������_���������� from ����������
where ����������.��������_���������� like '�����')

select min(auditorium_capacity) [�����������_�����������],
	   max(auditorium_capacity) [������������_�����������],
	   avg(auditorium_capacity) [�������_�����������],
	   count (*)                [���-�� ���������],
	   sum(auditorium_capacity) [�����_����������� ���� ���������]
from auditorium 
select auditorium_name,
       min(auditorium_capacity) [�����������_�����������],
	   max(auditorium_capacity) [������������_�����������],
	   avg(auditorium_capacity) [�������_�����������],
	   sum(auditorium_capacity) [�����_����������� ���� ���������]
from auditorium inner join auditorium_type 
on auditorium.auditorium_type=auditorium_type.auditorium_type
group by auditorium_name

select *
from (select case 
	when note between 4 and 5 then '4-5'
	when note between 6 and 7  then '6-7'
	when note between 8 and 9  then '8-9'
	when note = 10 then '10'
   end  [�������], COUNT (*) [����������]    
FROM progress Group by Case 
	when note between 4 and 5 then '4-5'
	when note between 6 and 7  then '6-7'
	when note between 8 and 9  then '8-9'
	when note = 10 then '10'
   end ) as T
ORDER BY  Case [�������]
    when '4-5' then 3
	when '6-7'  then 2
	when '8-9'  then 1
	when '10' then 0
   end  
select faculty.faculty[���������], groups.profession[�������������],student.course[����],
round(avg(cast(progress.note as float(4))),2)[������]
from faculty inner join groups
on  groups.faculty=faculty.faculty inner join student  on groups.idgroup  = student.idgroup inner join progress
on student.idstudent = progress.idstudent
group by faculty.faculty,
 groups.profession,
 student.course

 select faculty.faculty[���������], groups.profession[�������������],student.course[����],
round(avg(cast(progress.note as float(4))),2)[������]
from faculty inner join groups
on  groups.faculty=faculty.faculty inner join student  on groups.idgroup  = student.idgroup inner join progress
on student.idstudent = progress.idstudent
where progress.subject like('%��%')
group by faculty.faculty,
 groups.profession,
 student.course

 select faculty.faculty[���������], groups.profession[�������������],
 round(avg(cast(progress.note as float(4))),2)[������]
 from faculty inner join groups
on  groups.faculty=faculty.faculty inner join student  on groups.idgroup  = student.idgroup inner join progress
on student.idstudent = progress.idstudent
where faculty.faculty like('%����%')
group by rollup ( faculty.faculty,
 groups.profession,
 student.course
 )
  select faculty.faculty[���������], groups.profession[�������������],
 round(avg(cast(progress.note as float(4))),2)[������]
 from faculty inner join groups
on  groups.faculty=faculty.faculty inner join student  on groups.idgroup  = student.idgroup inner join progress
on student.idstudent = progress.idstudent
where faculty.faculty like('%����%')
group by cube ( faculty.faculty,
 groups.profession,
 student.course
 )

 select faculty.faculty[���������], groups.profession[�������������],
 round(avg(cast(progress.note as float(4))),2)[������]
 from faculty inner join groups
on  groups.faculty=faculty.faculty inner join student  on groups.idgroup  = student.idgroup inner join progress
on student.idstudent = progress.idstudent
where faculty.faculty like('%����%')
group by  faculty.faculty,
 groups.profession,
 student.course
 union
 select faculty.faculty[���������], groups.profession[�������������],
 round(avg(cast(progress.note as float(4))),2)[������]
 from faculty inner join groups
on  groups.faculty=faculty.faculty inner join student  on groups.idgroup  = student.idgroup inner join progress
on student.idstudent = progress.idstudent
where faculty.faculty like('%����%')
group by  faculty.faculty,
 groups.profession,
 student.course

  select faculty.faculty[���������], groups.profession[�������������],
 round(avg(cast(progress.note as float(4))),2)[������]
 from faculty inner join groups
on  groups.faculty=faculty.faculty inner join student  on groups.idgroup  = student.idgroup inner join progress
on student.idstudent = progress.idstudent
where faculty.faculty like('%����%')
group by  faculty.faculty,
 groups.profession,
 student.course
 union all
 select faculty.faculty[���������], groups.profession[�������������],
 round(avg(cast(progress.note as float(4))),2)[������]
 from faculty inner join groups
on  groups.faculty=faculty.faculty inner join student  on groups.idgroup  = student.idgroup inner join progress
on student.idstudent = progress.idstudent
where faculty.faculty like('%����%')
group by  faculty.faculty,
 groups.profession,
 student.course

  select faculty.faculty[���������], groups.profession[�������������],
 round(avg(cast(progress.note as float(4))),2)[������]
 from faculty inner join groups
on  groups.faculty=faculty.faculty inner join student  on groups.idgroup  = student.idgroup inner join progress
on student.idstudent = progress.idstudent
where faculty.faculty like('%����%')
group by  faculty.faculty,
 groups.profession,
 student.course
 intersect
 select faculty.faculty[���������], groups.profession[�������������],
 round(avg(cast(progress.note as float(4))),2)[������]
 from faculty inner join groups
on  groups.faculty=faculty.faculty inner join student  on groups.idgroup  = student.idgroup inner join progress
on student.idstudent = progress.idstudent
where faculty.faculty like('%����%')
group by  faculty.faculty,
 groups.profession,
 student.course

  select faculty.faculty[���������], groups.profession[�������������],
 round(avg(cast(progress.note as float(4))),2)[������]
 from faculty inner join groups
on  groups.faculty=faculty.faculty inner join student  on groups.idgroup  = student.idgroup inner join progress
on student.idstudent = progress.idstudent
where faculty.faculty like('%����%')
group by  faculty.faculty,
 groups.profession,
 student.course
 except
 select faculty.faculty[���������], groups.profession[�������������],
 round(avg(cast(progress.note as float(4))),2)[������]
 from faculty inner join groups
on  groups.faculty=faculty.faculty inner join student  on groups.idgroup  = student.idgroup inner join progress
on student.idstudent = progress.idstudent
where faculty.faculty like('%����%')
group by  faculty.faculty,
 groups.profession,
 student.course

 select p1.subject, p1.note,
 (select count(*) from  progress p2
 where p2.subject = p1.subject and p2.note = p1.note ) [count]
 from progress p1
 group by  p1.subject , p1.note 
 having note = 9 or note = 8

 select ����������.��������_����������,
		min(����������.����������_����������) [min],
		max(����������.����������_����������) [max],
		count(*) [count],
		sum(����������.����������_����������)[all]
from ����������
group by ��������_����������

SELECT  *
 FROM (select Case 
   when ����������.����������_���������� = 4 then '���������� = 4'
   when ����������.����������_���������� = 5 then '���������� = 5'
   when ����������.����������_���������� = 6 then '���������� = 6'
   end  [����������� �� 4 �� 6], COUNT (*) [����������]    
FROM ���������� Group by Case 
  when ����������.����������_���������� = 4 then '���������� = 4'
   when ����������.����������_���������� = 5 then '���������� = 5'
   when ����������.����������_���������� = 6 then '���������� = 6'
   end ) as T
ORDER BY  Case [����������� �� 4 �� 6]
   when '���������� = 4' then 3
   when '���������� = 5' then 2
   when '���������� = 6' then 1
   else 0
   end  

   select �����������.��������_�����������,����������.��������_����������,
   round(avg(cast(����������.����������_���������� as float (4))),2) [����������_����������]
   from �����������, ����������
   where ����������.����������_���������� = 4
   group by �����������.��������_�����������,����������.��������_����������

   select �����������.��������_�����������, �����������.����������_����,�����������.�������
   from �����������
   where �����������.����������_���� in('maks','andrey','ilya')
   group by  rollup (�����������.��������_�����������, �����������.����������_����,�����������.�������)

    select �����������.��������_�����������, �����������.����������_����,�����������.�������
   from �����������
   where �����������.����������_���� in('maks','andrey','ilya')
   group by  cube (�����������.��������_�����������, �����������.����������_����,�����������.�������)

   select �����������.��������_�����������, �����������.����������_����,�����������.�������
   from �����������
   where �����������.����������_���� = 'maks' or �����������.����������_����='����'

 union
 select �����������.��������_�����������, �����������.����������_����,�����������.�������
   from �����������
   where �����������.����������_���� =  'andrey' or �����������.����������_����= '����'

   select �����������.��������_�����������, �����������.����������_����,�����������.�������
   from �����������
   where �����������.����������_���� = 'maks' or �����������.����������_����='����'

 intersect
 select �����������.��������_�����������, �����������.����������_����,�����������.�������
   from �����������
   where �����������.����������_���� =  'andrey' or �����������.����������_����= '����'
   ----
   select �����������.��������_�����������, �����������.����������_����,�����������.�������
   from �����������
   where �����������.����������_���� = 'maks' or �����������.����������_����='����'
 except
 select �����������.��������_�����������, �����������.����������_����,�����������.�������
   from �����������
   where �����������.����������_���� =  'andrey' or �����������.����������_����= '����'
 ----
   select �����������.��������_�����������, �����������.����������_����,�����������.�������
   from �����������
   where �����������.����������_���� in('maks')
 group by  �����������.��������_�����������, �����������.����������_����,�����������.�������
 intersect
 select �����������.��������_�����������, �����������.����������_����,�����������.�������
   from �����������
   where �����������.����������_���� in('andrey')
 group by  �����������.��������_�����������, �����������.����������_����,�����������.�������

 
   select �����������.��������_�����������, �����������.����������_����,�����������.�������
   from �����������
   where �����������.����������_���� in('maks')
 group by  �����������.��������_�����������, �����������.����������_����,�����������.�������
 except
 select �����������.��������_�����������, �����������.����������_����,�����������.�������
   from �����������
   where �����������.����������_���� in('andrey')
 group by  �����������.��������_�����������, �����������.����������_����,�����������.�������

 select p1.��������_����������, p1.����������_����������,
 (select count(*) from  ���������� p2
 where p2.��������_���������� = p1.��������_���������� and p2.����������_���������� = p1.����������_���������� ) [count]
 from ���������� p1
 group by  p1.��������_���������� , p1.����������_����������
 having ����������_���������� = 4 or ����������_���������� = 5

 ---
 create view [�����������_]
 as select  �����������.��������_�����������, �����������.����������_����
 from �����������
 select * from �����������_
 drop view �����������_
 ---
 insert 



 ---
 alter view [�����������_]
 as select �����������.�������
 from �����������
  select * from �����������_
 ----
insert  �����������_ values('�������','�������')
select * from �����������_


----
create view [���������_�����������]
as select �����������.��������_�����������,
		  �������_�����������.��������_����������
from ����������� inner join �������_�����������
on �����������.��������_����������� = �������_�����������.��������_�����������
select * from [���������_�����������]
----
create view  �������_����������(�����������,����������,��������_����������)
	as select �������_�����������.��������_�����������,�������_�����������.����������,�������_�����������.��������_����������
	from �������_�����������
	where �������_�����������.��������_���������� > 5;
go
select * from �������_����������
----
alter view
 �������_����������(�����������,����������,��������_����������)
	as select �������_�����������.��������_�����������,�������_�����������.����������,�������_�����������.��������_����������
	from �������_�����������
	where �������_�����������.��������_���������� > 6 with check option;
go
insert  ����������� values('���������',4231423,'���-��','�')
insert  �������_���������� values('���������','��������',7)
---
create view �������(�����������,����������,��������_����������)
   as select top(2) �������_�����������.��������_�����������,�������_�����������.����������,�������_�����������.��������_����������
	from �������_�����������
   order by �������_�����������.��������_�����������
---
alter view [���������_�����������] with schemabinding
as select �����������.��������_�����������,
		  �������_�����������.��������_����������
from dbo.����������� inner join dbo.�������_�����������
on �����������.��������_����������� = �������_�����������.��������_�����������
select * from ���������_�����������


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
SELECT @col  '���������� ���������',  @AVGvmes   '������� ����������� ���������',  @col_a   '���������� ���������, ����������� ������� ������ �������',cast (@poth as int)'% ������� ����� ���������'
End
else if @capacity<200
Select @capacity '����� �����������';

PRINT '����� ������������ ����� '+cast(@@ROWCOUNT as nvarchar(20));
PRINT '������ SQL Server '+cast(@@VERSION as nvarchar(20));
PRINT '��������� ������������� �������� '+cast(@@SPID as varchar(20));
PRINT '��� ��������� ������ '+cast(@@ERROR as varchar(20));
PRINT '��� ������� '+cast(@@SERVERNAME as varchar(20));
PRINT '������� ����������� ���������� '+cast(@@TRANCOUNT  as varchar(20));
PRINT '�������� ���������� ���������� ����� ��������������� ������ '+cast(@@FETCH_STATUS  as varchar(20));
PRINT '������� ����������� ������� �����-���� '+cast(@@NESTLEVEL as varchar(20));

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

Declare @name nvarchar(29)='�������� ������� ����������'
SET @name=replace(@name,'������� ����������','T.�');
PRINT @name

DECLARE @dt datetime = getdate();
Select STUDENT.NAME, STUDENT.BDAY from STUDENT where MONTH(BDAY)=MONTH(dateadd(M, 1, @dt));

declare @day date
Select @day=PROGRESS.PDATE from PROGRESS where PROGRESS.SUBJECT='����'
PRINT  DATENAME(weekday,@day)

Declare @col_N int=(select count(*) from PROGRESS)
if(@col_N>10)
Begin
Print '������ ������� >10 �������';
PRINT '���������� �������� ���������� ������ - '+cast(@col_N as varchar(10));
end
else
Begin 
Print '������ ������� <10 �������';
PRINT '���������� �������� ���������� ������ - '+cast(@col_N as varchar(10));
end 

Select case 
     when  SUBJECT='��' and NOTE between 0 and 6 then '�����'
	 when SUBJECT='��' and NOTE between 6 and 8 then '���������' 
	 when SUBJECT='��' and NOTE between 8 and 10 then '������'
	 end NOTE , count(*) [����������] 
from PROGRESS
GROUP BY CASE 
      when  SUBJECT='��' and NOTE between 0 and 6 then '�����'
	 when SUBJECT='��' and NOTE between 6 and 8 then '���������' 
	 when SUBJECT='��' and NOTE between 8 and 10 then '������'
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
	delete  #localtable
create table #lt
(
TKEY int, CC int identity(1,1),TF varchar(100)
)

  set nocount on;           
  declare @i int = 0;
  while   @i < 20000       -- ���������� � ������� 20000 �����
  begin
  INSERT #lt(TKEY, TF) values(floor(30000*RAND()), replicate('string ', 10));
  set @i = @i+1; 
  end;
  go
  SELECT count(*)[���������� �����] from #lt;
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
  while   @i < 20000       -- ���������� � ������� 20000 �����
  begin
  INSERT #ltt(TKEY, TF) values(floor(30000*RAND()), replicate('string ', 10));
  set @i = @i+1; 
  end;
  go
  SELECT count(*)[���������� �����] from #ltt;
  SELECT * from #ltt
CREATE  index #ltt_tkey on #lt(TKEY) INCLUDE (CC)
SELECT CC from #ltt where TKEY < 15000 


	create table #lttt
(
TKEY int, CC int identity(1,1),TF varchar(100)
)
set nocount on;           
  declare @i int = 0;
  while   @i < 20000       -- ���������� � ������� 20000 �����
  begin
  INSERT #lttt(TKEY, TF) values(floor(30000*RAND()), replicate('string ', 10));
  set @i = @i+1; 
  end;
  go
  SELECT count(*)[���������� �����] from #lttt;
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
  while   @i < 20000       -- ���������� � ������� 20000 �����
  begin
  INSERT #ltttt(TKEY, TF) values(floor(30000*RAND()), replicate('string ', 10));
  set @i = @i+1; 
  end;
  go
  SELECT count(*)[���������� �����] from #ltttt;
  SELECT * from #ltttt

  create index #ltttt_tkey on #ltttt(tkey)
    SELECT name [������], avg_fragmentation_in_percent [������������ (%)]
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

		SELECT name [������], avg_fragmentation_in_percent [������������ (%)]
FROM sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'), OBJECT_ID(N'#ltttt'), NULL, NULL, NULL) ss
       JOIN sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id  
                              where name is not null;

  	create table #lttttt
(
TKEY int, CC int identity(1,1),TF varchar(100)
)
  declare @i int = 0;
  while   @i < 20000       -- ���������� � ������� 20000 �����
  begin
  INSERT #lttttt(TKEY, TF) values(floor(30000*RAND()), replicate('string ', 10));
  set @i = @i+1; 
  end;
  go
  SELECT count(*)[���������� �����] from #lttttt;
  SELECT * from #lttttt

  delete  from #lttttt
 TRUNCATE TABLE #lttttt
 create view  ����������_������(���������,�����_������)
	as select Pulpit.faculty,count(PULPIT.PULPIT)
	from pulpit
group by pulpit.faculty, pulpit.pulpit
Create view[����������_������1] 
as select FACULTY.FACULTY_NAME[���������], 
count(*) [���������� ������] from FACULTY join PULPIT on FACULTY.FACULTY=PULPIT.PULPIT 
group by FACULTY.FACULTY_NAME 
go 
Select * from[����������_������1]

-------lab12 cursors
declare @subject nvarchar(20), @space nvarchar(300)=''
declare name_subject cursor for select SUBJECT.SUBJECT from SUBJECT  where SUBJECT.PULPIT = '����'
open name_subject 
fetch name_subject into @subject 
print '�������� ���������'
while @@FETCH_STATUS=0
begin 
set @space=RTRIM(@subject)+','+@space
fetch name_subject into @subject
end
print @space
close name_subject
-----
declare subjectsAndPulpit cursor local
for	 select SUBJECT.SUBJECT,SUBJECT.PULPIT from SUBJECT
declare @subject_name nvarchar(20),@pulpit_name nvarchar(10)
open subjectsAndPulpit 
fetch subjectsAndPulpit  into @subject_name,@pulpit_name
print '1.'+ @subject_name+'2.'+@pulpit_name
go
declare @subject_name nvarchar(20),@pulpit_name nvarchar(10)
fetch subjectsAndPulpit  into @subject_name,@pulpit_name
print '1.'+ @subject_name+'2.'+@pulpit_name
go

declare subjectsPulpit cursor global
for	 select SUBJECT.SUBJECT,SUBJECT.PULPIT from SUBJECT
declare @subject_name nvarchar(20),@pulpit_name nvarchar(10)
open subjectsPulpit 
fetch subjectsPulpit  into @subject_name,@pulpit_name
print '1.'+ @subject_name+'2.'+@pulpit_name
go
declare @subject_name nvarchar(20),@pulpit_name nvarchar(10)
fetch subjectsPulpit  into @subject_name,@pulpit_name
print '1.'+ @subject_name+'2.'+@pulpit_name
close subjectsPulpit
deallocate subjectsPulpit;
---------
declare @subject nvarchar(20),@subject_name nvarchar(20),@pulpit nvarchar(20)
declare subject cursor local dynamic
for select SUBJECT.SUBJECT, SUBJECT.SUBJECT_NAME,SUBJECT.PULPIT from SUBJECT where SUBJECT.PULPIT = '����'
open subject
print '���������� �����:'+cast(@@CURSOR_ROWS as varchar(5))
----
update SUBJECT set SUBJECT.SUBJECT ='Database' where SUBJECT.PULPIT='������'
insert SUBJECT (SUBJECT,SUBJECT_NAME)
values('MP','Math Programming')
----
declare @subject nvarchar(20),@subject_name nvarchar(20),@pulpit nvarchar(20)
fetch subject into @subject,@subject_name,@pulpit
while @@FETCH_STATUS=0
begin
print @subject + '' + @subject_name + '' + @pulpit
fetch subject into @subject, @subject_name, @pulpit
end 
close subject 
----
declare  @tc int, @rn char(50);  
         declare navigation cursor local dynamic SCROLL                               
               for select row_number() over (order by SUBJECT) N,
	     SUBJECT.SUBJECT_NAME from dbo.SUBJECT where SUBJECT.PULPIT = '����' 
	open navigation;
	fetch  navigation into  @tc, @rn;                 
	print '��������� ������        : ' + cast(@tc as varchar(3))+ rtrim(@rn);      
	fetch  LAST from  navigation into @tc, @rn;       
	print '��������� ������        : ' +  cast(@tc as varchar(3))+ rtrim(@rn);      
      close navigation;
----
declare @subject nvarchar(20),@subject_name nvarchar(20),@pulpit nvarchar(20)
    declare currentOff cursor local dynamic  
	for select SUBJECT.SUBJECT,SUBJECT.SUBJECT_NAME, SUBJECT.PULPIT
	     from SUBJECT FOR UPDATE; 
     open currentOff;  
     fetch  currentOff into @subject, @subject_name, @pulpit; 
     delete SUBJECT where CURRENT OF currentOff;	
     fetch  currentOff into @subject, @subject_name, @pulpit; 
     update SUBJECT set SUBJECT = 'hm' where CURRENT OF currentOff;
     close currentOff;
---
delete PROGRESS where PROGRESS.NOTE <=4
update PROGRESS set NOTE += 1 where IDSTUDENT = 1014

declare @tn int, @tc date, @tk nvarchar(max);   
    declare Primer2 cursor local dynamic  
	for select  PROGRESS.NOTE, PROGRESS.PDATE, PROGRESS.SUBJECT
	     from PROGRESS FOR UPDATE; 
     open Primer2;  
     fetch  Primer2 into @tn, @tc, @tk  
     delete PROGRESS where  current of primer2	
     fetch  Primer2 into @tn, @tc, @tk; 
     update PROGRESS set NOTE = NOTE+1 where  CURRENT OF Primer2;
     close Primer2;
	
	
	
	
	 --lab13
      set nocount on
	if  exists (select * from  SYS.OBJECTS       
	            where OBJECT_ID= object_id(N'DBO.X') )	            
	drop table X;           
	declare @c int, @flag char = 'c';           
	SET IMPLICIT_TRANSACTIONS  ON   
	    create table X(K int );                        
		insert X values (1),(2),(3);
		set @c = (select count(*) from X);
		print '���������� ����� � ������� X: ' + cast( @c as varchar(2));
		if @flag = 'r'  commit;                  
	          else      rollback;                              
      SET IMPLICIT_TRANSACTIONS  OFF  
	
	if  exists (select * from  SYS.OBJECTS      
	            where OBJECT_ID= object_id(N'DBO.X') )
	print '������� X ����';  else print '������� X ���'
	-----
	use R_UNIVER;
	begin try
	 begin tran               
	   delete SUBJECT where SUBJECT = '��'; 
	   insert SUBJECT values ('��','�������������� ����������������',  '����');
	   commit tran;              
	end try
	begin catch
	    print '������: '+ case 
          when error_number() = 2627 and patindex('%SUBJECT_PK%', error_message()) > 0
          then '������������ ������' 
          else '����������� ������: '+ cast(error_number() as  varchar(5))+ error_message()  
	  end; 
	 if @@trancount > 0 rollback tran ; 	  
     end catch;
	-----
	declare @point varchar(32);                               
begin try
  begin tran                                                           
	delete SUBJECT where SUBJECT ='��'; 
	set @point = 'p1'; save tran @point;          
	insert SUBJECT values ('��',' ������������� ������ � ������������ ��������',  '����');
	set @point = 'p2'; save tran @point;           
	insert SUBJECT values ('���',' ������ ������ ����������',  '����'); 
	commit tran;                                                    
   end try
   begin catch
	print '������: '+ case 
      when error_number() = 2627 and patindex('%SUBJECT_PK%', error_message()) > 0
      then '������������ ������' 
      else '����������� ������: '+ cast(error_number() as  varchar(5)) + error_message()  
	end; 
   if @@trancount > 0 
	begin
	   print '����������� �����: '+ @point;
	   rollback tran @point;                                  
	   commit tran;                  
	end;     
   end catch;
   -------------------------------------------------
 -- A ---
	set transaction isolation level READ UNCOMMITTED 
	begin transaction 
	-------------------------- t1 ------------------
	  select @@SPID, 'insert Subject' '���������', * from SUBJECT 
	                                                             where SUBJECT='��';
	  select @@SPID, 'update Subject'  '���������', 
            SUBJECT.SUBJECT,SUBJECT.SUBJECT_NAME  from SUBJECT  
	                                               where SUBJECT='��';
	  commit; 
	  -------------------------- t2 -----------------
--- B --	
	begin transaction 
	select @@SPID
	insert SUBJECT values ('��', '����������','����'); 
	update SUBJECT set SUBJECT = '����' 
                           where SUBJECT = '���' 
	rollback;
	--5




-- A ---
      set transaction isolation level READ COMMITTED 
	begin transaction 
	select count(*) from SUBJECT
	where SUBJECT = '��';
	-------------------------- t1 ------------------ 
	-------------------------- t2 -----------------
	select  'update Subject'  '���������', count(*)
	from SUBJECT  where SUBJECT = '��';
	commit; 
	--- B ---	
	begin transaction 	  
	-------------------------- t1 --------------------
          update SUBJECT set SUBJECT = '���' 
                                       where SUBJECT = '��' 
          commit; 
	-------------------------- t2 --------------------	





	--------------------////----------------------
	-- A ---
          set transaction isolation level  REPEATABLE READ 
	begin transaction 
	select SUBJECT.SUBJECT_NAME from SUBJECT where SUBJECT = '��';
	-------------------------- t1 ------------------ 
	-------------------------- t2 -----------------
	select  case
          when SUBJECT.SUBJECT = '���' then 'insert  Subject'  else ' ' 
end '���������', SUBJECT.SUBJECT_NAME from SUBJECT  where SUBJECT_NAME = '�������������� ����������';
	commit; 
	--- B ---	
	begin transaction 	  
	-------------------------- t1 --------------------
          insert SUBJECT values ( 'C#', 'C# programming', '����');
          commit; 
	-------------------------- t2 --------------------



-----///////////////////---------
use master;
	go
	alter database R_UNIVER set allow_snapshot_isolation on

	set transaction isolation level SNAPSHOT 
	begin transaction 
	select *  from SUBJECT where SUBJECT = '��';
	-------------------------- t1 ------------------ 
delete SUBJECT where SUBJECT = '���';  
          insert SUBJECT values ('���', '������������� ������ � ������������ ��������', '����');
          update SUBJECT set SUBJECT_NAME = '������������� ������ � ��������' where SUBJECT = '���';
	-------------------------- t2 -----------------
	select  SUBJECT from SUBJECT  where SUBJECT.SUBJECT = '���';
	commit; 
	--- B ---	
	begin transaction 	  
	-------------------------- t1 --------------------
delete SUBJECT where SUBJECT = '���';  
         insert SUBJECT values ('���', '������������� ������ � ������������ ��������', '����');
        update SUBJECT set SUBJECT_NAME = '������������� ������ � ��������' where SUBJECT = '���';
          commit; 
	-------------------------- t2 --------------------




----------------//////////////////////////----------------
      -- A ---
          set transaction isolation level SERIALIZABLE 
	begin transaction 
		delete SUBJECT where SUBJECT = '���';  
         insert SUBJECT values ('���', '������������� ������ � ������������ ��������', '����');
        update SUBJECT set SUBJECT_NAME = '������������� ������ � ��������' where SUBJECT = '���';
          	select SUBJECT  from SUBJECT where SUBJECT = '��';
	-------------------------- t1 -----------------
		select SUBJECT  from SUBJECT where SUBJECT = '��';
	-------------------------- t2 ------------------ 
	commit; 	
	--- B ---	
	begin transaction 	  
	delete SUBJECT where SUBJECT = '���';  
         insert SUBJECT values ('���', '������������� ������ � ������������ ��������', '����'),
        update SUBJECT set SUBJECT_NAME = '������������� ������ � ��������' where SUBJECT = '���';
         select SUBJECT  from SUBJECT where SUBJECT = '��';
          -------------------------- t1 --------------------
          commit; 
         select SUBJECT  from SUBJECT where SUBJECT = '��';
      -------------------------- t2 --------------------




----------///---------------------------
begin tran                                          
 insert SUBJECT values ('����', '������������� ������ � ������������ ��������', '����')
begin tran                                          
update SUBJECT set SUBJECT = '���' where SUBJECT = '����';
commit;                                            
if @@trancount > 0  rollback;        
select   (select count(*) from SUBJECT where SUBJECT = '���') '������� 1', 
(select count(*) from SUBJECT  where SUBJECT = '��') '������� 2'; 

----14

CREATE PROCEDURE PPRED
as  begin 
declare @k int = (select count (*) from �����������);
select * from �����������;
return @k;
end;
declare @k int = 0;
    EXEC @k=PPRED;   
    print '���-�� predpriyatii = '+cast(@k as varchar(3));


	CREATE PROCEDURE P_INSERT
 @a nvarchar(20), @n int, @c nvarchar(20),@t nvarchar(1)    as  declare @rc int=1;                            
begin try                                     
insert into ����������� (�����������.��������_�����������,�����������.�������,�����������.����������_����,�����������.���)
values (@a,@n,@c,@t)
return @rc;
end try  
begin catch              -- ��������� ������ 
  print '����� ������  : ' + cast(error_number() as varchar(6));
  print '���������     : ' + error_message();
  print '�������       : ' + cast(error_severity()  as varchar(6));
  print '�����         : ' + cast(error_state()     as varchar(8));
  print '����� ������  : ' + cast(error_line()      as varchar(8));
  if error_procedure() is not  null   
  print '��� ��������� : ' + error_procedure();
   return -1;
   end  catch; 


   declare @rc int;  
exec @rc=P_INSERT @a='����',@n=12312,@c='andrey',@t='�'
print '��� ������ : ' + cast(@rc as varchar(3)); 


---
CREATE table  #Zk
(SUBJECT	char(10) ,
	 SUBJECT_NAME varchar(100) ,
     PULPIT       char(20),
	 )
	 insert #Zk exec PSUBJECT @p='��';
select * from #Zk

use R_UNIVER
go
CREATE PROCEDURE PAUDITORIUM_INSERT
 @a CHAR(20), @n varchar(50), @c INT = null,@t char(10)    as  declare @rc int=1;                            
begin try                                     
insert into AUDITORIUM (AUDITORIUM,AUDITORIUM_NAME,AUDITORIUM_CAPACITY,AUDITORIUM_TYPE)
values (@a,@n,@c,@t)
return @rc;
end try  
begin catch              -- ��������� ������ 
  print '����� ������  : ' + cast(error_number() as varchar(6));
  print '���������     : ' + error_message();
  print '�������       : ' + cast(error_severity()  as varchar(6));
  print '�����         : ' + cast(error_state()     as varchar(8));
  print '����� ������  : ' + cast(error_line()      as varchar(8));
  if error_procedure() is not  null   
  print '��� ��������� : ' + error_procedure();
   return -1;
   end  catch; 


   declare @rc int;  
exec @rc=PAUDITORIUM_INSERT @a='100-3a',@n='100-3a',@c=100,@t='��'
print '��� ������ : ' + cast(@rc as varchar(3)); 







use R_UNIVER
go
CREATE PROCEDURE PSUBJECT 
as  begin 
declare @k int = (select count (*) from SUBJECT);
select * from SUBJECT;
return @k;
end;
declare @k int = 0;
    EXEC @k=PSUBJECT;   
    print '���-�� ��������� = '+cast(@k as varchar(3));

-----
alter procedure PSUBJECT  
           @p varchar(20),
           @c int output
as  begin 
declare @k int = (select count(*) from SUBJECT );
            print '���������: @p='+@p+', @c='+cast(@c as varchar(3));
select PROFESSION.PROFESSION from PROFESSION  where FACULty=@p;
set @c = @@rowcount;
return @k;
end;

declare @k int = 0, @r int=0, @p varchar(20);
exec @k=PSUBJECT @p='����', @c=@r output;    
print 'count all = '+cast(@k as varchar(3));
print 'count '+cast(@p as varchar(3))+'= '+cast(@r as varchar(3));

alter procedure PSUBJECT  
         @p varchar(20)
as  begin 
declare @k int = (select count(*) from SUBJECT );            
select * from SUBJECT  where SUBJECT=@p;
    end;

CREATE table  #Zk
(SUBJECT	char(10) ,
	 SUBJECT_NAME varchar(100) ,
     PULPIT       char(20),
	 )
	 insert #Zk exec PSUBJECT @p='��';
select * from #Zk

CREATE table  #my
( person	char(10) ,
	 NAME varchar(100) ,
     number       int,
	 pol char(1)
	 )
	 insert #Zk exec PSUBJECT @p='��';
select * from #Zk

use R_UNIVER
go
CREATE PROCEDURE PAUDITORIUM_INSERT
 @a CHAR(20), @n varchar(50), @c INT = null,@t char(10)    as  declare @rc int=1;                            
begin try                                     
insert into AUDITORIUM (AUDITORIUM,AUDITORIUM_NAME,AUDITORIUM_CAPACITY,AUDITORIUM_TYPE)
values (@a,@n,@c,@t)
return @rc;
end try  
begin catch              -- ��������� ������ 
  print '����� ������  : ' + cast(error_number() as varchar(6));
  print '���������     : ' + error_message();
  print '�������       : ' + cast(error_severity()  as varchar(6));
  print '�����         : ' + cast(error_state()     as varchar(8));
  print '����� ������  : ' + cast(error_line()      as varchar(8));
  if error_procedure() is not  null   
  print '��� ��������� : ' + error_procedure();
   return -1;
   end  catch; 


   declare @rc int;  
exec @rc=PAUDITORIUM_INSERT @a='100-3a',@n='100-3a',@c=100,@t='��'
print '��� ������ : ' + cast(@rc as varchar(3)); 



create procedure SUBJECT_REPORT @p CHAR(50) 
as 
declare @rc int=0; 
begin try 
declare @tv char(20), @t char(300)=' '; 
declare ZkTov CURSOR for 
select FACULTY from PROFESSION where PROFESSION =@p; 
if not exists(select FACULTY from PROFESSION where PROFESSION = @p) 
raiserror('������',11,1); 
else open ZkTov; 
fetch ZkTov into @tv; 
print '��������'; 
while @@fetch_status = 0 
begin 
set @t = rtrim(@tv)+', '+@t; 
set @rc=@rc+1; 
fetch ZkTov into @tv; 
end; 
print @t; 
close ZkTov; 
return @rc; 
end try 
begin catch 
print '������ � ����������' 
if error_procedure() is not null 
print '��� ��������� : ' + error_procedure(); 
return @rc; 
end catch; 

declare @rc int; 
exec @rc=SUBJECT_REPORT @p ='1-36 01 08 '; 
--6 
create procedure PAUDITORIUM_INSERTX 
@a CHAR(20), @n VARCHAR(50), @1c INT = null, @t CHAR(10),@tn VARCHAR(50) output 
as declare @rc int=1; 
begin try 
set transaction isolation level SERIALIZABLE; 
begin tran 
insert into AUDITORIUM_TYPE (AUDITORIUM_TYPE ,AUDITORIUM_TYPENAME) 
values (@t,@tn) 
exec @rc=PAUDITORIUM_INSERT @a, @n, @1c,@t; 
commit tran; 
return @rc; 
end try 
begin catch 
print '����� ������ : ' + cast(error_number() as varchar(6)); 
print '��������� : ' + error_message(); 
print '������� : ' + cast(error_severity() as varchar(6)); 
print '����� : ' + cast(error_state() as varchar(8)); 
print '����� ������ : ' + cast(error_line() as varchar(8)); 
if error_procedure() is not null 
print '��� ��������� : ' + error_procedure(); 
if @@trancount > 0 rollback tran ; 
return -1; 
end catch; 

declare @rc int; 
exec @rc=PAUDITORIUM_INSERTX @a='101-2', @n ='101-2', @1c = 24 ,@t='=��',@tn='����������'; 
print '��� ������=' + cast(@rc as varchar(3));

-----------LAB15

    create function COUNT_STUDENTS(@faculty varchar(20)) returns int
    as begin  declare @rc int = 0;
    set @rc = (select count(STUDENT.IDSTUDENT) 
	        from GROUPS   
			join  FACULTY on GROUPS.FACULTY=FACULTY.FACULTY
			join  STUDENT on GROUPS.IDGROUP=STUDENT.IDGROUP 
            where FACULTY.FACULTY = @faculty) ;  
	    return @rc;          
	    end
	    declare @faculty int=dbo.COUNT_STUDENTS('���');
        print '���������� ���������= '+cast(@faculty as varchar(4));
	    select FACULTY.FACULTY, 
        dbo.COUNT_STUDENTS(FACULTY.FACULTY)from FACULTY;	
	    alter function COUNT_STUDENTS(@faculty varchar(20)=NUll,@prof varchar(20)=NULL) returns int
        as begin  declare @rc int = 0;
        set @rc = (select count(STUDENT.IDSTUDENT) 
	        from GROUPS   
			join  FACULTY on GROUPS.FACULTY=FACULTY.FACULTY
			join  STUDENT on GROUPS.IDGROUP=STUDENT.IDGROUP 
             where FACULTY.FACULTY = @faculty and FACULTY.FACULTY_NAME=@prof) ;  
	 return @rc;          
	 end
	 select FACULTY.FACULTY, 
       dbo.COUNT_STUDENTS(FACULTY.FACULTY,FACULTY.FACULTY_NAME)from FACULTY;
--------
	   create FUNCTION FSUBJECTS(@p varchar(20)) returns char(300) 
     as
     begin  
     declare @tv char(20);  
     declare @t varchar(300) = '����������: ';  
     declare ZkTovar CURSOR LOCAL 
     for select SUBJECT from SUBJECT where SUBJECT.PULPIT=@p;
  	open ZkTovar;	  
	fetch  ZkTovar into @tv;   	 
	while @@fetch_status = 0                                     
          begin 
          set @t = @t+ ', '+ rtrim(@tv);         
          FETCH  ZkTovar into @tv; 
          end;    
		  return @t;
      end;  

   select SUBJECT,  dbo.FSUBJECTS 
                               (SUBJECT.PULPIT)  from SUBJECT ;
	--------
	create function FFACPUL(@f varchar(50), @p varchar(50)) returns table 
      as return 
          select FACULTY.FACULTY, PULPIT.PULPIT  
          from FACULTY left outer join PULPIT 
          on FACULTY.FACULTY = PULPIT.FACULTY
          where FACULTY.FACULTY = isnull(@f,FACULTY.FACULTY) 
          and PULPIT.PULPIT = isnull(@p, PULPIT.PULPIT);
   select * from dbo.FFACPUL(NULL,NULL);
   select * from dbo.FFACPUL('����',NULL);
   select * from dbo.FFACPUL(NULL,'�����');
   select * from dbo.FFACPUL('����','�����');
-------
create function FCTEACHER(@p varchar(50)) returns int 
as
 begin
    declare @rc int =(select count(*) from PULPIT
    where PULPIT = isnull(@p, PULPIT));
    return @rc;
 end;  
 go  
     select  PULPIT.PULPIT, dbo.FCTEACHER(PULPIT) [���������� ��������������]    from PULPIT       
     select dbo.FCTEACHER(NULL) [����� ��������������]


	 create function FACULTY_REPORT(@c int) 
returns @fr table
	([���������] varchar(50), [���������� ������] int, [���������� �����]  int, 
	                [���������� ���������] int, [���������� ��������������] int)
	as begin 
		declare cc cursor static for select FACULTY from FACULTY where dbo.COUNT_STUDENTS(FACULTY) > @c; 
		declare @f varchar(30);
	    open cc;  
		    fetch cc into @f; 
	        while @@fetch_status = 0
	        begin
	            insert @fr values 
				(@f,  
				(select count(PULPIT) from PULPIT where FACULTY = @f), 
	            (select count(IDGROUP) from GROUPS where FACULTY = @f),
				dbo.Count_Students(@f), 
	            (select count(PROFESSION) from PROFESSION where FACULTY = @f)); 
	            fetch cc into @f;  
	         end;   
		close cc;
		return; 
	end;

	 create function COUNT_PULPIT(@faculty varchar(20)) returns int
as begin
	declare @rc int = 0;
	set @rc = (select count(*) from PULPIT join FACULTY on PULPIT.FACULTY = FACULTY.FACULTY 
											where FACULTY.FACULTY = @faculty);
	return @rc;
end;


create function COUNT_GROUP(@faculty varchar(20)) returns int
as begin
	declare @rc int = 0;
	set @rc = (select count(*) from GROUPS join FACULTY on FACULTY.FACULTY = GROUPS.FACULTY
											where FACULTY.FACULTY = @faculty);
	return @rc;
end


create function COUNT_PROF(@faculty varchar(20)) returns int
as begin
	declare @rc int = 0;
	set @rc = (select count(*) from PROFESSION join FACULTY on PROFESSION.FACULTY = FACULTY.FACULTY
											where FACULTY.FACULTY = @faculty);
	return @rc;
end


alter function FACULTY_REPORT(@c int) returns @fr table
	([���������] varchar(50), [���������� ������] int, [���������� �����]  int, 
	                [���������� ���������] int, [���������� ��������������] int)
	as begin 
		declare cc cursor static for select FACULTY from FACULTY where dbo.COUNT_STUDENTS(FACULTY) > @c; 
		declare @f varchar(30);
	    open cc;  -- ���� �� �����������
		    fetch cc into @f; -- �������� �������� ���������� � @f
	        while @@fetch_status = 0
	        begin
	            insert @fr values -- ��������� ������ � �������
				(@f,  -- ���������
				dbo.COUNT_PULPIT(@f), -- ���������� ������
	            dbo.COUNT_GROUP(@f), -- ���������� ����
				dbo.COUNT_STUDENTS(@f), -- ���������� ��������� 
	            dbo.COUNT_PROF(@f)); -- ���������� ��������������
	            fetch cc into @f;  -- ���� �� ��������� ���������
	         end;   
		close cc;
		return; 
	end;

select * from dbo.FACULTY_REPORT(10);

create function sumNum (@count varchar(20)) returns int
as
begin
declare @rc int = (select  count (*) from ����������
		where ����������_���������� = ISNULL(@count, ����������_����������));
		return @rc;
		end;
		select  dbo.sumNum (Null)
		select *, dbo.sumNum(����������_����������) from ����������

		create function FFA(@f varchar(50), @p varchar(50)) returns table 
      as return 
          select ����������_���������.�����������, �����������.��������_����������� 
          from ����������_��������� left outer join ����������� 
          on ����������_���������.����������� = �����������.��������_�����������
          where ����������_���������.����������� = isnull(@f,����������_���������.�����������) 
          and  �����������.��������_����������� = isnull(@p,  �����������.��������_�����������);
   select * from dbo.FFA(NULL,NULL);
   select * from dbo.FFA(NULL,'����������_��');
   select * from dbo.FFA ('�������_��',NULL)

    create function COUNT(@f varchar(25)) returns int
    as begin  declare @rc int = 0;
    set @rc = (select count(����������_���������.�����������) 
	        from ����������_���������  
			join  ����������� on ����������_���������.�����������=�����������.��������_�����������
            where �����������  = @f) ;  
	    return @rc         
	    end
	    declare @f int=dbo.COUNT('�����_��');
		select ����������_���������.�����������, 
        dbo.COUNT(����������_���������.�����������)from ����������_���������;	