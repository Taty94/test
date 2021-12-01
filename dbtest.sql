USE [dbtest]
GO
/****** Object:  Table [dbo].[proveedor]    Script Date: 12/1/2021 8:59:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[proveedor](
	[proveedor_id] [int] IDENTITY(1,1) NOT NULL,
	[proveedor_ruc] [varchar](13) NOT NULL,
	[proveedor_nombre] [varchar](max) NOT NULL,
	[proveedor_direccion] [varchar](max) NULL,
	[proveedor_email] [varchar](max) NULL,
	[proveedor_telefono] [varchar](10) NULL,
 CONSTRAINT [PK_proveedor] PRIMARY KEY CLUSTERED 
(
	[proveedor_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ventas]    Script Date: 12/1/2021 8:59:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ventas](
	[ventas_id] [int] IDENTITY(1,1) NOT NULL,
	[ventas_idproveedor] [int] NOT NULL,
	[ventas_producto] [varchar](max) NULL,
	[ventas_descripcion] [varchar](max) NULL,
	[ventas_fecha] [datetime] NOT NULL,
	[ventas_total] [decimal](10, 2) NULL,
 CONSTRAINT [PK_ventas] PRIMARY KEY CLUSTERED 
(
	[ventas_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
