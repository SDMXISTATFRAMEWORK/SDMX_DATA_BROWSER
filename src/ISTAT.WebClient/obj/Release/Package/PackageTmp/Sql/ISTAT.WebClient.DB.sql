IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_widget_to_dashboard_row]') AND parent_object_id = OBJECT_ID(N'[dbo].[Widgets]'))
ALTER TABLE [dbo].[Widgets] DROP CONSTRAINT [FK_widget_to_dashboard_row]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_widget_text_to_widget]') AND parent_object_id = OBJECT_ID(N'[dbo].[Widget_text]'))
ALTER TABLE [dbo].[Widget_text] DROP CONSTRAINT [FK_widget_text_to_widget]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_UserRoles_Roles]') AND parent_object_id = OBJECT_ID(N'[dbo].[UserRoles]'))
ALTER TABLE [dbo].[UserRoles] DROP CONSTRAINT [FK_UserRoles_Roles]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SavedWidget_Widgets]') AND parent_object_id = OBJECT_ID(N'[dbo].[SavedWidget]'))
ALTER TABLE [dbo].[SavedWidget] DROP CONSTRAINT [FK_SavedWidget_Widgets]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Dashboard_text_Dashboard]') AND parent_object_id = OBJECT_ID(N'[dbo].[Dashboard_text]'))
ALTER TABLE [dbo].[Dashboard_text] DROP CONSTRAINT [FK_Dashboard_text_Dashboard]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Dashboard_row_Dashboard]') AND parent_object_id = OBJECT_ID(N'[dbo].[Dashboard_row]'))
ALTER TABLE [dbo].[Dashboard_row] DROP CONSTRAINT [FK_Dashboard_row_Dashboard]
GO
/****** Object:  Table [dbo].[Widgets]    Script Date: 05/08/2015 15:18:57 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Widgets]') AND type in (N'U'))
DROP TABLE [dbo].[Widgets]
GO
/****** Object:  Table [dbo].[Widget_text]    Script Date: 05/08/2015 15:18:57 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Widget_text]') AND type in (N'U'))
DROP TABLE [dbo].[Widget_text]
GO
/****** Object:  Table [dbo].[UserSettings]    Script Date: 05/08/2015 15:18:57 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserSettings]') AND type in (N'U'))
DROP TABLE [dbo].[UserSettings]
GO
/****** Object:  Table [dbo].[UserRoles]    Script Date: 05/08/2015 15:18:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserRoles]') AND type in (N'U'))
DROP TABLE [dbo].[UserRoles]
GO
/****** Object:  Table [dbo].[Template]    Script Date: 05/08/2015 15:18:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Template]') AND type in (N'U'))
DROP TABLE [dbo].[Template]
GO
/****** Object:  Table [dbo].[Settings]    Script Date: 05/08/2015 15:18:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Settings]') AND type in (N'U'))
DROP TABLE [dbo].[Settings]
GO
/****** Object:  Table [dbo].[SavedWidget]    Script Date: 05/08/2015 15:18:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SavedWidget]') AND type in (N'U'))
DROP TABLE [dbo].[SavedWidget]
GO
/****** Object:  Table [dbo].[SavedTree]    Script Date: 05/08/2015 15:18:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SavedTree]') AND type in (N'U'))
DROP TABLE [dbo].[SavedTree]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 05/08/2015 15:18:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Roles]') AND type in (N'U'))
DROP TABLE [dbo].[Roles]
GO
/****** Object:  Table [dbo].[Query]    Script Date: 05/08/2015 15:18:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Query]') AND type in (N'U'))
DROP TABLE [dbo].[Query]
GO
/****** Object:  Table [dbo].[Dashboard_text]    Script Date: 05/08/2015 15:18:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Dashboard_text]') AND type in (N'U'))
DROP TABLE [dbo].[Dashboard_text]
GO
/****** Object:  Table [dbo].[Dashboard_row]    Script Date: 05/08/2015 15:18:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Dashboard_row]') AND type in (N'U'))
DROP TABLE [dbo].[Dashboard_row]
GO
/****** Object:  Table [dbo].[Dashboard]    Script Date: 05/08/2015 15:18:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Dashboard]') AND type in (N'U'))
DROP TABLE [dbo].[Dashboard]
GO
/****** Object:  UserDefinedFunction [dbo].[ufnSplit]    Script Date: 05/08/2015 15:18:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ufnSplit]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[ufnSplit]
GO
/****** Object:  StoredProcedure [DashBoard].[UpdateWidgetText]    Script Date: 05/08/2015 15:18:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DashBoard].[UpdateWidgetText]') AND type in (N'P', N'PC'))
DROP PROCEDURE [DashBoard].[UpdateWidgetText]
GO
/****** Object:  StoredProcedure [DashBoard].[UpdateWidget]    Script Date: 05/08/2015 15:18:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DashBoard].[UpdateWidget]') AND type in (N'P', N'PC'))
DROP PROCEDURE [DashBoard].[UpdateWidget]
GO
/****** Object:  StoredProcedure [DashBoard].[UpdateRow]    Script Date: 05/08/2015 15:18:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DashBoard].[UpdateRow]') AND type in (N'P', N'PC'))
DROP PROCEDURE [DashBoard].[UpdateRow]
GO
/****** Object:  StoredProcedure [DashBoard].[GetDashBoardWidgetText]    Script Date: 05/08/2015 15:18:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DashBoard].[GetDashBoardWidgetText]') AND type in (N'P', N'PC'))
DROP PROCEDURE [DashBoard].[GetDashBoardWidgetText]
GO
/****** Object:  StoredProcedure [DashBoard].[GetDashBoardWidget]    Script Date: 05/08/2015 15:18:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DashBoard].[GetDashBoardWidget]') AND type in (N'P', N'PC'))
DROP PROCEDURE [DashBoard].[GetDashBoardWidget]
GO
/****** Object:  StoredProcedure [DashBoard].[GetDashBoardText]    Script Date: 05/08/2015 15:18:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DashBoard].[GetDashBoardText]') AND type in (N'P', N'PC'))
DROP PROCEDURE [DashBoard].[GetDashBoardText]
GO
/****** Object:  StoredProcedure [DashBoard].[GetDashBoardRow]    Script Date: 05/08/2015 15:18:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DashBoard].[GetDashBoardRow]') AND type in (N'P', N'PC'))
DROP PROCEDURE [DashBoard].[GetDashBoardRow]
GO
/****** Object:  StoredProcedure [DashBoard].[GetDashBoardInfo]    Script Date: 05/08/2015 15:18:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DashBoard].[GetDashBoardInfo]') AND type in (N'P', N'PC'))
DROP PROCEDURE [DashBoard].[GetDashBoardInfo]
GO
/****** Object:  StoredProcedure [DashBoard].[DeleteWidgetText]    Script Date: 05/08/2015 15:18:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DashBoard].[DeleteWidgetText]') AND type in (N'P', N'PC'))
DROP PROCEDURE [DashBoard].[DeleteWidgetText]
GO
/****** Object:  StoredProcedure [DashBoard].[DeleteWidget]    Script Date: 05/08/2015 15:18:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DashBoard].[DeleteWidget]') AND type in (N'P', N'PC'))
DROP PROCEDURE [DashBoard].[DeleteWidget]
GO
/****** Object:  StoredProcedure [DashBoard].[DeleteRow]    Script Date: 05/08/2015 15:18:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DashBoard].[DeleteRow]') AND type in (N'P', N'PC'))
DROP PROCEDURE [DashBoard].[DeleteRow]
GO
/****** Object:  StoredProcedure [DashBoard].[Delete]    Script Date: 05/08/2015 15:18:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DashBoard].[Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [DashBoard].[Delete]
GO
/****** Object:  StoredProcedure [DashBoard].[Create]    Script Date: 05/08/2015 15:18:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DashBoard].[Create]') AND type in (N'P', N'PC'))
DROP PROCEDURE [DashBoard].[Create]
GO
/****** Object:  StoredProcedure [DashBoard].[AddWidgetText]    Script Date: 05/08/2015 15:18:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DashBoard].[AddWidgetText]') AND type in (N'P', N'PC'))
DROP PROCEDURE [DashBoard].[AddWidgetText]
GO
/****** Object:  StoredProcedure [DashBoard].[AddWidget]    Script Date: 05/08/2015 15:18:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DashBoard].[AddWidget]') AND type in (N'P', N'PC'))
DROP PROCEDURE [DashBoard].[AddWidget]
GO
/****** Object:  StoredProcedure [DashBoard].[AddRow]    Script Date: 05/08/2015 15:18:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DashBoard].[AddRow]') AND type in (N'P', N'PC'))
DROP PROCEDURE [DashBoard].[AddRow]
GO
/****** Object:  StoredProcedure [DashBoard].[Activate]    Script Date: 05/08/2015 15:18:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DashBoard].[Activate]') AND type in (N'P', N'PC'))
DROP PROCEDURE [DashBoard].[Activate]
GO
/****** Object:  StoredProcedure [Caching].[IsCachedWidget]    Script Date: 05/08/2015 15:18:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Caching].[IsCachedWidget]') AND type in (N'P', N'PC'))
DROP PROCEDURE [Caching].[IsCachedWidget]
GO
/****** Object:  StoredProcedure [Caching].[InsertWidget]    Script Date: 05/08/2015 15:18:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Caching].[InsertWidget]') AND type in (N'P', N'PC'))
DROP PROCEDURE [Caching].[InsertWidget]
GO
/****** Object:  StoredProcedure [Caching].[GetWidget]    Script Date: 05/08/2015 15:18:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Caching].[GetWidget]') AND type in (N'P', N'PC'))
DROP PROCEDURE [Caching].[GetWidget]
GO
/****** Object:  StoredProcedure [Caching].[GetUpdateableWidgets]    Script Date: 05/08/2015 15:18:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Caching].[GetUpdateableWidgets]') AND type in (N'P', N'PC'))
DROP PROCEDURE [Caching].[GetUpdateableWidgets]
GO
/****** Object:  StoredProcedure [Caching].[DeleteWidget]    Script Date: 05/08/2015 15:18:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Caching].[DeleteWidget]') AND type in (N'P', N'PC'))
DROP PROCEDURE [Caching].[DeleteWidget]
GO
/****** Object:  StoredProcedure [Caching].[DeleteExpiredWidget]    Script Date: 05/08/2015 15:18:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Caching].[DeleteExpiredWidget]') AND type in (N'P', N'PC'))
DROP PROCEDURE [Caching].[DeleteExpiredWidget]
GO
/****** Object:  StoredProcedure [Caching].[ClearWidgetCache]    Script Date: 05/08/2015 15:18:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Caching].[ClearWidgetCache]') AND type in (N'P', N'PC'))
DROP PROCEDURE [Caching].[ClearWidgetCache]
GO
/****** Object:  Schema [DashBoard]    Script Date: 05/08/2015 15:18:58 ******/
IF  EXISTS (SELECT * FROM sys.schemas WHERE name = N'DashBoard')
DROP SCHEMA [DashBoard]
GO
/****** Object:  Schema [Caching]    Script Date: 05/08/2015 15:18:58 ******/
IF  EXISTS (SELECT * FROM sys.schemas WHERE name = N'Caching')
DROP SCHEMA [Caching]
GO
/****** Object:  Schema [Caching]    Script Date: 05/08/2015 15:18:58 ******/
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'Caching')
EXEC sys.sp_executesql N'CREATE SCHEMA [Caching]'

GO
/****** Object:  Schema [DashBoard]    Script Date: 05/08/2015 15:18:58 ******/
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'DashBoard')
EXEC sys.sp_executesql N'CREATE SCHEMA [DashBoard]'

GO
/****** Object:  StoredProcedure [Caching].[ClearWidgetCache]    Script Date: 05/08/2015 15:18:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Caching].[ClearWidgetCache]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
create PROCEDURE [Caching].[ClearWidgetCache]

AS

DELETE dbo.SavedWidget' 
END
GO
/****** Object:  StoredProcedure [Caching].[DeleteExpiredWidget]    Script Date: 05/08/2015 15:18:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Caching].[DeleteExpiredWidget]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/*

EXEC Caching.InsertWidget 466,''ASD ASD ASD ASD ASD ASD ASD ASD ASD''

*/
CREATE PROCEDURE [Caching].[DeleteExpiredWidget]

@SECONDS INT

AS

--DELETE savedwidget
--WHERE DATEADD(SECOND,@SECONDS,DTUpdate) < GETDATE() 

UPDATE savedwidget
SET Deleted = 1
WHERE DATEADD(SECOND,@SECONDS,DTUpdate) < GETDATE() 
' 
END
GO
/****** Object:  StoredProcedure [Caching].[DeleteWidget]    Script Date: 05/08/2015 15:18:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Caching].[DeleteWidget]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create PROCEDURE [Caching].[DeleteWidget]

@WDG_ID INT

AS

DELETE SavedWidget
WHERE wdg_id = @WDG_ID



' 
END
GO
/****** Object:  StoredProcedure [Caching].[GetUpdateableWidgets]    Script Date: 05/08/2015 15:18:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Caching].[GetUpdateableWidgets]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/*
exec [Caching].[GetUpdateableWidgets] 150
*/
CREATE PROCEDURE [Caching].[GetUpdateableWidgets]

AS

SELECT  
		a.wdg_id ,
        a.wdg_class ,
        a.wdg_row_id ,
        a.wdg_cell ,+
        a.wdg_type ,
        a.wdg_chartType ,
        a.wdg_v ,
        a.wdg_vt ,
        a.wdg_vc ,
        a.wdg_endPoint ,
        a.wdg_endPointV20 ,
        a.wdg_endPointType ,
        a.wdg_endpointSource,
        a.wdg_dataflow_id ,
        a.wdg_dataflow_agency_id ,
        a.wdg_dataflow_version ,
        a.wdg_decimalCulture ,
        a.wdg_criteria ,
        a.wdg_layout,
		a2.wdg_text_Locale 	
FROM Widgets a
	INNER JOIN dbo.Widget_text a2 ON
		a.wdg_id = a2.wdg_id
	LEFT OUTER JOIN(
		SELECT DISTINCT wdg_id,Deleted
		FROM SavedWidget
		--WHERE Deleted = 0
	)  b ON
		a.wdg_id = b.wdg_id
WHERE (b.wdg_id IS NULL or b.Deleted = 1)
	AND wdg_type <> ''text''
' 
END
GO
/****** Object:  StoredProcedure [Caching].[GetWidget]    Script Date: 05/08/2015 15:18:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Caching].[GetWidget]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
create PROCEDURE [Caching].[GetWidget]

@WDG_ID INT,
@LOCALE VARCHAR(5)

AS

SELECT * 
FROM SavedWidget
WHERE wdg_id = @WDG_ID
	AND Locale = @LOCALE' 
END
GO
/****** Object:  StoredProcedure [Caching].[InsertWidget]    Script Date: 05/08/2015 15:18:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Caching].[InsertWidget]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [Caching].[InsertWidget]

@WDG_ID INT,
@WIDGETDATA NTEXT,
@LOCALE VARCHAR(5)

AS

DELETE SavedWidget
WHERE wdg_id = @WDG_ID
		AND Locale = @LOCALE

INSERT INTO SavedWidget
	(wdg_id,WidgetData,Locale,DTUpdate,Deleted)
VALUES
	(@WDG_ID,@WIDGETDATA,@LOCALE,GETDATE(),0)
' 
END
GO
/****** Object:  StoredProcedure [Caching].[IsCachedWidget]    Script Date: 05/08/2015 15:18:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Caching].[IsCachedWidget]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
create PROCEDURE [Caching].[IsCachedWidget]

@WDG_ID INT,
@LOCALE VARCHAR(5),
@EXIST BIT OUT
AS

DECLARE @ID INT

SELECT @ID = wdg_id 
FROM SavedWidget
WHERE wdg_id = @WDG_ID
	AND Locale = @LOCALE

IF(@ID IS NOT NULL)
	 SET @EXIST = 1
ELSE	
	SET @EXIST = 0' 
END
GO
/****** Object:  StoredProcedure [DashBoard].[Activate]    Script Date: 05/08/2015 15:18:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DashBoard].[Activate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [DashBoard].[Activate]

@IDDASHBOARD INT,
@ACTIVE BIT

AS

UPDATE dbo.Dashboard
SET dsb_active = @ACTIVE
WHERE dsb_id = @IDDASHBOARD' 
END
GO
/****** Object:  StoredProcedure [DashBoard].[AddRow]    Script Date: 05/08/2015 15:18:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DashBoard].[AddRow]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROC [DashBoard].[AddRow]

@DSBID INT,
@SPLITTED BIT,
@ORDER INT OUT,
@ROWID INT OUT

AS

IF(@ORDER = -1)
	SELECT @ORDER = [ORDER] +1
	FROM Dashboard_row
	WHERE dsb_id = @DSBID

IF(@ORDER = -1)
	SET @ORDER = 1

INSERT INTO Dashboard_row
        ( splitted, dsb_id, [order] )
VALUES  ( @SPLITTED, -- splitted - bit
          @DSBID, -- dsb_id - int
          @ORDER  -- order - int
          )

SELECT @ROWID = SCOPE_IDENTITY()


' 
END
GO
/****** Object:  StoredProcedure [DashBoard].[AddWidget]    Script Date: 05/08/2015 15:18:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DashBoard].[AddWidget]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROC [DashBoard].[AddWidget]

@WDG_CLASS NVARCHAR(50) = NULL,
@WDG_ROW_ID INT = NULL,
@WDG_CELL INT = NULL,
@WDG_TYPE NVARCHAR(50) = NULL,
@WDG_CHARTTYPE NVARCHAR(50) = NULL,
@WDG_V BIT = NULL,
@WDG_VT BIT = NULL,
@WDG_VC BIT = NULL,
@WDG_ENDPOINT NVARCHAR(255) = NULL,
@WDG_ENDPOINTTYPE NVARCHAR(255) = NULL,
@WDG_ENDPOINTV20 NVARCHAR(255) = NULL,
@WDG_ENDPOINTSOURCE NVARCHAR(255) = NULL,
@WDG_ENDPOINTDECIMAL NVARCHAR(255) = NULL,
@WDG_DATAFLOW_ID NVARCHAR(255) = NULL,
@WDG_DATAFLOW_AGENCY_ID NVARCHAR(255) = NULL,
@WDG_DATAFLOW_VERSION NVARCHAR(255) = NULL,
@WDG_CRITERIA NTEXT = NULL,
@WDG_LAYOUT NTEXT = NULL,
@WDG_ID INT OUT


AS

INSERT INTO dbo.Widgets
        ( wdg_class ,
          wdg_row_id ,
          wdg_cell ,
          wdg_type ,
          wdg_chartType ,
          wdg_v ,
          wdg_vt ,
          wdg_vc ,
          wdg_endPoint ,
          wdg_endPointType ,
          wdg_endPointV20,
		  wdg_endpointSource ,
		  wdg_decimalCulture,
          wdg_dataflow_id ,
          wdg_dataflow_agency_id ,
          wdg_dataflow_version ,
          wdg_criteria ,
          wdg_layout
        )
VALUES  ( @WDG_CLASS , -- wdg_class - nvarchar(255)
          @WDG_ROW_ID , -- wdg_row_id - int
          @WDG_CELL , -- wdg_cell - int
          @WDG_TYPE , -- wdg_type - nvarchar(50)
          @WDG_CHARTTYPE , -- wdg_chartType - nvarchar(50)
          @WDG_V , -- wdg_v - bit
          @WDG_VT , -- wdg_vt - bit
          @WDG_VC , -- wdg_vc - bit
          @WDG_ENDPOINT , -- wdg_endPoint - nvarchar(255)
          @WDG_ENDPOINTTYPE , -- wdg_endPointType - nvarchar(255)
          @WDG_ENDPOINTV20 , -- wdg_endPointV20 - nvarchar(255)
		  @WDG_ENDPOINTSOURCE , -- wdg_endpointSource - nvarchar(255)
		  @WDG_ENDPOINTDECIMAL , -- wdg_decimalCulture - nvarchar(255)
          @WDG_DATAFLOW_ID , -- wdg_dataflow_id - nvarchar(255)
          @WDG_DATAFLOW_AGENCY_ID , -- wdg_dataflow_agency_id - nvarchar(255)
          @WDG_DATAFLOW_VERSION , -- wdg_dataflow_version - nvarchar(255)
          @WDG_CRITERIA , -- wdg_criteria - ntext
          @WDG_LAYOUT  -- wdg_layout - ntext
        )

SELECT @WDG_ID = SCOPE_IDENTITY()




' 
END
GO
/****** Object:  StoredProcedure [DashBoard].[AddWidgetText]    Script Date: 05/08/2015 15:18:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DashBoard].[AddWidgetText]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
create PROC [DashBoard].[AddWidgetText]

@WDG_ID INT ,
@WDG_TEXT_TITLE NVARCHAR(255) = NULL,
@WDG_TEXT_CONTENT NTEXT = NULL,
@WDG_TEXT_LOCALE NVARCHAR(255) = NULL,
@WDG_TEXT_ID INT OUT

AS

INSERT INTO dbo.Widget_text
        ( wdg_text_Title ,
          wdg_text_Content ,
          wdg_text_Locale ,
          wdg_id
        )
VALUES  ( @WDG_TEXT_TITLE , -- wdg_text_Title - nvarchar(255)
          @WDG_TEXT_CONTENT , -- wdg_text_Content - ntext
          @WDG_TEXT_LOCALE , -- wdg_text_Locale - nvarchar(255)
          @WDG_ID  -- wdg_id - int
        )

SELECT @WDG_TEXT_ID = SCOPE_IDENTITY()




' 
END
GO
/****** Object:  StoredProcedure [DashBoard].[Create]    Script Date: 05/08/2015 15:18:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DashBoard].[Create]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/*
CREATEDASHBOARD ''USERCODE'',2,''IT|EN'',''titolo it|titolo en'',0

SELECT *
FROM Dashboard

SELECT *
FROM Dashboard_TEXT

SELECT *
FROM Dashboard_row

*/

CREATE PROCEDURE [DashBoard].[Create]

@USERCODE NVARCHAR(255),
@ROWNUM INT,
@LOCALES VARCHAR(2000),
@VALUES VARCHAR(5000),
@ACTIVE BIT = 0,
@IDDASHBOARD INT OUT

AS

	SET NOCOUNT ON

	CREATE TABLE #LOCALES
	(
		IDROW INT IDENTITY,
		LOCALE VARCHAR(500)
	)

	CREATE TABLE #VALUES
	(
		IDROW INT IDENTITY,
		VALUE VARCHAR(500)
	)


BEGIN TRANSACTION;

BEGIN TRY

	INSERT INTO #LOCALES
	SELECT id 
	FROM dbo.ufnSplit(@LOCALES)

	INSERT INTO #VALUES
	SELECT id 
	FROM dbo.ufnSplit(@VALUES)

	INSERT INTO dbo.Dashboard
			( dsb_userCode ,
			  dsb_rowsNum ,
			  dsb_date ,
			  dsb_active
			)
	VALUES  ( @USERCODE , 
			  @ROWNUM , 
			  GETDATE() , 
			  @ACTIVE
			)

	SELECT @IDDASHBOARD = SCOPE_IDENTITY()

	INSERT INTO dbo.Dashboard_text
	        ( dsb_text_Title ,
	          dsb_text_Locale ,
	          dsb_id
	        )
	SELECT VALUE,LOCALE, @IDDASHBOARD
	FROM #LOCALES A
		INNER JOIN #VALUES B ON
			A.IDROW = B.IDROW

	--INSERT INTO Dashboard_row
 --       (splitted, dsb_id,[order])
	--VALUES  ( 0, -- splitted - bit
	--		  @IDDASHBOARD, -- dsb_id - int
	--		  1  -- order - int
	--		  )	




END TRY
BEGIN CATCH
    DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;

    SELECT 
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;

    RAISERROR (@ErrorMessage, -- Message text.
               @ErrorSeverity, -- Severity.
               @ErrorState -- State.
               );

END CATCH;

IF @@TRANCOUNT > 0
    COMMIT TRANSACTION;
' 
END
GO
/****** Object:  StoredProcedure [DashBoard].[Delete]    Script Date: 05/08/2015 15:18:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DashBoard].[Delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [DashBoard].[Delete]

@IDDASHBOARD INT

AS

DELETE dbo.Dashboard
WHERE dsb_id = @IDDASHBOARD' 
END
GO
/****** Object:  StoredProcedure [DashBoard].[DeleteRow]    Script Date: 05/08/2015 15:18:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DashBoard].[DeleteRow]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROC [DashBoard].[DeleteRow]

@ROWID INT

AS

DELETE Dashboard_row
WHERE dsb_row_id = @ROWID



' 
END
GO
/****** Object:  StoredProcedure [DashBoard].[DeleteWidget]    Script Date: 05/08/2015 15:18:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DashBoard].[DeleteWidget]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

create PROC [DashBoard].[DeleteWidget]

@WDG_ID INT

AS

DELETE Widgets
WHERE [wdg_id] = @WDG_ID



' 
END
GO
/****** Object:  StoredProcedure [DashBoard].[DeleteWidgetText]    Script Date: 05/08/2015 15:18:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DashBoard].[DeleteWidgetText]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
create PROC [DashBoard].[DeleteWidgetText]

@WDG_TEXT_ID INT

AS

DELETE [dbo].[Widget_text]
WHERE [wdg_text_id] = @WDG_TEXT_ID




' 
END
GO
/****** Object:  StoredProcedure [DashBoard].[GetDashBoardInfo]    Script Date: 05/08/2015 15:18:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DashBoard].[GetDashBoardInfo]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/*

exec [DashBoard].[Get]
*/
create PROCEDURE [DashBoard].[GetDashBoardInfo]

@IDDASHBOARD INT = NULL,
@ACTIVE BIT = NULL

AS

SELECT  dsb_id ,
        dsb_userCode ,
        dsb_rowsNum ,
        dsb_date ,
        dsb_active	
FROM dbo.Dashboard
WHERE 
	(dsb_id = @IDDASHBOARD OR @IDDASHBOARD IS NULL)
	AND
	(dsb_active = @ACTIVE OR @ACTIVE IS NULL)
' 
END
GO
/****** Object:  StoredProcedure [DashBoard].[GetDashBoardRow]    Script Date: 05/08/2015 15:18:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DashBoard].[GetDashBoardRow]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/*

exec [DashBoard].[Get]
*/
CREATE PROCEDURE [DashBoard].[GetDashBoardRow]

@IDDASHBOARD INT

AS

SELECT  dsb_row_id ,
        splitted ,
        dsb_id ,
        [order]	
FROM dbo.Dashboard_row
WHERE dsb_id = @IDDASHBOARD
' 
END
GO
/****** Object:  StoredProcedure [DashBoard].[GetDashBoardText]    Script Date: 05/08/2015 15:18:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DashBoard].[GetDashBoardText]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/*

exec [DashBoard].[Get]
*/
create PROCEDURE [DashBoard].[GetDashBoardText]

@IDDASHBOARD INT

AS

SELECT  dsb_text_id ,
        dsb_text_Title ,
        dsb_text_Locale ,
        dsb_id	
FROM dbo.Dashboard_text
WHERE dsb_id = @IDDASHBOARD
' 
END
GO
/****** Object:  StoredProcedure [DashBoard].[GetDashBoardWidget]    Script Date: 05/08/2015 15:18:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DashBoard].[GetDashBoardWidget]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/*

exec [DashBoard].[Get]
*/
CREATE PROCEDURE [DashBoard].[GetDashBoardWidget]

@IDROW INT

AS

SELECT  wdg_id ,
        wdg_class ,
        wdg_row_id ,
        wdg_cell ,
        wdg_type ,
        wdg_chartType ,
        wdg_v ,
        wdg_vt ,
        wdg_vc ,
        wdg_endPoint ,
        wdg_endPointType ,
        wdg_endPointV20 ,
        wdg_endpointSource ,
        wdg_decimalCulture ,
        wdg_dataflow_id ,
        wdg_dataflow_agency_id ,
        wdg_dataflow_version ,
        wdg_criteria ,
        wdg_layout
FROM dbo.Widgets
WHERE wdg_row_id = @IDROW
' 
END
GO
/****** Object:  StoredProcedure [DashBoard].[GetDashBoardWidgetText]    Script Date: 05/08/2015 15:18:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DashBoard].[GetDashBoardWidgetText]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [DashBoard].[GetDashBoardWidgetText]

@WDGID INT

AS

SELECT  wdg_text_id ,
        wdg_text_Title ,
        wdg_text_Content ,
        wdg_text_Locale ,
        wdg_id
FROM [dbo].[Widget_text]
WHERE wdg_id = @WDGID
' 
END
GO
/****** Object:  StoredProcedure [DashBoard].[UpdateRow]    Script Date: 05/08/2015 15:18:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DashBoard].[UpdateRow]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROC [DashBoard].[UpdateRow]

@ROWID INT,
@SPLITTED BIT,
@ORDER INT OUT

AS

IF(@ORDER = -1)
	SELECT @ORDER = [ORDER] +1
	FROM [Dashboard_row]
	WHERE [dsb_id] = (SELECT [dsb_id] FROM [Dashboard_row] WHERE [dsb_row_id] = @ROWID)

IF(@ORDER = -1)
	SET @ORDER = 1

UPDATE [Dashboard_row]
SET [splitted] = @SPLITTED, 
	[order] = @ORDER
WHERE dsb_row_id = @ROWID;




' 
END
GO
/****** Object:  StoredProcedure [DashBoard].[UpdateWidget]    Script Date: 05/08/2015 15:18:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DashBoard].[UpdateWidget]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROC [DashBoard].[UpdateWidget]

@WDG_ID INT,
@WDG_CLASS NVARCHAR(50) = NULL,
@WDG_ROW_ID INT = NULL,
@WDG_CELL INT = NULL,
@WDG_TYPE NVARCHAR(50) = NULL,
@WDG_CHARTTYPE NVARCHAR(50) = NULL,
@WDG_V BIT = NULL,
@WDG_VT BIT = NULL,
@WDG_VC BIT = NULL,
@WDG_ENDPOINT NVARCHAR(255) = NULL,
@WDG_ENDPOINTTYPE NVARCHAR(255) = NULL,
@WDG_ENDPOINTV20 NVARCHAR(255) = NULL,
@WDG_ENDPOINTSOURCE NVARCHAR(255) = NULL,
@WDG_ENDPOINTDECIMAL NVARCHAR(255) = NULL,
@WDG_DATAFLOW_ID NVARCHAR(255) = NULL,
@WDG_DATAFLOW_AGENCY_ID NVARCHAR(255) = NULL,
@WDG_DATAFLOW_VERSION NVARCHAR(255) = NULL,
@WDG_CRITERIA NTEXT = NULL,
@WDG_LAYOUT NTEXT = NULL


AS

UPDATE Widgets
SET
	wdg_class = @WDG_CLASS,
	wdg_row_id = @WDG_ROW_ID,
	wdg_cell = @WDG_CELL,
	wdg_type = @WDG_TYPE,
	wdg_chartType = @WDG_CHARTTYPE,
	wdg_v = @WDG_V,
	wdg_vt = @WDG_VT,
	wdg_vc = @WDG_VC,
	wdg_endPoint = @WDG_ENDPOINT,
	wdg_endPointType = @WDG_ENDPOINTTYPE,
	wdg_endPointV20 = @WDG_ENDPOINTV20,
	wdg_endpointSource = @WDG_ENDPOINTSOURCE,
	wdg_decimalCulture= @WDG_ENDPOINTDECIMAL,
	wdg_dataflow_id = @WDG_DATAFLOW_ID,
	wdg_dataflow_agency_id = @WDG_DATAFLOW_AGENCY_ID,
	wdg_dataflow_version = @WDG_DATAFLOW_VERSION,
	wdg_criteria = @WDG_CRITERIA,
	wdg_layout = @WDG_LAYOUT
WHERE
	WDG_ID = @WDG_ID

DELETE SavedWidget
WHERE wdg_id = @WDG_ID



' 
END
GO
/****** Object:  StoredProcedure [DashBoard].[UpdateWidgetText]    Script Date: 05/08/2015 15:18:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DashBoard].[UpdateWidgetText]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROC [DashBoard].[UpdateWidgetText]

@WDG_ID INT,
@WDG_TEXT_LOCALE NVARCHAR(255) = NULL,
@WDG_TEXT_TITLE NVARCHAR(255) = NULL,
@WDG_TEXT_CONTENT NTEXT = NULL

AS

UPDATE Widget_text
SET 
	wdg_text_Title = @WDG_TEXT_TITLE,
    wdg_text_Content = @WDG_TEXT_CONTENT,
    wdg_text_Locale = @WDG_TEXT_LOCALE
WHERE
	wdg_id = @WDG_ID
	AND wdg_text_Locale = @WDG_TEXT_LOCALE






' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[ufnSplit]    Script Date: 05/08/2015 15:18:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ufnSplit]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE FUNCTION [dbo].[ufnSplit] (@string NVARCHAR(MAX))
RETURNS @parsedString TABLE (id NVARCHAR(MAX))
AS 
BEGIN
   DECLARE @separator NCHAR(1)
   SET @separator=''|''
   DECLARE @position int
   SET @position = 1
   SET @string = @string + @separator
   WHILE charindex(@separator,@string,@position) <> 0
      BEGIN
         INSERT into @parsedString
         SELECT substring(@string, @position, charindex(@separator,@string,@position) - @position)
         SET @position = charindex(@separator,@string,@position) + 1
      END
     RETURN
END' 
END

GO
/****** Object:  Table [dbo].[Dashboard]    Script Date: 05/08/2015 15:18:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Dashboard]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Dashboard](
	[dsb_id] [int] IDENTITY(1,1) NOT NULL,
	[dsb_userCode] [nvarchar](255) NULL,
	[dsb_rowsNum] [int] NULL,
	[dsb_date] [nvarchar](255) NULL,
	[dsb_active] [bit] NULL,
 CONSTRAINT [PK__Dashboar__053374111ED998B2] PRIMARY KEY CLUSTERED 
(
	[dsb_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Dashboard_row]    Script Date: 05/08/2015 15:18:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Dashboard_row]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Dashboard_row](
	[dsb_row_id] [int] IDENTITY(1,1) NOT NULL,
	[splitted] [bit] NOT NULL,
	[dsb_id] [int] NOT NULL,
	[order] [int] NULL,
 CONSTRAINT [PK__Dashboar__377EDDC722AA2996] PRIMARY KEY CLUSTERED 
(
	[dsb_row_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Dashboard_text]    Script Date: 05/08/2015 15:18:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Dashboard_text]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Dashboard_text](
	[dsb_text_id] [int] IDENTITY(1,1) NOT NULL,
	[dsb_text_Title] [nvarchar](255) NULL,
	[dsb_text_Locale] [nvarchar](255) NULL,
	[dsb_id] [int] NOT NULL,
 CONSTRAINT [PK__Dashboar__3811BD03267ABA7A] PRIMARY KEY CLUSTERED 
(
	[dsb_text_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Query]    Script Date: 05/08/2015 15:18:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Query]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Query](
	[QueryId] [int] IDENTITY(1,1) NOT NULL,
	[UserCode] [nvarchar](50) NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
	[Dataflow] [ntext] NULL,
	[Criteria] [ntext] NULL,
	[Layout] [ntext] NULL,
	[Configuration] [ntext] NULL,
 CONSTRAINT [PK_Query] PRIMARY KEY CLUSTERED 
(
	[QueryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 05/08/2015 15:18:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Roles]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Roles](
	[RoleId] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[SavedTree]    Script Date: 05/08/2015 15:18:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SavedTree]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SavedTree](
	[TreeId] [int] IDENTITY(1,1) NOT NULL,
	[Configuration] [nvarchar](max) NOT NULL,
	[SavedTreeJson] [ntext] NOT NULL,
	[LastUpdate] [nvarchar](50) NOT NULL,
	[LastRequest] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_SavedTree] PRIMARY KEY CLUSTERED 
(
	[TreeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[SavedWidget]    Script Date: 05/08/2015 15:18:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SavedWidget]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SavedWidget](
	[SWID] [int] IDENTITY(1,1) NOT NULL,
	[wdg_id] [int] NOT NULL,
	[WidgetData] [ntext] NOT NULL,
	[Locale] [varchar](5) NOT NULL,
	[DTUpdate] [datetime] NOT NULL,
	[Deleted] [bit] NOT NULL,
 CONSTRAINT [PK_SavedWidget] PRIMARY KEY CLUSTERED 
(
	[SWID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Settings]    Script Date: 05/08/2015 15:18:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Settings]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Settings](
	[SettingId] [int] IDENTITY(1,1) NOT NULL,
	[Setting] [ntext] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Template]    Script Date: 05/08/2015 15:18:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Template]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Template](
	[TemplateId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
	[tmplKey] [nvarchar](255) NOT NULL,
	[Configuration] [ntext] NULL,
	[Dataflow] [ntext] NULL,
	[Criteria] [ntext] NULL,
	[Layout] [ntext] NULL,
	[HideDimension] [ntext] NULL,
	[BlockXAxe] [bit] NULL,
	[BlockYAxe] [bit] NULL,
	[BlockZAxe] [bit] NULL,
	[EnableCriteria] [bit] NULL,
	[EnableDecimal] [bit] NULL,
	[Enablevaration] [bit] NULL,
 CONSTRAINT [PK_Template] PRIMARY KEY CLUSTERED 
(
	[TemplateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[UserRoles]    Script Date: 05/08/2015 15:18:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserRoles]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[UserRoles](
	[UserCode] [varchar](50) NOT NULL,
	[RoleId] [int] NOT NULL,
 CONSTRAINT [PK_UserRoles] PRIMARY KEY CLUSTERED 
(
	[UserCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserSettings]    Script Date: 05/08/2015 15:18:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserSettings]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[UserSettings](
	[UserCode] [nvarchar](50) NOT NULL,
	[Settings] [ntext] NOT NULL,
 CONSTRAINT [PK_UserSettings] PRIMARY KEY CLUSTERED 
(
	[UserCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Widget_text]    Script Date: 05/08/2015 15:18:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Widget_text]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Widget_text](
	[wdg_text_id] [int] IDENTITY(1,1) NOT NULL,
	[wdg_text_Title] [nvarchar](255) NULL,
	[wdg_text_Content] [ntext] NULL,
	[wdg_text_Locale] [nvarchar](255) NULL,
	[wdg_id] [int] NOT NULL,
 CONSTRAINT [PK__Widget_t__914F36402A4B4B5E] PRIMARY KEY CLUSTERED 
(
	[wdg_text_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Widgets]    Script Date: 05/08/2015 15:18:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Widgets]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Widgets](
	[wdg_id] [int] IDENTITY(1,1) NOT NULL,
	[wdg_class] [nvarchar](255) NULL,
	[wdg_row_id] [int] NOT NULL,
	[wdg_cell] [int] NULL,
	[wdg_type] [nvarchar](50) NULL,
	[wdg_chartType] [nvarchar](50) NULL,
	[wdg_v] [bit] NULL,
	[wdg_vt] [bit] NULL,
	[wdg_vc] [bit] NULL,
	[wdg_endPoint] [nvarchar](255) NULL,
	[wdg_endPointType] [nvarchar](255) NULL,
	[wdg_endPointV20] [nvarchar](255) NULL,
	[wdg_dataflow_id] [nvarchar](255) NULL,
	[wdg_dataflow_agency_id] [nvarchar](255) NULL,
	[wdg_dataflow_version] [nvarchar](255) NULL,
	[wdg_criteria] [ntext] NULL,
	[wdg_layout] [ntext] NULL,
	[wdg_decimalCulture] [nchar](2) NULL,
	[wdg_endpointSource] [nchar](255) NULL,
 CONSTRAINT [PK__Widgets__F4C084B82E1BDC42] PRIMARY KEY CLUSTERED 
(
	[wdg_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Dashboard_row_Dashboard]') AND parent_object_id = OBJECT_ID(N'[dbo].[Dashboard_row]'))
ALTER TABLE [dbo].[Dashboard_row]  WITH CHECK ADD  CONSTRAINT [FK_Dashboard_row_Dashboard] FOREIGN KEY([dsb_id])
REFERENCES [dbo].[Dashboard] ([dsb_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Dashboard_row_Dashboard]') AND parent_object_id = OBJECT_ID(N'[dbo].[Dashboard_row]'))
ALTER TABLE [dbo].[Dashboard_row] CHECK CONSTRAINT [FK_Dashboard_row_Dashboard]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Dashboard_text_Dashboard]') AND parent_object_id = OBJECT_ID(N'[dbo].[Dashboard_text]'))
ALTER TABLE [dbo].[Dashboard_text]  WITH CHECK ADD  CONSTRAINT [FK_Dashboard_text_Dashboard] FOREIGN KEY([dsb_id])
REFERENCES [dbo].[Dashboard] ([dsb_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Dashboard_text_Dashboard]') AND parent_object_id = OBJECT_ID(N'[dbo].[Dashboard_text]'))
ALTER TABLE [dbo].[Dashboard_text] CHECK CONSTRAINT [FK_Dashboard_text_Dashboard]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SavedWidget_Widgets]') AND parent_object_id = OBJECT_ID(N'[dbo].[SavedWidget]'))
ALTER TABLE [dbo].[SavedWidget]  WITH CHECK ADD  CONSTRAINT [FK_SavedWidget_Widgets] FOREIGN KEY([wdg_id])
REFERENCES [dbo].[Widgets] ([wdg_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SavedWidget_Widgets]') AND parent_object_id = OBJECT_ID(N'[dbo].[SavedWidget]'))
ALTER TABLE [dbo].[SavedWidget] CHECK CONSTRAINT [FK_SavedWidget_Widgets]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_UserRoles_Roles]') AND parent_object_id = OBJECT_ID(N'[dbo].[UserRoles]'))
ALTER TABLE [dbo].[UserRoles]  WITH CHECK ADD  CONSTRAINT [FK_UserRoles_Roles] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([RoleId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_UserRoles_Roles]') AND parent_object_id = OBJECT_ID(N'[dbo].[UserRoles]'))
ALTER TABLE [dbo].[UserRoles] CHECK CONSTRAINT [FK_UserRoles_Roles]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_widget_text_to_widget]') AND parent_object_id = OBJECT_ID(N'[dbo].[Widget_text]'))
ALTER TABLE [dbo].[Widget_text]  WITH CHECK ADD  CONSTRAINT [FK_widget_text_to_widget] FOREIGN KEY([wdg_id])
REFERENCES [dbo].[Widgets] ([wdg_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_widget_text_to_widget]') AND parent_object_id = OBJECT_ID(N'[dbo].[Widget_text]'))
ALTER TABLE [dbo].[Widget_text] CHECK CONSTRAINT [FK_widget_text_to_widget]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_widget_to_dashboard_row]') AND parent_object_id = OBJECT_ID(N'[dbo].[Widgets]'))
ALTER TABLE [dbo].[Widgets]  WITH CHECK ADD  CONSTRAINT [FK_widget_to_dashboard_row] FOREIGN KEY([wdg_row_id])
REFERENCES [dbo].[Dashboard_row] ([dsb_row_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_widget_to_dashboard_row]') AND parent_object_id = OBJECT_ID(N'[dbo].[Widgets]'))
ALTER TABLE [dbo].[Widgets] CHECK CONSTRAINT [FK_widget_to_dashboard_row]
GO
