use UNIVER
 ----1
    go 
    create function COUNT_STUDENTS(@faculty varchar(20)) returns int
    as begin  declare @rc int = 0;
    set @rc = (select count(STUDENT.IDSTUDENT) 
	        from GROUPS   
			join  FACULTY on GROUPS.FACULTY=FACULTY.FACULTY
			join  STUDENT on GROUPS.IDGROUP=STUDENT.IDGROUP 
                   where FACULTY.FACULTY = @faculty) ;  
	 return @rc;          
	 end
	    declare @faculty int=dbo.COUNT_STUDENTS('ТОВ');
   print 'Количество студентов= '+cast(@faculty as varchar(4));
			select FACULTY.FACULTY, 
       dbo.COUNT_STUDENTS1(FACULTY.FACULTY)[Количество студентов]from FACULTY;	
	   ---------------------------------
	  
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
-----2 
	   create FUNCTION FSUBJECTS(@p varchar(20)) returns char(300) 
     as
     begin  
     declare @tv char(20);  
     declare @t varchar(300) = 'Дисциплины: ';  
     declare ZkTovar CURSOR LOCAL 
     for select SUBJECT from SUBJECT where SUBJECT.PULPIT=@p;
  	open ZkTovar;	  
	fetch  ZkTovar into @tv;   	 
	while @@fetch_status = 0                                     
          begin 
             set @t = @t+ ', '+ rtrim(@tv);         
             FETCH  ZkTovar into @tv; 
          end;    return @t;
      end;  

   select SUBJECT,  dbo.FSUBJECTS 
                               (SUBJECT.PULPIT)  from SUBJECT ;
	--------3
	create function FFACPUL(@f varchar(50), @p varchar(50)) returns table 
      as return 
          select FACULTY.FACULTY, PULPIT.PULPIT  
          from FACULTY left outer join PULPIT 
          on FACULTY.FACULTY = PULPIT.FACULTY
          where FACULTY.FACULTY = isnull(@f,FACULTY.FACULTY) 
          and PULPIT.PULPIT = isnull(@p, PULPIT.PULPIT);
   select * from dbo.FFACPUL(NULL,NULL);
   select * from dbo.FFACPUL('ИДиП',NULL);
   select * from dbo.FFACPUL(NULL,'ЛМиЛЗ');
   select * from dbo.FFACPUL('ИДиП','ЛМиЛЗ');
-------4
create function FCTEACHER(@p varchar(50)) returns int 
as
 begin
    declare @rc int =(select count(*) from PULPIT
    where PULPIT = isnull(@p, PULPIT));
    return @rc;
 end;  
 go   
  
     select  PULPIT.PULPIT, dbo.FCTEACHER(PULPIT)
                                       [Количество преподавателей]    from PULPIT       
   
     select dbo.FCTEACHER(NULL) [Всего преподавателей]
---------5
create function COUNT_STUDENTS1(@faculty1 varchar(20)) returns int
    as begin  declare @rc int = 0;
    set @rc = (select count(STUDENT.IDSTUDENT) 
	        from GROUPS   
			join  FACULTY on GROUPS.FACULTY=FACULTY.FACULTY
			join  STUDENT on GROUPS.IDGROUP=STUDENT.IDGROUP 
                   where FACULTY.FACULTY = @faculty1) ;  
	 return @rc;          
	 end
	    declare @faculty2 int=dbo.COUNT_STUDENTS1('ТОВ');
   print 'Количество студентов= '+cast(@faculty2 as varchar(4));
			select FACULTY.FACULTY, 
       dbo.COUNT_STUDENTS1(FACULTY.FACULTY)from FACULTY;	
	   --------------------
	    go 
    alter function COUNT_STUDENTS5(@faculty5 varchar(20)) returns int
    as begin  declare @rc int = 0;
    set @rc = (select count(GROUPS.IDGROUP) 
	        from GROUPS   
                   where GROUPS.FACULTY = @faculty5) ;  
	 return @rc;          
	 end
			select FACULTY.FACULTY, 
       dbo.COUNT_STUDENTS5('ТОВ')[Количество групп]from FACULTY ;	
    ----------------------------------------------------------
	use B_univer
	alter function Func1(@name varchar(20)) returns int
	as begin declare @rc int=0;
	set @rc=(select count(Студент.Name)
	         from Студент where Студент.Name=@name);
			 return @rc;
    end
	select distinct dbo.Func1('B')[Количество студентов c именем B] from Студент
	-------------------
alter function Func(@f varchar(50)) returns table 
      as return 
          select сессия.Node, Студент.Name  
          from сессия left outer join Студент 
          on сессия.id_student = Студент.id_st
          where  Студент.Name = isnull(@f, Студент.Name);
   select * from dbo.Func('B');