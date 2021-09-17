/****** Object:  StoredProcedure [dbo].[spOverwriteActivityChallenge]    Script Date: 7/30/2021 11:23:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE  [dbo].[spOverwriteActivityChallenge]
AS
BEGIN TRY

    SET NOCOUNT ON;
    DECLARE @CurrentDate datetime
    DECLARE @LastLoadDate datetime
    DECLARE @LoadDate datetime

    DECLARE @ReseedKey BIGINT
    DECLARE @InsertedDate datetime


    DECLARE @ProcedureName varchar(100)
    SET @ProcedureName = 'dbo.spOverwriteActivityChallenge'


    SET @CurrentDate = convert(datetime, getdate()) AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time'
    SET @LastLoadDate =
    (
        SELECT MAX(LoadDate)
        FROM dbo.CTRL_TableLoadDate
        WHERE TableName = 'dbo.STG_ActivityChallenge'
    )
    SET @InsertedDate = convert(datetime, getdate()) AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time'

    BEGIN

		MERGE [dbo].[STG_ActivityChallenge] as [target]
				USING
				(SELECT [ContactID]
                      , [dacadoo_ID]
                      , [EventID]
                      , [Dollar Value (USD)]
                      , [RewardDate]
                      , [PointsAwarded]
                      , REPLACE(REPLACE([DescriptionText], CHAR(10), CHAR(32)), CHAR(13), CHAR(32)) AS [DescriptionText]
					  FROM [dbo].[STG_ActivityChallenge_LOAD]
				WHERE [dacadoo_ID] is not null
				and [EventID] is not null
				and [ContactID] is not NULL) as [source]
				ON (
					   [target].[dacadoo_ID] = [source].[dacadoo_ID]
					   and [target].[EventID] = [source].[EventID]
					   and [target].[ContactID] = [source].[ContactID]
					   and [target].[RewardDate] = [source].[RewardDate]
					   and [target].[PointsAwarded] = [source].[PointsAwarded]
					   and [target].[DescriptionText] = [source].[DescriptionText]
				   )
				WHEN MATCHED THEN --Null record values do not merge and serve no function in rewarding so they are excluded
					UPDATE SET
							[EventID]				= source.[EventID]
							  ,[dacadoo_ID]			= source.[dacadoo_ID]
							  ,[ContactID]			= [source].[ContactID]
							  ,[RewardDate]			= source.[RewardDate]
							  ,[PointsAwarded]		= source.[PointsAwarded]
							  ,[Dollar Value (USD)] = source.[Dollar Value (USD)]
							  ,[DescriptionText]	= source.[DescriptionText]
							  ,UpdatedDateTime		= @CurrentDate
							  ,UpdatedDateID		= CONVERT(    VARCHAR(8),    CAST(@CurrentDate AS date),   112)

				WHEN NOT MATCHED THEN --Null record values do not merge and serve no function in rewarding so they are excluded
					INSERT
					(
						[ContactID]
						,[dacadoo_ID]
						,[EventID]
						,[Dollar Value (USD)]
						,[RewardDate]
						,[PointsAwarded]
						,[DescriptionText]
						,[InsertedDateTime]
						,[UpdatedDateTime]
						,[UpdatedDateID]
					)
					VALUES
					(	 source.[ContactID]
						,source.[dacadoo_ID]
						,source.[EventID]
						,source.[Dollar Value (USD)]
						,source.[RewardDate]
						,source.[PointsAwarded]
						,source.[DescriptionText]
						,@CurrentDate
						,@CurrentDate
						,CONVERT(VARCHAR(8),  @CurrentDate, 112   )
					);





        IF @LastLoadDate IS NULL
            INSERT INTO [dbo].[CTRL_TableLoadDate]
            VALUES
            ('dbo.STG_ActivityChallenge', @LoadDate)
        ELSE
            UPDATE dbo.[CTRL_TableLoadDate]
            SET [LoadDate] = @CurrentDate
            WHERE [TableName] = 'dbo.STG_ActivityChallenge'

    END




END TRY
BEGIN CATCH

    --CAPTURE AND RAISE ERRORS

    DECLARE @ErrorNumber INT
    DECLARE @ErrorSeverity INT
    DECLARE @ErrorState INT
    DECLARE @ErrorMessage nvarchar(4000)

    SET @ErrorNumber = ERROR_NUMBER()
    SET @ErrorSeverity = ERROR_SEVERITY()
    SET @ErrorState = ERROR_STATE()
    SET @ErrorMessage = CONVERT(NVARCHAR(4000), @ProcedureName + ':: ' + ERROR_MESSAGE())

    INSERT INTO [dbo].[CTRL_ErrorLog]
    VALUES
    (@CurrentDate, @ProcedureName, @ErrorNumber, @ErrorSeverity, @ErrorState, @ErrorMessage);

    RAISERROR(@ProcedureName, @ErrorSeverity, @ErrorState);

END CATCH
GO
