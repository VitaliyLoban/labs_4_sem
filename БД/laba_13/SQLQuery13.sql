set nocount on
	if  exists (select * from  SYS.OBJECTS        
	            where OBJECT_ID= object_id(N'DBO.X') )	            
	drop table X;           
	declare @c int, @flag char = 'c';           
	SET IMPLICIT_TRANSACTIONS  ON   
	    create table X(K int );                        
		insert X values (1),(2),(3);
		set @c = (select count(*) from X);
		print 'êîëè÷åñòâî ñòðîê â òàáëèöå X: ' + cast( @c as varchar(2));
		if @flag = 'c'  commit;                   -- 
	          else      rollback;                               
      SET IMPLICIT_TRANSACTIONS  OFF   

	if  exists (select * from  SYS.OBJECTS      
	            where OBJECT_ID= object_id(N'DBO.X') )
	print 'òàáëèöà X åñòü';  else print 'òàáëèöû X íåò'
--2
	begin try
	 begin tran                 
	   delete SUBJECT where SUBJECT='ÁÄ'; 
	   --delete SUBJECT where SUBJECT='ÊÃÈÃ';
	   insert SUBJECT values ('ÁÄ','Áàçû äàííûõ',  'ÈÑèò');
	   insert SUBJECT values ('ÊÃÈÃ','Êîìïüþòåðíàÿ Ãåîìåòðèÿ è ãðàôèêà',  'ÈÑèò'); 
	   commit tran;          
	end try
	begin catch
	    print 'îøèáêà: '+ case 
          when error_number() = 2627 and patindex('%SUBJECT_PK%', error_message()) > 0
          then 'äóáëèðîâàíèå ïðåäìåòîâ' 
          else 'íåèçâåñòíàÿ îøèáêà: '+ cast(error_number() as  varchar(5))+ error_message()  
	  end; 
	 if @@trancount > 0 rollback tran ; 	  
     end catch;

--3
declare @point varchar(30);                               
begin try
  begin tran                                                             
	--delete SUBJECT where SUBJECT='ÁÄ'; 
	set @point = 'êò ¹1'; save tran @point;             
	insert SUBJECT values ('ÁÄ1111','Áàçû äàííûõ1111',  'ÈÑèò');
	set @point = 'êò ¹2'; save tran @point;             
	--insert SUBJECT values ('ÁÄ','Áàçû äàííûõ',  'ÈÑèò');
	insert SUBJECT values ('ÊÃÈÃ11','Êîìïüþòåðíàÿ Ãåîìåòðèÿ è ãðàôèêà1111',  'ÈÑèò'); 
	commit tran;                                                     
   end try
   begin catch
	print 'îøèáêà: '+ case 
      when error_number() = 2627 and patindex('%SUBJECT_PK%', error_message()) > 0
      then 'äóáëèðîâàíèå ïðåäìåòîâ' 
      else 'íåèçâåñòíàÿ îøèáêà: '+ cast(error_number() as  varchar(5)) + error_message()  
	end; 
   if @@trancount > 0 
	begin
	   print 'êîíòðîëüíàÿ òî÷êà: '+ @point;
	   rollback tran @point;                                  
	   commit tran;                  
	end;     
   end catch;
--4
    --A
set transaction isolation level READ UNCOMMITTED 
	begin transaction 
	-------------------------- t1 ------------------
	  select @@SPID, 'insert Subject' 'ðåçóëüòàò', * from Subject 
	                                                             where PULPIT='ÈÑèò';
	  select @@SPID, 'update Subject'  'ðåçóëüòàò', * from SUBJECT  
	                                                             where PULPIT='ÈÑèò';
	  commit; 
	-------------------------- t2 -----------------
	--B	
	begin transaction 
	select @@SPID
	insert SUBJECT values ('ÊÃÈÃ3','Êîìïüþòåðíàÿ ãåîìåòðèÿ è ãðàôèêà1',  'ÈÑèò');
	update SUBJECT set SUBJECT_NAME = 'Íîâûé ïðåäìåò' 
                           where SUBJECT='ÊÃÈÃ3'
	-------------------------- t1 --------------------
	-------------------------- t2 --------------------
	rollback;
--5
    -- A ---

    set transaction isolation level READ COMMITTED 
	begin transaction 
	select count(*) from PULPIT
	where FACULTY = 'ÈÒ';
	-------------------------- t1 ------------------ 
	-------------------------- t2 -----------------
	select  'update PULPIT'  'ðåçóëüòàò', count(*)
	from PULPIT  where FACULTY = 'ÈÒ';
	commit; 
	--- B ---	
	begin transaction 	  
	-------------------------- t1 --------------------
          update PULPIT set FACULTY = 'ÈÒ' 
                                       where PULPIT = 'ÈÑèÒ' 
          commit; 
	-------------------------- t2 --------------------	
--6 
--------A---------

set transaction isolation level REPEATABLE READ
begin transaction
select TEACHER FROM TEACHER
WHERE PULPIT = 'ÏÎèÑÎÈ';

--------t1---------
--------t2---------

select case
    when TEACHER = 'ÈÈÈ8' THEN 'insert TEACHER'
	else ' '
	end 'ðåçóëüòàò', TEACHER
FROM TEACHER WHERE PULPIT = 'ÏÎèÑÎÈ';
commit;

--- B ---	
begin transaction 	  
--- t1 --------------------
insert TEACHER values ('ÈÈÈ8', 'Èâàíîâ Èâàí Èâàíîâè÷', 'ì', 'ÏÎèÑÎÈ');
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
	
	select TEACHER from TEACHER where PULPIT = 'ÏÎèÑÎÈ';

	-------------------------- t1 ------------------
	waitfor delay '00:00:05' 
          --insert TEACHER values ('ÈÂÍ', 'Èâàíîâ Ñåðãåé Áîðèñîâè÷', 'ì', 'ÏÎèÑÎÈ              ');
          --update TEACHER set TEACHER = 'ØÌÊÂ' where TEACHER = 'ØÌÊ';
	-------------------------- t2 -----------------
	 delete TEACHER where TEACHER = 'ÁÐÒØ';  

	select TEACHER from TEACHER  where PULPIT = 'ÏÎèÑÎÈ';
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
          update TEACHER set TEACHER = 'ÁÐÒ' where TEACHER = 'ÁÐÒØ';
          commit; 
--8
      -- A ---
          set transaction isolation level SERIALIZABLE 
	begin transaction 
		  delete TEACHER where TEACHER = 'ÀÐÑ';  
          insert TEACHER values ('ÈÂÍaô', 'Èâàíîâaô Ñåðãåé Áîðèñîâè÷', 'ì', 'ËÓ');
          update TEACHER set TEACHER = 'ØÌÊÂ' where TEACHER = 'ØÌÊ';
          select TEACHER from TEACHER  where PULPIT = 'ËÓ';
	-------------------------- t1 -----------------
	begin tran
	 select TEACHER from TEACHER  where PULPIT = 'ËÓ';
	-------------------------- t2 ------------------ 
	commit; 	
	--- B ---	
	begin transaction 	  
	delete TEACHER where TEACHER = 'ÀÐÑ';  
          insert TEACHER values ('ÈÂÍa', 'Èâàíîâa Ñåðãåé Áîðèñîâè÷', 'ì', 'ÏÎèÑÎÈ              ');
          update TEACHER set TEACHER = 'ØÌÊÂ' where TEACHER = 'ØÌÊ';
          select TEACHER from TEACHER  where PULPIT = 'ËÓ';
          -------------------------- t1 --------------------
          commit; 
           select TEACHER from TEACHER  where PULPIT = 'ËÓ';
      -------------------------- t2 --------------------
--9
select (select count(*) from dbo.PULPIT where FACULTY = 'ÈÄèÏ') 'Êàôåäðû ÈÄÈÏà', 
(select count(*) from FACULTY where FACULTY.FACULTY = 'ÈÄèÏ') 'ÈÄÈÏ'; 

select * from PULPIT

begin tran
	begin tran
	update PULPIT set PULPIT_NAME='Êàôåäðà ÈÄèÏà' where PULPIT.FACULTY = 'ÈÄèÏ';
	commit;
if @@TRANCOUNT > 0 rollback;
