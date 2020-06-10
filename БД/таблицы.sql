USE [KUN_MyBase]
GO

/****** Object:  Table [dbo].[Заказы]    Script Date: 25.02.2017 11:38:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Заказы](
	[Номер_заказа] [int] NOT NULL,
	[ID_заказчика] [nchar](10) NULL,
	[ID_товара] [nchar](10) NULL,
	[Наименование_товара] [nchar](20) NULL,
	[Цена] [money] NULL,
	[Безналичный_рассчет] [char](1) NULL,
	[Количество] [int] NULL,
	[Дата_сделки] [date] NULL,
	[Количество_ячеек] [int] NULL,
 CONSTRAINT [PK_Заказы] PRIMARY KEY CLUSTERED 
(
	[Номер_заказа] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[Заказы]  WITH CHECK ADD  CONSTRAINT [FK_Заказы_Покупатели] FOREIGN KEY([ID_заказчика])
REFERENCES [dbo].[Покупатели] ([ID_покупателя])
GO

ALTER TABLE [dbo].[Заказы] CHECK CONSTRAINT [FK_Заказы_Покупатели]
GO

ALTER TABLE [dbo].[Заказы]  WITH CHECK ADD  CONSTRAINT [FK_Заказы_Товар] FOREIGN KEY([ID_товара])
REFERENCES [dbo].[Товар] ([ID_товара])
GO

ALTER TABLE [dbo].[Заказы] CHECK CONSTRAINT [FK_Заказы_Товар]
GO

ALTER TABLE [dbo].[Заказы]  WITH CHECK ADD  CONSTRAINT [FK_Заказы_Хранение] FOREIGN KEY([ID_товара])
REFERENCES [dbo].[Хранение] ([ID_товара])
GO

ALTER TABLE [dbo].[Заказы] CHECK CONSTRAINT [FK_Заказы_Хранение]
GO

//////////////////////////////////////////////////////////////////////////
USE [KUN_MyBase]
GO

/****** Object:  Table [dbo].[Покупатели]    Script Date: 25.02.2017 11:40:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Покупатели](
	[ID_покупателя] [nchar](10) NOT NULL,
	[Покупатель] [nchar](10) NOT NULL,
	[Телефон] [nchar](8) NULL,
	[Адрес] [nchar](15) NULL,
 CONSTRAINT [PK_Покупатели_1] PRIMARY KEY CLUSTERED 
(
	[ID_покупателя] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
//////////////////////////////////////////////////////////////////////////

USE [KUN_MyBase]
GO

/****** Object:  Table [dbo].[Товар]    Script Date: 25.02.2017 11:40:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Товар](
	[ID_товара] [nchar](10) NOT NULL,
	[Наименование_товара] [nchar](20) NULL,
	[Цена] [money] NULL,
	[Количество] [int] NULL,
	[Описание] [nchar](52) NULL,
	[Место_хранения] [nchar](10) NULL,
	[Количество_ячеек] [int] NULL,
 CONSTRAINT [PK_Товар] PRIMARY KEY CLUSTERED 
(
	[ID_товара] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

//////////////////////////////////////////////////////////////////////////

USE [KUN_MyBase]
GO

/****** Object:  Table [dbo].[Хранение]    Script Date: 25.02.2017 11:41:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Хранение](
	[ID_товара] [nchar](10) NOT NULL,
	[Дата_сделки] [date] NULL,
	[Дата_окончания_сделки] [date] NULL,
	[Местоположение] [nchar](30) NULL,
	[Количество_ячеек] [int] NULL,
 CONSTRAINT [PK_Хранение] PRIMARY KEY CLUSTERED 
(
	[ID_товара] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

