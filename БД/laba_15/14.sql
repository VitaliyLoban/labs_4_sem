use L_UNIVER
go
create  procedure Pfubject
as begin
declare @k int= (select COUNT(*) from SUBJECT  )
select * from SUBJECT
return @k
end
go
declare @k int=0
exec @k=Pfubject
print 'кол во предметов= ' + cast (@k as varchar(3))
go

alter procedure Pfubject
	@f varchar(20),
	@c int output
	as begin
	declare @rc int=(select count (*)from PULPIT)
	print'параметры :@f= '+@f+',@c ='+cast(@c as varchar(3))
	select @c = @@rowcount
	return @rc;
	end;
--2
declare @k int=0, @r int =0
exec @k=Pfubject @f='БД', @c=@r output
print 'код возврата: '+ cast(@k as varchar(2))
print 'выходной параметр : '+ cast(@r as varchar(2))
go
--3
alter procedure Pfubject
@p varchar (20)
as begin
declare @k int=(select count (*) from PULPIT)
select * from PULPIT where PULPIT=@p;
end;
create table #subb1
(
k1 nvarchar(50),
k2 nvarchar(50),
k3 nvarchar(50)
)
create table #subbbbb
(
column1 char(20), column2 varchar(50), column3 int,column4 char(10)
)
insert #subb1 exec Pfubject @p='ИСиТ'
select * from #subb1
--4
go
create procedure Inserts1
@a char(20),@n varchar(50),@c int=null, @t char(10)
as declare @rc int=1
begin try
insert into #subbbbb(column1,column2,column3,column4)
values(@a,@n,@c,@t)
return @rc
end try
begin catch
print 'номер ошибки  : ' + cast(error_number() as varchar(6));
  print 'сообщение     : ' + error_message();
  print 'уровень       : ' + cast(error_severity()  as varchar(6));
  print 'метка         : ' + cast(error_state()     as varchar(8));
  print 'номер строки  : ' + cast(error_line()      as varchar(8));
  if error_procedure() is not  null   
  print 'имя процедуры : ' + error_procedure();
   return -1;
   end  catch; 

go
declare @rc int
exec @rc=Inserts1 @a=123,@n='12',@c=12,@t=12
print 'код ошибки : ' + cast(@rc as varchar(3));
 select * from #subbbbb
 --5
 go
 CREATE procedure SUBJECT_REPORT @p char(10) 
as begin
DECLARE @rc int;
begin try
DECLARE @sb char(10), @r varchar(100) = '';
DECLARE sbj CURSOR for 
	SELECT SUBJECT from SUBJECT where PULPIT = @p;
if not exists(SELECT SUBJECT from SUBJECT where PULPIT = @p)
	raiserror('Ошибка', 11, 1);
else 
OPEN sbj;
fetch sbj into @sb;
print 'Предметы: ';
while @@fetch_status = 0
begin
set @r = rtrim(@sb) + ', ' + @r;  
set @rc = @rc + 1;
fetch sbj into @sb;
end
print @r;
CLOSE sbj;
return @rc;
end try
begin catch
print 'Ошибка в параметрах' 
if error_procedure() is not null   
print 'Имя процедуры: ' + error_procedure();
return @rc;
end catch;
end;

--select * from PULPIT
DECLARE @k2 int;  
EXEC @k2 = SUBJECT_REPORT @p ='ИСиТ';  
print 'Количество предметов: ' + cast(@k2 as varchar(3));
go

--6
CREATE procedure PAUDITORIUM_INSERTX @a char(20), @n varchar(50), @c int = 0, @t char(10), @tn varchar(50)
as begin
DECLARE @rc int = 1;
begin try
set transaction isolation level serializable;          
begin tran
INSERT into AUDITORIUM_TYPE(AUDITORIUM_TYPE, AUDITORIUM_TYPENAME)
	values(@n, @tn);
EXEC @rc = Inserts @a, @n, @c, @t;
commit tran;
return @rc;
end try
begin catch
print 'Номер ошибки: ' + cast(error_number() as varchar(6));
print 'Сообщение: ' + error_message();
print 'Уровень: ' + cast(error_severity() as varchar(6));
print 'Метка: ' + cast(error_state() as varchar(8));
print 'Номер строки: ' + cast(error_line() as varchar(8));
if error_procedure() is not  null   
print 'Имя процедуры: ' + error_procedure(); 
if @@trancount > 0 rollback tran ; 
return -1;
end catch;
end;
DECLARE @k3 int;  
EXEC @k3 = PAUDITORIUM_INSERTX '622-3', @n = 'КК', @c = 85, @t = '622-3', @tn = 'Комп. класс'; 
print 'Код ошибки: ' + cast(@k3 as varchar(3));








--15
--1
go
create function Count_stud(@facult varchar(20)) returns int
as begin
declare @rc int =0
set @rc=(select COUNT(IDSTUDENT) from FACULTY join GROUPS on FACULTY.FACULTY=GROUPS.FACULTY
join STUDENT on STUDENT.IDGROUP=GROUPS.IDGROUP
where FACULTY.FACULTY=@facult)
return @rc
end
go
declare @c int= dbo.Count_stud('ИДиП')
print ' количество студентов на факультете идип '+ cast (@c as varchar(4)) 
go
ALTER function [dbo].[Count_stud](@facult varchar(20)=null, @profession varchar(20)=null) returns int
as begin
return (
select COUNT(IDSTUDENT) from FACULTY join PROFESSION on FACULTY.FACULTY=PROFESSION.FACULTY
join GROUPS on PROFESSION.PROFESSION=GROUPS.PROFESSION
join STUDENT on GROUPS.IDGROUP=STUDENT.IDGROUP
where FACULTY.FACULTY= isnull (@facult, FACULTY.FACULTY) and
PROFESSION.PROFESSION= isnull(@profession,PROFESSION.PROFESSION ))
end
go
select FACULTY.FACULTY 'факультеты', PROFESSION.PROFESSION 'специальности', dbo.Count_stud(FACULTY.FACULTY,PROFESSION.PROFESSION) 'количество студентов'
from FACULTY join PROFESSION on FACULTY.FACULTY=PROFESSION.FACULTY
group by FACULTY.FACULTY,PROFESSION.PROFESSION
order by   'количество студентов' desc
--2
go
create function FSUBJECTS(@p varchar(20)) returns varchar(300)
as begin
declare @sb varchar(10), @s varchar(100) = '';
declare sbj cursor local static for select distinct SUBJECT from SUBJECT where PULPIT LIKE @p;
open sbj;
fetch sbj into @sb;
while @@fetch_status = 0
begin
set @s =@s+ rtrim(@sb)+', ';
fetch sbj into @sb;
end;
return @s;
end;
go
select distinct PULPIT, dbo.FSUBJECTS(PULPIT)[Дисциплины] from SUBJECT;
--3
go
go
create function dbo.FFACPUL(@fac varchar(20)=null,@pulp varchar(20)=null) returns table
as return select FACULTY.FACULTY [факультет], PULPIT.PULPIT [специальность]
from FACULTY left join PULPIT on FACULTY.FACULTY=PULPIT.FACULTY
where FACULTY.FACULTY= ISNULL(@fac,FACULTY.FACULTY) and PULPIT.PULPIT=ISNULL(@pulp,PULPIT.PULPIT)
go
select * from dbo.FFACPUL(null,null)
select * from dbo.FFACPUL('ИДиП',null)
select * from dbo.FFACPUL(null,'ЛМиЛЗ')

--4
go
create function FKoll(@p varchar(50)) returns int
as
begin
declare @rc int = (select COUNT(TEACHER) from TEACHER where PULPIT=ISNULL(@p,PULPIT) )
return @rc
end
go
select  dbo.FKoll(null) [всего преподавателей] 
go
create function FCTEACHER(@p varchar(20)) returns int
as begin
declare @rc int = (select count(TEACHER) from TEACHER where PULPIT = isnull(@p, PULPIT));
return @rc;
end;
go
select  dbo.FCTEACHER(null) [всего преподавателей] 
select PULPIT, dbo.FCTEACHER(PULPIT)[Количество преподавателей] from TEACHER;
-----6
create function FACULTY_REPORTT(@c int) 
returns @fr table([Факультет] varchar(50), [Количество кафедр] int, [Количество групп]  int, [Количество студентов] int, [Количество специальностей] int)
as begin
declare cc cursor static for select FACULTY from FACULTY where dbo.COUNT_STUDENTS(FACULTY,'1-40 01 02')> @c; 
declare @f varchar(30);
open cc;  
fetch cc into @f;
while @@fetch_status = 0
begin
insert @fr values(@f, dbo.COUNT_PULPIT(@f), dbo.COUNT_GROUP(@f), dbo.COUNT_STUDENTS(@f,'1-40 01 02'), dbo.COUNT_PROFESSION(@f)); 
fetch cc into @f;  
end;   
return; 
end;

go
select * from dbo.FACULTY_REPORTT(0);
--7
go
go
create function COUNT_PROFESSION(@f varchar(20)) returns int
as begin
declare @rc int = 0;
set @rc = (select count(PROFESSION) from PROFESSION where FACULTY like @f);
return @rc;
end;
go
create function COUNT_GROUP(@f varchar(20)) returns int
as begin
declare @rc int = 0;
set @rc = (select count(IDGROUP) from GROUPS where FACULTY like @f);
return @rc;
end;
go
create function COUNT_PULPIT(@f varchar(20)) returns int
as begin
declare @rc int = 0;
set @rc = (select count(PULPIT) from PULPIT where FACULTY = @f);
return @rc;
end;


go
go
go
create function COUNT_STUDENTS(@faculty varchar(20) = null, @prof varchar(20) = '1-40 01 02') returns int
as begin
declare @rc int = 0;
set @rc = (
SELECT count(IDSTUDENT) from FACULTY inner join GROUPS
	on FACULTY.FACULTY = GROUPS.FACULTY
	inner join STUDENT
		on GROUPS.IDGROUP = STUDENT.IDGROUP
			where FACULTY.FACULTY = @faculty and GROUPS.PROFESSION = @prof);
return @rc;
end;
go
