Declare @tv char(20), @t char(300)='';
Declare ResultS Cursor for select SUBJECT from SUBJECT where PULPIT like('%����%');
OPEN ResultS;
FETCH ResultS into @tv;
print   '����������';
while @@fetch_status = 0                                     
          begin 
             set @t = rtrim(@tv)+', '+@t;         
             FETCH  ResultS into @tv; 
          end;   
      print @t;        
  CLOSE  ResultS;

DECLARE ST CURSOR LOCAL                            
	for select �������.Name from �������;
DECLARE @tv1 char(50);      
	OPEN ST;	  
	fetch  ST into @tv1; 	
      print '1. '+@tv1;   
      go
DECLARE @tv1 char(50);     	
	fetch  ST into @tv1;	
      print '2. '+@tv1;  
  go   


DECLARE ST CURSOR GLOBAL                                                        
	for select �������.Name from �������;
DECLARE @tv1 char(50);      
	OPEN ST;	  
	fetch  ST into @tv1; 	
      print '1. '+@tv1;   
      go
DECLARE @tv1 char(50);     	
	fetch  ST into @tv1;	
      print '2. '+@tv1;  
  close ST;
  deallocate ST;


declare @tid char(10), @tnm char(40), @tgn char(1);  
	declare R CURSOR LOCAL STATIC                              
		 for select �������.id_st, �������.Name, �������.SurName 
		 from �������				   
	open R;
	print   '���������� ����� : '+cast(@@CURSOR_ROWS as varchar(5)); 
	update ������� set Name='B' where id_st=3;
	delete ������� where id_st=1;
	-----------------------------------------------------------------
	fetch  R into @tid, @tnm, @tgn;     
	while @@fetch_status = 0                                    
    begin 
       print @tid + ' '+ @tnm + ' '+ @tgn;      
       fetch R into @tid, @tnm, @tgn; 
    end;          
    close  R;

declare @tid1 char(10), @tnm1 char(40), @tgn1 char(1);  
	declare R CURSOR LOCAL dynamic                             
		 for select �������.id_st, �������.Name, �������.SurName 
		 from �������				   
	open R;
	print   '���������� ����� : '+cast(@@CURSOR_ROWS as varchar(5)); 
	update ������� set Name='B' where id_st=3;
	delete ������� where id_st=1;
	-----------------------------------------------------------------
	fetch  R into @tid1, @tnm1, @tgn1;     
	while @@fetch_status = 0                                    
    begin 
       print @tid1 + ' '+ @tnm1 + ' '+ @tgn1;      
       fetch R into @tid1, @tnm1, @tgn1; 
    end;          
    close  R;

Declare @tv char(20), @t char(300)='';
Declare ResultS Cursor for select SUBJECT from SUBJECT where PULPIT like('%����%');
OPEN ResultS;
FETCH ResultS into @tv;
print   '����������';
while @@fetch_status = 0                                     
          begin 
             set @t = rtrim(@tv)+', '+@t;         
             FETCH first from ResultS into @tv; 
          end;   
      print @t;        
  CLOSE  ResultS;

  Declare @tv char(20), @t char(300)='';
Declare ResultS Cursor for select SUBJECT from SUBJECT where PULPIT like('%����%');
OPEN ResultS;
FETCH ResultS into @tv;
print   '����������';
while @@fetch_status = 0                                     
          begin 
             set @t = rtrim(@tv)+', '+@t;         
             FETCH last from ResultS into @tv; 
          end;   
      print @t;        
  CLOSE  ResultS;

DELETE FROM PROGRESS
    WHERE NOTE <5;
    
    GO

UPDATE PROGRESS
SET NOTE+=1
WHERE IDSTUDENT = 1000


declare  @tk int;   
    declare kr cursor local dynamic  
	for select NOTE
		 from PROGRESS where IDSTUDENT = 1000; 
     open kr;  
     fetch  kr into @tk; 
     update PROGRESS set NOTE = NOTE+1 where CURRENT OF kr;
     close kr;
	 ------------------------------
	 use L_My_Base
 declare  @tco int, @rno char(50);  
 declare Primer10 cursor local dynamic SCROLL                               
               for select row_number() over (order by �����_������) N,
	     �����_������ from dbo.������ where ID_��������� = 12324 
	open Primer10;  
	fetch  Absolute 2 from  Primer10 into @tco, @rno;       
	print '2-� ������ � ������                : ' +  cast(@tco as varchar(3))+' ����� ������ '+@rno;  
	fetch Absolute -2 from  Primer10 into @tco, @rno;    
	print '2-� ������ � �����                 : ' +  cast(@tco as varchar(3))+' ����� ������ '+@rno;   
	fetch Relative -3 from  Primer10 into @tco, @rno;    
	print '3-� ������ ����� �� �������        : ' +  cast(@tco as varchar(3))+' ����� ������ '+@rno;  
	fetch Relative 2 from  Primer10 into @tco, @rno;    
	print '2-� ������ ������ �� �������       : ' +  cast(@tco as varchar(3))+' ����� ������ '+@rno;  
		fetch prior  from  Primer10 into @tco, @rno;    
	print '���������� ������ �� �������       : ' +  cast(@tco as varchar(3))+' ����� ������ '+@rno;  
		fetch next  from  Primer10 into @tco, @rno;    
	print '��������� ������ �� �������        : ' +  cast(@tco as varchar(3))+' ����� ������ '+@rno;  

      close Primer10;
