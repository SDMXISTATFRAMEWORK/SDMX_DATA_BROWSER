USE [ISTAT.WebClient.DB_v3]
GO
/****** Object:  StoredProcedure [Caching].[ClearWidgetCache]    Script Date: 04/11/2016 10:05:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [Caching].[ClearWidgetCache]

AS

DELETE dbo.SavedWidget
GO
/****** Object:  StoredProcedure [Caching].[DeleteExpiredWidget]    Script Date: 04/11/2016 10:05:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*

EXEC Caching.InsertWidget 466,'ASD ASD ASD ASD ASD ASD ASD ASD ASD'

*/
CREATE PROCEDURE [Caching].[DeleteExpiredWidget]

@SECONDS INT

AS

--DELETE savedwidget
--WHERE DATEADD(SECOND,@SECONDS,DTUpdate) < GETDATE() 

UPDATE savedwidget
SET Deleted = 1
WHERE DATEADD(SECOND,@SECONDS,DTUpdate) < GETDATE() 

GO
/****** Object:  StoredProcedure [Caching].[DeleteWidget]    Script Date: 04/11/2016 10:05:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [Caching].[DeleteWidget]

@WDG_ID INT

AS

DELETE SavedWidget
WHERE wdg_id = @WDG_ID




GO
/****** Object:  StoredProcedure [Caching].[GetUpdateableWidgets]    Script Date: 04/11/2016 10:05:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
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
	AND wdg_type <> 'text'

GO
/****** Object:  StoredProcedure [Caching].[GetWidget]    Script Date: 04/11/2016 10:05:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [Caching].[GetWidget]

@WDG_ID INT,
@LOCALE VARCHAR(5)

AS

SELECT * 
FROM SavedWidget
WHERE wdg_id = @WDG_ID
	AND Locale = @LOCALE
GO
/****** Object:  StoredProcedure [Caching].[InsertWidget]    Script Date: 04/11/2016 10:05:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Caching].[InsertWidget]

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

GO
/****** Object:  StoredProcedure [Caching].[IsCachedWidget]    Script Date: 04/11/2016 10:05:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

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
	SET @EXIST = 0
GO
/****** Object:  StoredProcedure [DashBoard].[Activate]    Script Date: 04/11/2016 10:05:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [DashBoard].[Activate]

@IDDASHBOARD INT,
@ACTIVE BIT

AS

UPDATE dbo.Dashboard
SET dsb_active = @ACTIVE
WHERE dsb_id = @IDDASHBOARD
GO
/****** Object:  StoredProcedure [DashBoard].[AddRow]    Script Date: 04/11/2016 10:05:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [DashBoard].[AddRow]

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



GO
/****** Object:  StoredProcedure [DashBoard].[AddWidget]    Script Date: 04/11/2016 10:05:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

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





GO
/****** Object:  StoredProcedure [DashBoard].[AddWidgetText]    Script Date: 04/11/2016 10:05:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

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





GO
/****** Object:  StoredProcedure [DashBoard].[Create]    Script Date: 04/11/2016 10:05:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
CREATEDASHBOARD 'USERCODE',2,'IT|EN','titolo it|titolo en',0

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

Declare @DSB_ORDER int

Select @DSB_ORDER=count(1) from dbo.Dashboard

	INSERT INTO dbo.Dashboard
			( dsb_userCode ,
			  dsb_rowsNum ,
			  dsb_date ,
			  dsb_active,
			  dsb_order
			)
	VALUES  ( @USERCODE , 
			  @ROWNUM , 
			  GETDATE() , 
			  @ACTIVE,
			  (@DSB_ORDER+1)
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

GO
/****** Object:  StoredProcedure [DashBoard].[Delete]    Script Date: 04/11/2016 10:05:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [DashBoard].[Delete]

@IDDASHBOARD INT

AS

DELETE dbo.Dashboard
WHERE dsb_id = @IDDASHBOARD
GO
/****** Object:  StoredProcedure [DashBoard].[DeleteRow]    Script Date: 04/11/2016 10:05:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [DashBoard].[DeleteRow]

@ROWID INT

AS

DELETE Dashboard_row
WHERE dsb_row_id = @ROWID




GO
/****** Object:  StoredProcedure [DashBoard].[DeleteWidget]    Script Date: 04/11/2016 10:05:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create PROC [DashBoard].[DeleteWidget]

@WDG_ID INT

AS

DELETE Widgets
WHERE [wdg_id] = @WDG_ID




GO
/****** Object:  StoredProcedure [DashBoard].[DeleteWidgetText]    Script Date: 04/11/2016 10:05:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROC [DashBoard].[DeleteWidgetText]

@WDG_TEXT_ID INT

AS

DELETE [dbo].[Widget_text]
WHERE [wdg_text_id] = @WDG_TEXT_ID





GO
/****** Object:  StoredProcedure [DashBoard].[GetDashBoardInfo]    Script Date: 04/11/2016 10:05:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*

exec [DashBoard].[Get]
*/
CREATE PROCEDURE [DashBoard].[GetDashBoardInfo]

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
ORDER BY dsb_order ASC

GO
/****** Object:  StoredProcedure [DashBoard].[GetDashBoardRow]    Script Date: 04/11/2016 10:05:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*

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

GO
/****** Object:  StoredProcedure [DashBoard].[GetDashBoardText]    Script Date: 04/11/2016 10:05:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*

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

GO
/****** Object:  StoredProcedure [DashBoard].[GetDashBoardWidget]    Script Date: 04/11/2016 10:05:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*

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

GO
/****** Object:  StoredProcedure [DashBoard].[GetDashBoardWidgetText]    Script Date: 04/11/2016 10:05:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

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

GO
/****** Object:  StoredProcedure [DashBoard].[UpdateRow]    Script Date: 04/11/2016 10:05:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

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





GO
/****** Object:  StoredProcedure [DashBoard].[UpdateWidget]    Script Date: 04/11/2016 10:05:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

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




GO
/****** Object:  StoredProcedure [DashBoard].[UpdateWidgetText]    Script Date: 04/11/2016 10:05:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

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







GO
/****** Object:  UserDefinedFunction [dbo].[ufnSplit]    Script Date: 04/11/2016 10:05:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[ufnSplit] (@string NVARCHAR(MAX))
RETURNS @parsedString TABLE (id NVARCHAR(MAX))
AS 
BEGIN
   DECLARE @separator NCHAR(1)
   SET @separator='|'
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
END
GO
/****** Object:  Table [dbo].[Dashboard]    Script Date: 04/11/2016 10:05:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dashboard](
	[dsb_id] [int] IDENTITY(1,1) NOT NULL,
	[dsb_userCode] [nvarchar](255) NULL,
	[dsb_rowsNum] [int] NULL,
	[dsb_date] [nvarchar](255) NULL,
	[dsb_active] [bit] NULL,
	[dsb_order] [int] NOT NULL,
 CONSTRAINT [PK__Dashboar__053374111ED998B2] PRIMARY KEY CLUSTERED 
(
	[dsb_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Dashboard_row]    Script Date: 04/11/2016 10:05:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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

GO
/****** Object:  Table [dbo].[Dashboard_text]    Script Date: 04/11/2016 10:05:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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

GO
/****** Object:  Table [dbo].[Query]    Script Date: 04/11/2016 10:05:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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

GO
/****** Object:  Table [dbo].[Roles]    Script Date: 04/11/2016 10:05:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RoleId] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SavedTree]    Script Date: 04/11/2016 10:05:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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

GO
/****** Object:  Table [dbo].[SavedWidget]    Script Date: 04/11/2016 10:05:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
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

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Settings]    Script Date: 04/11/2016 10:05:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Settings](
	[SettingId] [int] IDENTITY(1,1) NOT NULL,
	[Setting] [ntext] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SettingsOPT]    Script Date: 04/11/2016 10:05:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SettingsOPT](
	[IdOPT] [bit] NOT NULL,
	[View_tree] [bit] NULL,
	[View_tree_req] [bit] NULL,
	[View_tree_select] [bit] NULL,
	[View_login] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdOPT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SettingsWS]    Script Date: 04/11/2016 10:05:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SettingsWS](
	[SettingId] [int] IDENTITY(1,1) NOT NULL,
	[Locale] [nvarchar](255) NULL,
	[IDNode] [nvarchar](10) NULL,
	[Title] [nvarchar](255) NULL,
	[DecimalSeparator] [nchar](1) NULL,
	[Domain] [nvarchar](255) NULL,
	[EnableHTTPAuthentication] [bit] NULL,
	[EnableProxy] [bit] NULL,
	[EndPoint] [nvarchar](255) NULL,
	[EndPointV20] [nvarchar](255) NULL,
	[EndPointType] [nvarchar](10) NULL,
	[EndPointSource] [nvarchar](10) NULL,
	[Password] [nvarchar](50) NULL,
	[Prefix] [nvarchar](255) NULL,
	[ProxyPassword] [nvarchar](50) NULL,
	[ProxyServer] [nvarchar](255) NULL,
	[ProxyServerPort] [nvarchar](10) NULL,
	[ProxyUserName] [nvarchar](50) NULL,
	[UseSystemProxy] [bit] NULL,
	[UserName] [nvarchar](50) NULL,
	[Wsdl] [nvarchar](255) NULL,
	[Active] [bit] NULL,
	[UseUncategorysed] [bit] NULL,
	[UseVirtualDf] [bit] NULL,
	[Ordering] [int] NULL,
 CONSTRAINT [PK_SettingsWS] PRIMARY KEY CLUSTERED 
(
	[SettingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Template]    Script Date: 04/11/2016 10:05:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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

GO
/****** Object:  Table [dbo].[UserRoles]    Script Date: 04/11/2016 10:05:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserRoles](
	[UserCode] [varchar](50) NOT NULL,
	[RoleId] [int] NOT NULL,
 CONSTRAINT [PK_UserRoles] PRIMARY KEY CLUSTERED 
(
	[UserCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserSettings]    Script Date: 04/11/2016 10:05:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserSettings](
	[UserCode] [nvarchar](50) NOT NULL,
	[Settings] [ntext] NOT NULL,
 CONSTRAINT [PK_UserSettings] PRIMARY KEY CLUSTERED 
(
	[UserCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Widget_text]    Script Date: 04/11/2016 10:05:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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

GO
/****** Object:  Table [dbo].[Widgets]    Script Date: 04/11/2016 10:05:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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

GO
ALTER TABLE [dbo].[Dashboard] ADD  CONSTRAINT [DF_Dashboard_dsd_order]  DEFAULT ((0)) FOR [dsb_order]
GO
ALTER TABLE [dbo].[SettingsOPT] ADD  DEFAULT ((1)) FOR [IdOPT]
GO
ALTER TABLE [dbo].[Dashboard_row]  WITH CHECK ADD  CONSTRAINT [FK_Dashboard_row_Dashboard] FOREIGN KEY([dsb_id])
REFERENCES [dbo].[Dashboard] ([dsb_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Dashboard_row] CHECK CONSTRAINT [FK_Dashboard_row_Dashboard]
GO
ALTER TABLE [dbo].[Dashboard_text]  WITH CHECK ADD  CONSTRAINT [FK_Dashboard_text_Dashboard] FOREIGN KEY([dsb_id])
REFERENCES [dbo].[Dashboard] ([dsb_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Dashboard_text] CHECK CONSTRAINT [FK_Dashboard_text_Dashboard]
GO
ALTER TABLE [dbo].[SavedWidget]  WITH CHECK ADD  CONSTRAINT [FK_SavedWidget_Widgets] FOREIGN KEY([wdg_id])
REFERENCES [dbo].[Widgets] ([wdg_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SavedWidget] CHECK CONSTRAINT [FK_SavedWidget_Widgets]
GO
ALTER TABLE [dbo].[UserRoles]  WITH CHECK ADD  CONSTRAINT [FK_UserRoles_Roles] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([RoleId])
GO
ALTER TABLE [dbo].[UserRoles] CHECK CONSTRAINT [FK_UserRoles_Roles]
GO
ALTER TABLE [dbo].[Widget_text]  WITH CHECK ADD  CONSTRAINT [FK_widget_text_to_widget] FOREIGN KEY([wdg_id])
REFERENCES [dbo].[Widgets] ([wdg_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Widget_text] CHECK CONSTRAINT [FK_widget_text_to_widget]
GO
ALTER TABLE [dbo].[Widgets]  WITH CHECK ADD  CONSTRAINT [FK_widget_to_dashboard_row] FOREIGN KEY([wdg_row_id])
REFERENCES [dbo].[Dashboard_row] ([dsb_row_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Widgets] CHECK CONSTRAINT [FK_widget_to_dashboard_row]
GO
ALTER TABLE [dbo].[SettingsOPT]  WITH CHECK ADD  CONSTRAINT [onerow_uni] CHECK  (([IdOPT]=(1)))
GO
ALTER TABLE [dbo].[SettingsOPT] CHECK CONSTRAINT [onerow_uni]
GO



USE [ISTAT.WebClient.DB_v3]
GO
SET IDENTITY_INSERT [dbo].[SettingsWS] ON 

GO
INSERT [dbo].[SettingsWS] ([SettingId], [Locale], [IDNode], [Title], [DecimalSeparator], [Domain], [EnableHTTPAuthentication], [EnableProxy], [EndPoint], [EndPointV20], [EndPointType], [EndPointSource], [Password], [Prefix], [ProxyPassword], [ProxyServer], [ProxyServerPort], [ProxyUserName], [UseSystemProxy], [UserName], [Wsdl], [Active], [UseUncategorysed], [UseVirtualDf], [Ordering]) VALUES (3, NULL, N'UN', N'UN', N'.', N'', 0, 0, N'http://data.un.org/WS/NSIEstatV20Service', N'http://data.un.org/WS/NSIEstatV20Service', N'V20', N'RI', N'', N'', N'', N'', N'0', N'', 0, N'', N'', 1, 0, 0, 10)
GO
INSERT [dbo].[SettingsWS] ([SettingId], [Locale], [IDNode], [Title], [DecimalSeparator], [Domain], [EnableHTTPAuthentication], [EnableProxy], [EndPoint], [EndPointV20], [EndPointType], [EndPointSource], [Password], [Prefix], [ProxyPassword], [ProxyServer], [ProxyServerPort], [ProxyUserName], [UseSystemProxy], [UserName], [Wsdl], [Active], [UseUncategorysed], [UseVirtualDf], [Ordering]) VALUES (4, NULL, N'it1', N'Main Node', N'.', N'', 0, 0, N'http://shnodo2.pc.istat.it/WS_PRINC/NsiEstatV20Service.asmx', N'http://shnodo2.pc.istat.it/WS_PRINC/NsiEstatV20Service.asmx', N'V20', N'RI', N'', N'', N'', N'', N'0', N'', 0, N'', N'', 1, 0, 0, 0)
GO
INSERT [dbo].[SettingsWS] ([SettingId], [Locale], [IDNode], [Title], [DecimalSeparator], [Domain], [EnableHTTPAuthentication], [EnableProxy], [EndPoint], [EndPointV20], [EndPointType], [EndPointSource], [Password], [Prefix], [ProxyPassword], [ProxyServer], [ProxyServerPort], [ProxyUserName], [UseSystemProxy], [UserName], [Wsdl], [Active], [UseUncategorysed], [UseVirtualDf], [Ordering]) VALUES (5, NULL, N'IT1', N'Temi Generali', N'.', N'', 0, 0, N'http://shnodo1.pc.istat.it/WS_STATES/NsiEstatV20Service.asmx', N'http://shnodo1.pc.istat.it/WS_STATES/NsiEstatV20Service.asmx', N'V20', N'RI', N'', N'', N'', N'', N'0', N'', 0, N'', N'', 1, 0, 0, 1)
GO
INSERT [dbo].[SettingsWS] ([SettingId], [Locale], [IDNode], [Title], [DecimalSeparator], [Domain], [EnableHTTPAuthentication], [EnableProxy], [EndPoint], [EndPointV20], [EndPointType], [EndPointSource], [Password], [Prefix], [ProxyPassword], [ProxyServer], [ProxyServerPort], [ProxyUserName], [UseSystemProxy], [UserName], [Wsdl], [Active], [UseUncategorysed], [UseVirtualDf], [Ordering]) VALUES (6, NULL, N'IT2', N'Banca Italia V21', N'.', N'', 0, 0, N'http://sdmx.istat.it/WS_BI/SdmxService', N'http://sdmx.istat.it/WS_BI/NSIEstatV20Service.asmx', N'V21', N'RI', N'', N'', N'', N'', N'0', N'', 0, N'', N'', 1, 0, 0, 5)
GO
INSERT [dbo].[SettingsWS] ([SettingId], [Locale], [IDNode], [Title], [DecimalSeparator], [Domain], [EnableHTTPAuthentication], [EnableProxy], [EndPoint], [EndPointV20], [EndPointType], [EndPointSource], [Password], [Prefix], [ProxyPassword], [ProxyServer], [ProxyServerPort], [ProxyUserName], [UseSystemProxy], [UserName], [Wsdl], [Active], [UseUncategorysed], [UseVirtualDf], [Ordering]) VALUES (7, NULL, N'ESTAT', N'Eurostat WS', N'.', N'', 1, 0, N'https://webgate.ec.europa.eu/nsi-jax-ws/SdmxServiceService', N'https://webgate.ec.europa.eu/nsi-jax-ws/NSIEstatV20Service', N'V21', N'RI', N'napsdata', N'', N'', N'', N'0', N'', 0, N'napsdata', N'', 1, 0, 0, 6)
GO
INSERT [dbo].[SettingsWS] ([SettingId], [Locale], [IDNode], [Title], [DecimalSeparator], [Domain], [EnableHTTPAuthentication], [EnableProxy], [EndPoint], [EndPointV20], [EndPointType], [EndPointSource], [Password], [Prefix], [ProxyPassword], [ProxyServer], [ProxyServerPort], [ProxyUserName], [UseSystemProxy], [UserName], [Wsdl], [Active], [UseUncategorysed], [UseVirtualDf], [Ordering]) VALUES (8, NULL, N'IT1', N'Ministero Economia e Finanze', N'.', N'', 0, 0, N'http://shnodes.pc.istat.it/WS_MEF/NSIStdV20Service.asmx', N'http://shnodes.pc.istat.it/WS_MEF/NSIStdV20Service.asmx', N'V20', N'RI', N'', N'', N'', N'', N'0', N'', 0, N'', N'', 1, 0, 0, 7)
GO
INSERT [dbo].[SettingsWS] ([SettingId], [Locale], [IDNode], [Title], [DecimalSeparator], [Domain], [EnableHTTPAuthentication], [EnableProxy], [EndPoint], [EndPointV20], [EndPointType], [EndPointSource], [Password], [Prefix], [ProxyPassword], [ProxyServer], [ProxyServerPort], [ProxyUserName], [UseSystemProxy], [UserName], [Wsdl], [Active], [UseUncategorysed], [UseVirtualDf], [Ordering]) VALUES (9, NULL, N'IT1', N'Regione Lombardia', N'.', N'', 0, 0, N'http://shnodo2.pc.istat.it/WS_LOMBARDIA/NsiEstatV20Service.asmx', N'http://shnodo2.pc.istat.it/WS_LOMBARDIA/NsiEstatV20Service.asmx', N'V20', N'RI', N'', N'', N'', N'', N'0', N'', 0, N'', N'', 1, 0, 0, 2)
GO
INSERT [dbo].[SettingsWS] ([SettingId], [Locale], [IDNode], [Title], [DecimalSeparator], [Domain], [EnableHTTPAuthentication], [EnableProxy], [EndPoint], [EndPointV20], [EndPointType], [EndPointSource], [Password], [Prefix], [ProxyPassword], [ProxyServer], [ProxyServerPort], [ProxyUserName], [UseSystemProxy], [UserName], [Wsdl], [Active], [UseUncategorysed], [UseVirtualDf], [Ordering]) VALUES (10, NULL, N'IT1', N'Regione Sicilia', N'.', N'', 0, 0, N'http://shnodo2.pc.istat.it/WS_SICILIA/NsiEstatV20Service.asmx', N'http://shnodo2.pc.istat.it/WS_SICILIA/NsiEstatV20Service.asmx', N'V20', N'RI', N'', N'', N'', N'', N'0', N'', 0, N'', N'', 1, 0, 0, 3)
GO
INSERT [dbo].[SettingsWS] ([SettingId], [Locale], [IDNode], [Title], [DecimalSeparator], [Domain], [EnableHTTPAuthentication], [EnableProxy], [EndPoint], [EndPointV20], [EndPointType], [EndPointSource], [Password], [Prefix], [ProxyPassword], [ProxyServer], [ProxyServerPort], [ProxyUserName], [UseSystemProxy], [UserName], [Wsdl], [Active], [UseUncategorysed], [UseVirtualDf], [Ordering]) VALUES (11, NULL, N'IT12', N'INPS', N'.', N'', 0, 0, N' http://89.97.59.156/sdmxws/SoapSdmx20', N' http://89.97.59.156/sdmxws/SoapSdmx20', N'V20', N'RI', N'', N'', N'', N'', N'0', N'', 0, N'', N'', 1, 0, 0, 4)
GO
INSERT [dbo].[SettingsWS] ([SettingId], [Locale], [IDNode], [Title], [DecimalSeparator], [Domain], [EnableHTTPAuthentication], [EnableProxy], [EndPoint], [EndPointV20], [EndPointType], [EndPointSource], [Password], [Prefix], [ProxyPassword], [ProxyServer], [ProxyServerPort], [ProxyUserName], [UseSystemProxy], [UserName], [Wsdl], [Active], [UseUncategorysed], [UseVirtualDf], [Ordering]) VALUES (12, NULL, N'IT1', N'Comune di Vicenza', N'.', N'', 0, 0, N'http://shnodo2.pc.istat.it/WS_VIC/NsiEstatV20Service.asmx', N'http://shnodo2.pc.istat.it/WS_VIC/NsiEstatV20Service.asmx', N'V20', N'RI', N'', N'', N'', N'', N'0', N'', 0, N'', N'', 1, 0, 0, 8)
GO
INSERT [dbo].[SettingsWS] ([SettingId], [Locale], [IDNode], [Title], [DecimalSeparator], [Domain], [EnableHTTPAuthentication], [EnableProxy], [EndPoint], [EndPointV20], [EndPointType], [EndPointSource], [Password], [Prefix], [ProxyPassword], [ProxyServer], [ProxyServerPort], [ProxyUserName], [UseSystemProxy], [UserName], [Wsdl], [Active], [UseUncategorysed], [UseVirtualDf], [Ordering]) VALUES (13, NULL, N'MEX', N'INEGI -Mexico', N'.', N'', 0, 0, N'http://www.snieg.mx/opendata/NSIEstatV20Service.asmx', N'http://www.snieg.mx/opendata/NSIEstatV20Service.asmx', N'V20', N'RI', N'', N'', N'', N'', N'0', N'', 0, N'', N'', 1, 0, 0, 9)
GO
SET IDENTITY_INSERT [dbo].[SettingsWS] OFF
GO

USE [ISTAT.WebClient.DB_v3]
GO
INSERT [dbo].[SettingsOPT] ([IdOPT], [View_tree], [View_tree_req], [View_tree_select], [View_login]) VALUES (1, 1, 1, 1, 1)
GO

