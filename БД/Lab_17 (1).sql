use L_UNIVER;

go
select PULPIT.FACULTY[факультет/@код], 
TEACHER.PULPIT[факультет/кафедра/@код], 
TEACHER.TEACHER_NAME[факультет/кафедра/преподаватель/@код]
 from TEACHER inner join PULPIT
on TEACHER.PULPIT = PULPIT.PULPIT
where TEACHER.PULPIT = 'ИСиТ' for xml path, root('Список_преподавателей_кафедры_ИСиТ'),elements;


--задание №2 Разработать сценарий создания XML-документа в режиме AUTO
--auto возвращает результирующий набор запроса в виде простого вложенного дерева XML
--позволяет построить XML-фрагмент с применением вложенных элементов.
go
select AUDITORIUM.AUDITORIUM [Аудитория],
           AUDITORIUM.AUDITORIUM_TYPE [Наимменование_типа],
		   AUDITORIUM.AUDITORIUM_CAPACITY [Вместимость] 
		   from AUDITORIUM join AUDITORIUM_TYPE
		     on AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE
	where AUDITORIUM.AUDITORIUM_TYPE = 'ЛК' for xml AUTO, root('Список_аудиторий'), elements;


--3) 0 каждый атрибут преобразовывается в столбец) 1 -//-,но для необработанных столбцов примен сопоставление на основе эелементов XML
--2), каждый элемент преобразовывается в столбец таблицы). 
go
declare @h int = 0,--дескриптор
@sbj varchar(3000) = '<?xml version="1.0" encoding="windows-1251" ?>
                      <дисциплины>
					     <дисциплина код="КГиГ" название="Компьютерная геометрия и графика" кафедра="ИСиТ" />
						 <дисциплина код="ОЗИ" название="Основы защиты информации" кафедра="ИСиТ" />
						 <дисциплина код="МПп" название="Математическое программирование п" кафедра="ИСиТ" />
					  </дисциплины>';
exec sp_xml_preparedocument @h output, @sbj;
insert SUBJECT select[код], [название], [кафедра] from openxml(@h, '/дисциплины/дисциплина',0)
    with([код] char(10), [название] varchar(100), [кафедра] char(20));-- структура результирующего набора
select * from SUBJECT
--4)
--в таблицу помещается информация
insert into STUDENT(IDGROUP, NAME, BDAY, INFO) values(22, 'Лобан В.С.', '01.05.1999',
                                                          '<студент>
														     <паспорт серия="МС" номер="1234567" дата="01.01.2011" />
															 <телефон>+375255552222</телефон>
															 <адрес>
															    <страна>Беларусь</страна>
																<город>Минск</город>
																<улица>Бобруйская</улица>
																<дом>19</дом>
																<квартира>309</квартира>
															 </адрес>
														  </студент>');
select * from STUDENT where NAME = 'Лобан В.С.';
--обноыление инфы
update STUDENT set INFO = '<студент>
					           <паспорт серия="МС" номер="1234567" дата="01.02.2011" />
						       <телефон>+375251234567</телефон>
							   <адрес>
								  <страна>Беларусь</страна>
								  <город>Минск</город>
								  <улица>Бобруйская</улица>
	         					  <дом>19</дом>
								  <квартира>309</квартира>
								</адрес>
							 </студент>'
where NAME = 'Лобан В.С.';
--содержимое таблицы показывает селект
select NAME[ФИО], INFO.value('(студент/паспорт/@серия)[1]', 'char(2)')[Серия паспорта],
	INFO.value('(студент/паспорт/@номер)[1]', 'varchar(20)')[Номер паспорта],
	INFO.query('/студент/адрес')[Адрес]
		from  STUDENT
			where NAME = 'Лобан В.С.';       

--5
--go
--create xml schema collection Student as 
--N'<?xml version="1.0" encoding="utf-16" ?>
--<xs:schema attributeFormDefault="unqualified" 
--   elementFormDefault="qualified"
--   xmlns:xs="http://www.w3.org/2001/XMLSchema">
--<xs:element name="студент">
--<xs:complexType><xs:sequence>
--<xs:element name="паспорт" maxOccurs="1" minOccurs="1">
--  <xs:complexType>
--    <xs:attribute name="серия" type="xs:string" use="required" />
--    <xs:attribute name="номер" type="xs:unsignedInt" use="required"/>
--    <xs:attribute name="дата"  use="required">
--	<xs:simpleType>  <xs:restriction base ="xs:string">
--		<xs:pattern value="[0-9]{2}.[0-9]{2}.[0-9]{4}"/>
--	 </xs:restriction> 	</xs:simpleType>
--     </xs:attribute>
--  </xs:complexType>
--</xs:element>
--<xs:element maxOccurs="3" name="телефон" type="xs:unsignedInt"/>
--<xs:element name="адрес">   <xs:complexType><xs:sequence>
--   <xs:element name="страна" type="xs:string" />
--   <xs:element name="город" type="xs:string" />
--   <xs:element name="улица" type="xs:string" />
--   <xs:element name="дом" type="xs:string" />
--   <xs:element name="квартира" type="xs:string" />
--</xs:sequence></xs:complexType>  </xs:element>
--</xs:sequence></xs:complexType>
--</xs:element></xs:schema>';

--alter table STUDENT alter column INFO xml(Student);

--drop XML SCHEMA COLLECTION Student;

--select Name, INFO from STUDENT where NAME='Лобан В.С.'
	 

	 create xml schema collection Student1 as 
N'<?xml version="1.0" encoding="utf-16" ?>
<xs:schema attributeFormDefault="unqualified" 
   elementFormDefault="qualified"
   xmlns:xs="http://www.w3.org/2001/XMLSchema">
<xs:element name="студент">
<xs:complexType><xs:sequence>
<xs:element name="паспорт" maxOccurs="1" minOccurs="1">
  <xs:complexType>
    <xs:attribute name="серия" type="xs:string" use="required" />
    <xs:attribute name="номер" type="xs:unsignedInt" use="required"/>
    <xs:attribute name="дата"  use="required"  >
	<xs:simpleType> 
		 <xs:restriction base ="xs:string">
			<xs:pattern value="[0-9]{2}.[0-9]{2}.[0-9]{4}"/>
		 </xs:restriction>
	  </xs:simpleType>
     </xs:attribute>
  </xs:complexType>
</xs:element>
<xs:element maxOccurs="3" name="телефон" type="xs:unsignedInt"/>
<xs:element name="адрес">   <xs:complexType><xs:sequence>
   <xs:element name="страна" type="xs:string" />
   <xs:element name="город" type="xs:string" />
   <xs:element name="улица" type="xs:string" />
   <xs:element name="дом" type="xs:string" />
   <xs:element name="квартира" type="xs:string" />
</xs:sequence></xs:complexType>  </xs:element>
</xs:sequence></xs:complexType>
</xs:element></xs:schema>';
--drop table STUDENT;
go
create table STUDENT1
( IDSTUDENT integer  identity(1000,1) 
		 constraint STUDENT1_PK  primary key,
   IDGROUP integer constraint STUDENT_GROUP_FK2
		 foreign key  references GROUPS(IDGROUP),        
  NAME nvarchar(100), 
  BDAY  date,
  STAMP timestamp,
  INFO     xml(STUDENT1),    
  FOTO   varbinary
  );
  select *from STUDENT1
  insert into STUDENT1 (INFO)
    values ('<студент>
  <паспорт серия="серия1" номер="0" дата="02.18.2018" />
  <телефон>0</телефон>
  <телефон>4294967295</телефон>
  <телефон>1</телефон>
  <адрес>
    <страна>страна1</страна>
    <город>город1</город>
    <улица>улица1</улица>
    <дом>дом1</дом>
    <квартира>квартира1</квартира>
  </адрес>
</студент>') 
   Select *from STUDENT1



use L_My_Base

--1
select ID_заказчика, ID_Товара, Количество
  from заказы
  where ID_заказчика like '1%' 
  for xml RAW, elements

 --2
 go
select k.ID_Товара [ID],
           k.Дата_заказа[Дата],
		   k.Количество [Количество] 
		   from заказы k join покупатели j
		     on k.ID_заказчика= j.ID_покупателя
	where j.Покупатель = 'Apple' for xml AUTO, root('Список_Товаров'), elements;











	go
declare @h int = 0,--дескриптор
@sbj varchar(3000) = '<?xml version="1.0" encoding="windows-1251" ?>
                      <покупатели1>
					     <покупатели ID_покупателя="19232" Покупатель="выш" Телефон="12432423" Адрес="khfahkusf" />
					  </покупатели1>';
exec sp_xml_preparedocument @h output, @sbj;
insert покупатели select[ID_покупателя], [Покупатель], [Телефон],[Адрес] from openxml(@h, '/покупатели1/покупатели',0)
    with([ID_покупателя] int, [Покупатель] nvarchar(50), [Телефон] int,[Адрес] nchar(20));-- структура результирующего набора
select * from покупатели






----2
-- DECLARE @xmlData XML =N'
--     <Shops> 
--         <Shop id="1">
--             <device name="Sensation" vendor="HTC" id="1" />
--             <device name="iPhone" vendor="Apple" id="2" />
--         </Shop>
--         <Shop id="2">
--             <device name="Mozart" vendor="HTC" id="3" />
--             <device name="Lumia" vendor="Nokia" id="4" />
--        </Shop>
--    </Shops>';
--     SELECT @xmlData.query('/Shops/Shop/device')


----3
--CREATE TABLE dbo.tArtist (
--      artistId INT NOT NULL PRIMARY KEY
--    , name VARCHAR(100) NOT NULL
--    , xmlData XML NOT NULL
--);
--INSERT INTO dbo.tArtist (artistId, name, xmlData) VALUES
--(1, 'Radiohead',
--'<albums>
--    <album title="The King of Limbs">
--        <labels>
--            <label>Self-released</label>
--        </labels>
--        <song title="Bloom" length="5:15"/>
--        <song title="Morning Mr Magpie" length="4:41"/>
--        <song title="Little by Little" length="4:27"/>
--        <song title="Feral" length="3:13"/>
--        <song title="Lotus Flower" length="5:01"/>
--        <song title="Codex" length="4:47"/>
--        <song title="Give Up the Ghost" length="4:50"/>
--        <song title="Separator" length="5:20"/>
--        <description link="http://en.wikipedia.org/wiki/The_King_of_Limbs">
--        The King of Limbs is the eighth studio album by English rock band Radiohead,
--        produced by Nigel Godrich. It was self-released on 18 February 2011 as a 
--        download in MP3 and WAV formats, followed by physical CD and 12" vinyl 
--        releases on 28 March, a wider digital release via AWAL, and a special 
--        "newspaper" edition on 9 May 2011. The physical editions were released 
--        through the band''s Ticker Tape imprint on XL in the United Kingdom, 
--        TBD in the United States, and Hostess Entertainment in Japan.
--        </description>
--    </album>
--    <album title="OK Computer">
--        <labels>
--            <label>Parlophone</label>
--            <label>Capitol</label>
--        </labels>
--        <song title="Airbag" length="4:44"/>
--        <song title="Paranoid Android" length="6:23"/>
--        <song title="Subterranean Homesick Alien" length="4:27"/>
--        <song title="Exit Music (For a Film)" length="4:24"/>
--        <song title="Let Down" length="4:59"/>
--        <song title="Karma Police" length="4:21"/>
--        <song title="Fitter Happier" length="1:57"/>
--        <song title="Electioneering" length="3:50"/>
--        <song title="Climbing Up the Walls" length="4:45"/>
--        <song title="No Surprises" length="3:48"/>
--        <song title="Lucky" length="4:19"/>
--        <song title="The Tourist" length="5:24"/>
--        <description link="http://en.wikipedia.org/wiki/OK_Computer">
--        OK Computer is the third studio album by the English alternative rock band 
--        Radiohead, released on 16 June 1997 on Parlophone in the United Kingdom and 
--        1 July 1997 by Capitol Records in the United States. It marks a deliberate 
--        attempt by the band to move away from the introspective guitar-oriented 
--        sound of their previous album The Bends. Its layered sound and wide range 
--        of influences set it apart from many of the Britpop and alternative rock 
--        bands popular at the time and laid the groundwork for Radiohead''s later, 
--        more experimental work.
--        </description>
--    </album>
--</albums>'),
--(2, 'Guns N'' Roses',
--'<albums>
--    <album title="Use Your Illusion I">
--        <labels>
--            <label>Geffen Records</label>
--        </labels>
--        <song title="Right Next Door to Hell" length="3:02"/>
--        <song title="Dust N'' Bones" length="4:58"/>
--        <song title="Live and Let Die (Paul McCartney and Wings cover)" 
--        length="3:04"/>
--        <song title="Don''t Cry (original version)" length="4:44"/>
--        <song title="Perfect Crime" length="2:24"/>
--        <song title="You Ain''t the First" length="2:36"/>
--        <song title="Bad Obsession" length="5:28"/>
--        <song title="Back Off Bitch" length="5:04"/>
--        <song title="Double Talkin'' Jive" length="3:24"/>
--        <song title="November Rain" length="8:57"/>
--        <song title="The Garden (featuring Alice Cooper and Shannon Hoon)" 
--        length="5:22"/>
--        <song title="Garden of Eden" length="2:42"/>
--        <song title="Don''t Damn Me" length="5:19"/>
--        <song title="Bad Apples" length="4:28"/>
--        <song title="Dead Horse" length="4:18"/>
--        <song title="Coma" length="10:13"/>
--        <description link="http://ru.wikipedia.org/wiki/Use_Your_Illusion_I">
--        Use Your Illusion I is the third studio album by GnR. It was the first of two 
--        albums released in conjunction with the Use Your Illusion Tour, the other 
--        being Use Your Illusion II. The two are thus sometimes considered a double album. 
--        In fact, in the original vinyl releases, both Use Your Illusion albums are 
--        double albums. Material for all two/four discs (depending on the medium) was 
--        recorded at the same time and there was some discussion of releasing a 
--        ''quadruple album''. The album debuted at No. 2 on the Billboard charts, selling 
--        685,000 copies in its first week, behind Use Your Illusion II''s first week sales
--        of 770,000. Use Your Illusion I has sold 5,502,000 units in the U.S. as of 2010, 
--        according to Nielsen SoundScan. It was nominated for a Grammy Award in 1992.
--        </description>
--    </album>
--    <album title="Use Your Illusion II">
--        <labels>
--            <label>Geffen Records</label>
--        </labels>
--        <song title="Civil War" length="7:42"/>
--        <song title="14 Years" length="4:21"/>
--        <song title="Yesterdays" length="3:16"/>
--        <song title="Knockin'' on Heaven''s Door (Bob Dylan cover)" length="5:36"/>
--        <song title="Get in the Ring" length="5:41"/>
--        <song title="Shotgun Blues" length="3:23"/>
--        <song title="Breakdown" length="7:05"/>
--        <song title="Pretty Tied Up" length="4:48"/>
--        <song title="Locomotive (Complicity)" length="8:42"/>
--        <song title="So Fine" length="4:06"/>
--        <song title="Estranged" length="9:24"/>
--        <song title="You Could Be Mine" length="5:43"/>
--        <song title="Don''t Cry (Alternate lyrics)" length="4:44"/>
--        <song title="My World" length="1:24"/>
--        <description link="http://ru.wikipedia.org/wiki/Use_Your_Illusion_II">
--        Use Your Illusion II is the fourth studio album by GnR. It was one of two albums 
--        released in conjunction with the Use Your Illusion Tour, and as a result the two 
--        albums are sometimes considered a double album. Bolstered by lead single ''You 
--        Could Be Mine'', Use Your Illusion II was the slightly more popular of the two 
--        albums, selling 770,000 copies its first week and debuting at No. 1 on the U.S. 
--        charts, ahead of Use Your Illusion I''s first week sales of 685,000.
--        </description>
--    </album>
--</albums>');

-----------------------DB-----------------

