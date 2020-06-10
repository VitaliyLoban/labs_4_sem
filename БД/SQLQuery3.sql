use master
create database L_My_Base
USE [L_My_Base]
GO

/****** Object:  Table [dbo].[заказы]    Script Date: 13.03.2018 20:01:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[заказы](
	[номер_заказа] [int] NOT NULL,
	[ID_заказчика] [int] NULL,
	[ID_Товара] [int] NOT NULL,
	[Безналичный_расчет] [nchar](10) NULL,
	[Количество] [int] NULL,
	[Дата_заказа] [date] NULL,
	[Дата_окончания_сделки] [int] NULL,
	[Доставка] [nchar](1) NULL,
	[Доставка_почтой] [int] NULL,
 CONSTRAINT [PK_заказы] PRIMARY KEY CLUSTERED 
(
	[номер_заказа] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[заказы]  WITH CHECK ADD  CONSTRAINT [FK_заказы_покупатели] FOREIGN KEY([ID_заказчика])
REFERENCES [dbo].[покупатели] ([ID_покупателя])
GO

ALTER TABLE [dbo].[заказы] CHECK CONSTRAINT [FK_заказы_покупатели]
GO

ALTER TABLE [dbo].[заказы]  WITH CHECK ADD  CONSTRAINT [FK_заказы_Товары] FOREIGN KEY([ID_Товара])
REFERENCES [dbo].[Товары] ([ID_товара])
GO

ALTER TABLE [dbo].[заказы] CHECK CONSTRAINT [FK_заказы_Товары]
GO

ALTER TABLE [dbo].[заказы]  WITH CHECK ADD  CONSTRAINT [CK__заказы__Доставка__35BCFE0A] CHECK  (([Доставка]='нет' OR [Доставка]='имеется'))
GO

ALTER TABLE [dbo].[заказы] CHECK CONSTRAINT [CK__заказы__Доставка__35BCFE0A]
GO


/****** Object:  Table [dbo].[покупатели]    Script Date: 13.03.2018 20:03:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[покупатели](
	[ID_покупателя] [int] NOT NULL,
	[Покупатель] [int] NULL,
	[Телефон] [int] NULL,
	[Адрес] [nchar](20) NOT NULL,
 CONSTRAINT [PK_покупатели] PRIMARY KEY CLUSTERED 
(
	[ID_покупателя] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Товары]    Script Date: 13.03.2018 20:03:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Товары](
	[ID_товара] [int] NOT NULL,
	[наименование_товра] [nchar](20) NULL,
	[цена] [money] NULL,
	[количество] [int] NULL,
	[место_хранения] [nchar](30) NULL,
	[описание] [nchar](50) NULL,
	[Дата_производства] [date] NULL,
 CONSTRAINT [PK_Товары] PRIMARY KEY CLUSTERED 
(
	[ID_товара] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

