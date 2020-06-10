use L_UNIVER
exec  SP_HELPINDEX 'STUDENT'
exec sp_helpindex 'AUDITORIUM'
exec  sp_helpindex 'FACULTY'
exec  sp_helpindex 'GROUPS'
exec  sp_helpindex 'PROFESSION'

CREATE table  #EXPLRE
 (   TIND int,  TFIELD varchar(100) );
DECLARE @i int=0; 
WHILE @i<1000
  begin 
  INSERT #EXPLRE(TIND, TFIELD) 
               values(floor(20000*RAND()), REPLICATE('строка', 10));
  IF(@i % 100=0) print @i;     
  SET @i=@i+1;
  end;
  go

  drop table #EXPLRE

  SELECT * from #EXPLRE WHERE TIND between 1500 and 2500 ORDER BY TIND--0.0110 
   checkpoint;  
   DBCC DROPCLEANBUFFERS;  
   CREATE clustered index #EXPLRE_CL on #EXPLRE(TIND asc)
   SELECT * from #EXPLRE WHERE TIND between 1500 and 2500 ORDER BY TIND --0.0033
   drop index #EXPLERE_CL on #EXPLRE

   CREATE table #EX
  ( TKEY int, CC int identity(1,1),TF varchar(100));
  declare @i int = 0;
  while   @i < 20000 
  begin
  INSERT #EX(TKEY, TF) values(floor(30000*RAND()), replicate('строка ', 10));
  set @i = @i+1; 
  end;
  go
  
  SELECT * from #EX --0.177 --0.0031
  SELECT * from  #EX where  TKEY > 1500 and  CC < 4500;  --0.177 
  SELECT * from  #EX order by  TKEY, CC --0.199 --

  CREATE index #EX_NONCLU on #EX(TKEY, CC)
   drop index #EX_NONCLU on #EX

  SELECT * from  #EX where  TKEY = 556 and  CC > 3 --0.00328


  CREATE  index #EX_TKEY_X on #EX(TKEY) INCLUDE (CC)
    drop  index #EX_TKEY_X on #EX
  SELECT CC from #EX where TKEY>15000 --0.199--0.034
 

  CREATE  index #EX_WHERE on #EX(TKEY) where (TKEY>=15000 and 
 TKEY < 20000);  
  Drop  index #EX_WHERE on #EX

 SELECT * from #EX where TKEY=18000--0.019--0.0032

 CREATE   index #EX_TKEY on #EX(TKEY); 
 Drop   index #EX_TKEY on #EX
 SELECT name [Индекс], avg_fragmentation_in_percent [Фрагментация (%)]
  FROM sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'), 
  OBJECT_ID(N'#EX'), NULL, NULL, NULL) ss
  JOIN sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id  
                 where name is not null;
INSERT top(10000) #EX(TKEY, TF) select TKEY, TF from #EX;
ALTER index #EX_TKEY on #EX reorganize;
ALTER index #EX_TKEY on #EX rebuild with (online = off);

DROP index #EX_TKEY on #EX;
    CREATE index #EX_TKEY on #EX(TKEY)with (fillfactor = 65);
INSERT top(50)percent into #EX(TKEY, TF) select TKEY, TF  from #EX;
SELECT name [Индекс], avg_fragmentation_in_percent [Фрагментация (%)]
FROM sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'), OBJECT_ID(N'#EX'), NULL, NULL, NULL) ss
       JOIN sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id  
where name is not null;
Delete from  #EX
TRUNCATE table #EX

Create view[Количество кафедр]
as select FACULTY.FACULTY_NAME[Факультет],
          count(*) [Количество кафедр] from FACULTY join PULPIT on FACULTY.FACULTY=PULPIT.FACULTY
		  group by FACULTY.FACULTY_NAME
		  go
Select * from[Количество кафедр]



