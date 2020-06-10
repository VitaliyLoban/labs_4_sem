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
		if @flag = 'c'  commit;                   -- 
	          else      rollback;                               
      SET IMPLICIT_TRANSACTIONS  OFF   

	if  exists (select * from  SYS.OBJECTS      
	            where OBJECT_ID= object_id(N'DBO.X') )
	print '������� X ����';  else print '������� X ���'
--2
	begin try
	 begin tran                 
	   delete SUBJECT where SUBJECT='��'; 
	   --delete SUBJECT where SUBJECT='����';
	   insert SUBJECT values ('��','���� ������',  '����');
	   insert SUBJECT values ('����','������������ ��������� � �������',  '����'); 
	   commit tran;          
	end try
	begin catch
	    print '������: '+ case 
          when error_number() = 2627 and patindex('%SUBJECT_PK%', error_message()) > 0
          then '������������ ���������' 
          else '����������� ������: '+ cast(error_number() as  varchar(5))+ error_message()  
	  end; 
	 if @@trancount > 0 rollback tran ; 	  
     end catch;

--3
declare @point varchar(30);                               
begin try
  begin tran                                                             
	--delete SUBJECT where SUBJECT='��'; 
	set @point = '�� �1'; save tran @point;             
	insert SUBJECT values ('��1111','���� ������1111',  '����');
	set @point = '�� �2'; save tran @point;             
	--insert SUBJECT values ('��','���� ������',  '����');
	insert SUBJECT values ('����11','������������ ��������� � �������1111',  '����'); 
	commit tran;                                                     
   end try
   begin catch
	print '������: '+ case 
      when error_number() = 2627 and patindex('%SUBJECT_PK%', error_message()) > 0
      then '������������ ���������' 
      else '����������� ������: '+ cast(error_number() as  varchar(5)) + error_message()  
	end; 
   if @@trancount > 0 
	begin
	   print '����������� �����: '+ @point;
	   rollback tran @point;                                  
	   commit tran;                  
	end;     
   end catch;
--4
    --A
set transaction isolation level READ UNCOMMITTED 
	begin transaction 
	-------------------------- t1 ------------------
	  select @@SPID, 'insert Subject' '���������', * from Subject 
	                                                             where PULPIT='����';
	  select @@SPID, 'update Subject'  '���������', * from SUBJECT  
	                                                             where PULPIT='����';
	  commit; 
	-------------------------- t2 -----------------
	--B	
	begin transaction 
	select @@SPID
	insert SUBJECT values ('����3','������������ ��������� � �������1',  '����');
	update SUBJECT set SUBJECT_NAME = '����� �������' 
                           where SUBJECT='����3'
	-------------------------- t1 --------------------
	-------------------------- t2 --------------------
	rollback;
--5
    -- A ---

    set transaction isolation level READ COMMITTED 
	begin transaction 
	select count(*) from PULPIT
	where FACULTY = '��';
	-------------------------- t1 ------------------ 
	-------------------------- t2 -----------------
	select  'update PULPIT'  '���������', count(*)
	from PULPIT  where FACULTY = '��';
	commit; 
	--- B ---	
	begin transaction 	  
	-------------------------- t1 --------------------
          update PULPIT set FACULTY = '��' 
                                       where PULPIT = '����' 
          commit; 
	-------------------------- t2 --------------------	
--6 
--------A---------

set transaction isolation level REPEATABLE READ
begin transaction
select TEACHER FROM TEACHER
WHERE PULPIT = '������';

--------t1---------
--------t2---------

select case
    when TEACHER = '���8' THEN 'insert TEACHER'
	else ' '
	end '���������', TEACHER
FROM TEACHER WHERE PULPIT = '������';
commit;

--- B ---	
begin transaction 	  
--- t1 --------------------
insert TEACHER values ('���8', '������ ���� ��������', '�', '������');
commit; 
--- t2 --------------------

select * from TEACHER
--7
     use master;
	go

	alter database L_UNIVER set allow_snapshot_isolation on


	-- A ---
    set transaction isolation level SNAPSHOT 
	begin try
		begin transaction 
	
	select TEACHER from TEACHER where PULPIT = '������';

	-------------------------- t1 ------------------
	waitfor delay '00:00:05' 
          --insert TEACHER values ('���', '������ ������ ���������', '�', '������              ');
          --update TEACHER set TEACHER = '����' where TEACHER = '���';
	-------------------------- t2 -----------------
	 delete TEACHER where TEACHER = '����';  

	select TEACHER from TEACHER  where PULPIT = '������';
	commit; 
	end try
	begin catch
	print 'error: '+cast(error_number()as varchar(10));
	print 'message :'+error_message();
	rollback;
	end catch ;
	
	--- B ---	


	begin transaction 	  
	waitfor delay '00:00:05'
	-------------------------- t1 --------------------
          update TEACHER set TEACHER = '���' where TEACHER = '����';
          commit; 
--8
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
--9
select (select count(*) from dbo.PULPIT where FACULTY = '����') '������� �����', 
(select count(*) from FACULTY where FACULTY.FACULTY = '����') '����'; 

select * from PULPIT

begin tran
	begin tran
	update PULPIT set PULPIT_NAME='������� �����' where PULPIT.FACULTY = '����';
	commit;
if @@TRANCOUNT > 0 rollback;
