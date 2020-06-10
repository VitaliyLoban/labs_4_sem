use L_UNIVER
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
PRINT 'Int='+STR(@Int);
PRINT 'Smallint='+STR(@Smallint);
PRINT 'Numeric='+STR(@Numeric);

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
PRINT 'код последней ошибки '+cast(@@ERROR as varchar(20));
PRINT 'имя сервера '+cast(@@SERVERNAME as varchar(20));
PRINT 'уровень вложенности транзакции '+cast(@@TRANCOUNT  as varchar(20));
PRINT 'версия SQL Server '+cast(@@VERSION as nvarchar(20));
PRINT 'системный идентификатор процесса '+cast(@@SPID as varchar(20));
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
