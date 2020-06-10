use master
create database L_My_Base
USE [L_My_Base]
GO

/****** Object:  Table [dbo].[������]    Script Date: 13.03.2018 20:01:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[������](
	[�����_������] [int] NOT NULL,
	[ID_���������] [int] NULL,
	[ID_������] [int] NOT NULL,
	[�����������_������] [nchar](10) NULL,
	[����������] [int] NULL,
	[����_������] [date] NULL,
	[����_���������_������] [int] NULL,
	[��������] [nchar](1) NULL,
	[��������_������] [int] NULL,
 CONSTRAINT [PK_������] PRIMARY KEY CLUSTERED 
(
	[�����_������] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[������]  WITH CHECK ADD  CONSTRAINT [FK_������_����������] FOREIGN KEY([ID_���������])
REFERENCES [dbo].[����������] ([ID_����������])
GO

ALTER TABLE [dbo].[������] CHECK CONSTRAINT [FK_������_����������]
GO

ALTER TABLE [dbo].[������]  WITH CHECK ADD  CONSTRAINT [FK_������_������] FOREIGN KEY([ID_������])
REFERENCES [dbo].[������] ([ID_������])
GO

ALTER TABLE [dbo].[������] CHECK CONSTRAINT [FK_������_������]
GO

ALTER TABLE [dbo].[������]  WITH CHECK ADD  CONSTRAINT [CK__������__��������__35BCFE0A] CHECK  (([��������]='���' OR [��������]='�������'))
GO

ALTER TABLE [dbo].[������] CHECK CONSTRAINT [CK__������__��������__35BCFE0A]
GO


/****** Object:  Table [dbo].[����������]    Script Date: 13.03.2018 20:03:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[����������](
	[ID_����������] [int] NOT NULL,
	[����������] [int] NULL,
	[�������] [int] NULL,
	[�����] [nchar](20) NOT NULL,
 CONSTRAINT [PK_����������] PRIMARY KEY CLUSTERED 
(
	[ID_����������] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[������]    Script Date: 13.03.2018 20:03:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[������](
	[ID_������] [int] NOT NULL,
	[������������_�����] [nchar](20) NULL,
	[����] [money] NULL,
	[����������] [int] NULL,
	[�����_��������] [nchar](30) NULL,
	[��������] [nchar](50) NULL,
	[����_������������] [date] NULL,
 CONSTRAINT [PK_������] PRIMARY KEY CLUSTERED 
(
	[ID_������] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

