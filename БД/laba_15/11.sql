use TMP_Bond_UNIVER
declare @pulp varchar(25),@t char(300)=' ';
--declare subje cursor for 
--select SUBJECT.SUBJECT from SUBJECT where PULPIT='����'
open subje
fetch subje into @pulp
print '���������� '
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
 where TEACHER.GENDER='�'
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
  select TEACHER,TEACHER.TEACHER_NAME, TEACHER.GENDER from TEACHER where TEACHER.PULPIT='������'
open stat_curs
print '���������� �����:'+ cast(@@CURSOR_ROWS as varchar(5))
update TEACHER set TEACHER_NAME='qwerty' where TEACHER='���'
delete TEACHER  where TEACHER='���'
insert TEACHER (TEACHER,PULPIT) values ('AAA','������')

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
from TEACHER where PULPIT='����'
open teach
fetch teach into @rn,@tc
print '���������        '+cast (@rn as varchar(3))+'['+RTrim (@tc)+']'
fetch last from teach into @rn,@tc
print '���������        '+cast (@rn as varchar(3))+'['+RTrim (@tc)+']'
fetch first from teach into @rn,@tc
print ' ������          '+cast (@rn as varchar(3))+'['+RTrim (@tc)+']'
fetch absolute 7 from teach into @rn,@tc
print '7  � ������      '+cast (@rn as varchar(3))+'['+RTrim (@tc)+']'
fetch absolute -6 from teach into @rn,@tc
print '6  � �����       '+cast (@rn as varchar(3))+'['+RTrim (@tc)+']'
fetch relative 5 from teach into @rn,@tc
print '5 � ������� ���  '+cast (@rn as varchar(3))+'['+RTrim (@tc)+']'
fetch relative -5 from teach into @rn,@tc
print '5 ����� � ���    '+cast (@rn as varchar(3))+'['+RTrim (@tc)+']'
fetch next from teach into @rn,@tc
print '����   ��� ���   '+cast (@rn as varchar(3))+'['+RTrim (@tc)+']'
fetch prior from teach into @rn,@tc
print '�������� � ����� '+cast (@rn as varchar(3))+'['+RTrim (@tc)+']'
close teach
--5
--3
go
 declare @rt varchar(20),@ry varchar(20), @ri varchar(20)
 declare new_curs cursor local dynamic for
  select TEACHER,TEACHER.TEACHER_NAME, TEACHER.GENDER from TEACHER where TEACHER.PULPIT='������' for update
open new_curs
fetch new_curs into @rt,@ry,@ri
delete TEACHER where current of new_curs
fetch new_curs into @rt,@ry,@ri
update TEACHER set TEACHER_NAME='xx������' where current of new_curs
select * from TEACHER where TEACHER.PULPIT='������'
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
for select Driver.���, Driver.����
from Driver for update
open st
fetch relative 2 from st into @idg,@stag
print 'before  '+ cast (@idg as varchar(50))+ '['+RTrim (@stag)+']'
update Driver set ����=����+2  where current of st
fetch relative 0 from st into @idg,@stag
print 'after  '+ cast (@idg as varchar(50))+ '['+RTrim (@stag)+']'
close st
use TMP_Bond_UNIVER
--13
set nocount on
	if  exists (select * from  SYS.OBJECTS        -- ������� X ����?
	            where OBJECT_ID= object_id(N'DBO.X') )	            
	drop table X;           
	declare @c int, @flag char = 'c';           -- commit ��� rollback?
	SET IMPLICIT_TRANSACTIONS  ON   -- �����. ����� ������� ����������
	    create table X(K int );                         -- ������ ���������� 
		insert X values (1),(2),(3);
		set @c = (select count(*) from X);
		print '���������� ����� � ������� X: ' + cast( @c as varchar(2));
		if @flag = 'c'  commit;                   -- ���������� ����������: �������� 
	          else      rollback;                              -- ���������� ����������: �����  
      SET IMPLICIT_TRANSACTIONS  OFF   -- ������. ����� ������� ����������
	-- ��������� ����� ������������
	if  exists (select * from  SYS.OBJECTS       -- ������� X ����?
	            where OBJECT_ID= object_id(N'DBO.X') )
	print '������� X ����';  else print '������� X ���'

begin try
	begin tran                 -- ������  ����� ����������
		insert FACULTY values ('��', '��������� ������ ����');
	    --insert FACULTY values ('���', '��������� print-���������� � �����������������');
	commit tran;               -- �������� ����������
end try
begin catch
	print '������: '+ case 
		when error_number() = 2627 and patindex('%FACULTY_PK%', error_message()) > 0 then '������������ ������'
		else '����������� ������: '+ cast(error_number() as  varchar(5))+ error_message()  
	end; 
	if @@trancount > 0 rollback tran; -- ���� �������� ������ ����, �� ���������� �� ��������� 	  
end catch;

select * from FACULTY;
declare @point varchar(32);
begin try
	begin tran                              

		set @point = 'p1'; 
		save tran @point;  -- ����������� ����� p1

		insert STUDENT(IDGROUP, NAME, BDAY, INFO, FOTO) values (20,'���������', '1997-08-02', NULL, NULL),
							  (20,'����������', '1997-08-06', NULL, NULL),
							  (20,'���������', '1997-08-01', NULL, NULL),
							  (20,'�����', '1997-08-03', NULL, NULL);    

		set @point = 'p2'; 
		save tran @point; -- ����������� ����� p2 (������������, ������� ��-�������)

		insert STUDENT(IDGROUP, NAME, BDAY, INFO, FOTO) values (20, '��������� �������', '1997-08-02', NULL, NULL); 
	commit tran;                                              
end try
begin catch
	print '������: '+ case 
		when error_number() = 2627 and patindex('%STUDENT_PK%', error_message()) > 0 then '������������ ��������' 
		else '����������� ������: '+ cast(error_number() as  varchar(5)) + error_message()  
	end; 
    if @@trancount > 0 -- ���� ���������� �� ���������
	begin
	   print '����������� �����: '+ @point;
	   rollback tran @point; -- ����� � ��������� ����������� �����
	   commit tran; -- �������� ���������, ����������� �� ����������� ����� 
	end;     
end catch;

select * from STUDENT where IDGROUP=20; 
delete STUDENT where IDGROUP=20; 



--4. ����������� ��� �����-���: A � B �� ������� ���� ������ X_BSTU. 
--�������� A ������������ ����� ����� ���������� � ������� ��������������� READ UNCOMMITED, 
--�������� B � ����� ���������� � ������� ��������������� READ COMMITED (�� ���������). 
--�������� A ������ ���������������, ��� ������� READ UNCOMMITED ��������� ����������������, 
--��������������� � ��������� ������. 


------A----------

set transaction isolation level READ UNCOMMITTED
begin transaction


-----t1----------

select @@SPID, 'insert FACULTY' '���������', *
from FACULTY WHERE FACULTY = '��';
select @@SPID, 'update PULPIT' '���������', *
from PULPIT WHERE FACULTY = '��';
commit;

-----t2----------

-----B-----------

begin transaction
select @@SPID
insert FACULTY VALUES ('��2','�������������� ����������');
update PULPIT set FACULTY = '��' WHERE PULPIT = '����'

-----t1----------
-----t2----------

ROLLBACK;




--5. ����������� ��� �����-���: A � B �� ������� ���� ������ X_BSTU. 
--�������� A ������������ ����� ����� ���������� � ������� ��������������� READ COMMITED. 
--�������� B � ����� ���������� � ������� ��������������� READ COMMITED. 
--�������� A ������ ���������������, ��� ������� READ COMMITED �� ��������� ����������������� ������, 
--�� ��� ���� ��������  ��������������� � ��������� ������. 

-----A--------

set transaction isolation level READ COMMITTED
begin transaction
select count(*) from PULPIT
where FACULTY = '��';

-----t1-------
-----t2-------

select 'update PULPIT' '���������', count(*)
from PULPIT where FACULTY = '��';
commit;

------B----

begin transaction

------t1-----

update PULPIT set FACULTY = '��' where PULPIT = '����';
commit;

------t2------

--6. ����������� ��� �����-���: A � B �� ������� ���� ������ X_BSTU. 
--�������� A ������������ ����� ����� ���������� � ������� ��������������� REPEATABLE READ. 
--���-����� B � ����� ���������� � ������� ��������������� READ COMMITED. 

--------A---------

set transaction isolation level REPEATABLE READ
begin transaction
select TEACHER FROM TEACHER
WHERE PULPIT = '������';

--------t1---------
--------t2---------

select case
    when TEACHER = '���' THEN 'insert TEACHER'
	else ' '
	end '���������', TEACHER
FROM TEACHER WHERE PULPIT = '������';
commit;

--- B ---	
begin transaction 	  
--- t1 --------------------
insert TEACHER values ('���', '������ ���� ��������', '�', '����                ');
commit; 
--- t2 --------------------

select * from TEACHER

--7. ����������� ��� �����-���: A � B �� ������� ���� ������ X_BSTU. 
--�������� ������������ ����� ����� ���������� � ������� ��������������� SNAPSHOT. 
--�������� B � ����� ���������� � ������� ��������������� READ COM-MITED. 

   use master;
	go
	alter database TMP_Bond_UNIVER set allow_snapshot_isolation on


	-- A ---
    set transaction isolation level SNAPSHOT 
	begin transaction 
	waitfor delay '00:00:05'
	select TEACHER from TEACHER where PULPIT = '������';

	-------------------------- t1 ------------------ 
          delete TEACHER where TEACHER = '���';  
          insert TEACHER values ('���', '������ ������ ���������', '�', '������              ');
          update TEACHER set TEACHER = '����' where TEACHER = '���';
	-------------------------- t2 -----------------
	select TEACHER from TEACHER  where PULPIT = '������';
	commit; 
	
	
	--- B ---	


	begin transaction 	  
	waitfor delay '00:00:05'
	-------------------------- t1 --------------------
delete TEACHER where TEACHER = '�����';  
          insert TEACHER values ('���', '������ ���� ��������', '�', '������');
          update TEACHER set TEACHER = '���' where TEACHER = '������';
          commit; 
	-------------------------- t2 --------------------


--8. ����������� ��� �����-���: A � B �� ������� ���� ������ X_BSTU. 
--�������� ������������ ����� ����� ���������� � ������� ��������������� SE-RIALIZABLE. 
--�������� B � ����� ���������� � ������� ��������������� READ COM-MITED. 
--�������� A ������ ��������������� ���������� ����������, ����������������� � ��-�������������� ������.

use TMP_Bond_UNIVER;
      -- A ---
          set transaction isolation level SERIALIZABLE 
	begin transaction 
		  delete TEACHER where TEACHER = '���';  
          insert TEACHER values ('���a�', '������a� ������ ���������', '�', '��');
          update TEACHER set TEACHER = '����' where TEACHER = '���';
          select TEACHER from TEACHER  where PULPIT = '��';
	-------------------------- t1 -----------------
	begin tran
	 select TEACHER from TEACHER  where PULPIT = '��';
	-------------------------- t2 ------------------ 
	commit; 	
	--- B ---	
	begin transaction 	  
	delete TEACHER where TEACHER = '���';  
          insert TEACHER values ('���a', '������a ������ ���������', '�', '������              ');
          update TEACHER set TEACHER = '����' where TEACHER = '���';
          select TEACHER from TEACHER  where PULPIT = '��';
          -------------------------- t1 --------------------
          commit; 
           select TEACHER from TEACHER  where PULPIT = '��';
      -------------------------- t2 --------------------







--9-- ��������� ����������
-- ����������, ������������� � ������ ������ ����������, ���������� ���������. 
-- �������� COMMIT ��������� ���������� ��������� ������ �� ���������� �������� ��������� ����������; 
-- �������� ROLLBACK ������� ���������� �������� ��������������� �������� ���������� ����������; 
-- �������� ROLLBACK ��������� ���������� ��������� �� ���-����� ������� � ���������� ����������, 
-- � ����� ��������� ��� ����������; 
-- ������� ����������� ���������� ����� ���������� � ������� ��������� ������� @@TRANCOUT. 

select (select count(*) from dbo.PULPIT where FACULTY = '����') '������� �����', 
(select count(*) from FACULTY where FACULTY.FACULTY = '����') '����'; 

select * from PULPIT

begin tran
	begin tran
	update PULPIT set PULPIT_NAME='������� �����' where PULPIT.FACULTY = '����';
	commit;
if @@TRANCOUNT > 0 rollback;

-- ����� ���������� ���������� ����������� ��������� ����� ��������; 
-- �������� ROLLBACK ������� ���������� �������� ��������������� �������� ���������� ����������. 