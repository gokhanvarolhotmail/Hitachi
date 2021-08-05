CREATE PROCEDURE [dbo].[spOverwriteActivityChallenge]
AS
    BEGIN TRY
        SET NOCOUNT ON ;

        DECLARE @CurrentDate DATETIME ;
        DECLARE @LastLoadDate DATETIME ;
        DECLARE @LoadDate DATETIME ;
        DECLARE @ReseedKey BIGINT ;
        DECLARE @InsertedDate DATETIME ;
        DECLARE @ProcedureName VARCHAR(100) ;

        SET @ProcedureName = 'dbo.spOverwriteActivityChallenge' ;
        SET @CurrentDate = CONVERT(DATETIME, GETDATE())AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' ;
        SET @LastLoadDate = ( SELECT MAX([LoadDate])FROM [dbo].[CTRL_TableLoadDate] WHERE [TableName] = 'dbo.STG_ActivityChallenge' ) ;
        SET @InsertedDate = CONVERT(DATETIME, GETDATE())AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' ;

        BEGIN
            MERGE [dbo].[STG_ActivityChallenge] AS [target]
            USING( SELECT
                       [ContactID]
                     , [dacadoo_ID]
                     , [EventID]
                     , [Dollar Value (USD)]
                     , [RewardDate]
                     , [PointsAwarded]
                     , REPLACE(REPLACE([DescriptionText], CHAR(10), CHAR(32)), CHAR(13), CHAR(32)) AS [DescriptionText]
                   FROM [dbo].[STG_ActivityChallenge_LOAD]
                   WHERE [dacadoo_ID] IS NOT NULL AND [EventID] IS NOT NULL AND [ContactID] IS NOT NULL ) AS [source]
            ON [target].[dacadoo_ID] = [source].[dacadoo_ID]
           AND [target].[EventID] = [source].[EventID]
           AND [target].[ContactID] = [source].[ContactID]
           AND ( /*Condition 1*/ [target].[PointsAwarded] = [source].[PointsAwarded]
               AND [target].[DescriptionText] = [source].[DescriptionText]
               OR
               /*Condition 2*/ [target].[RewardDate] = [source].[RewardDate]
             AND [target].[DescriptionText] = [source].[DescriptionText]
             AND [target].[PointsAwarded] <> [source].[PointsAwarded]
             AND NOT( /*Condition 1*/ [target].[PointsAwarded] = [source].[PointsAwarded] AND [target].[DescriptionText] = [source].[DescriptionText] ))
            WHEN MATCHED THEN
                UPDATE SET
                    [target].[RewardDate] = [source].[RewardDate]
                  , [target].[PointsAwarded] = CASE WHEN [target].[PointsAwarded] = [source].[PointsAwarded]
                                                    AND [target].[DescriptionText] = [source].[DescriptionText] THEN [source].[PointsAwarded] ELSE [target].[PointsAwarded] + [source].[PointsAwarded] END
                  , [target].[Dollar Value (USD)] = [source].[Dollar Value (USD)]
                  , [target].[DescriptionText] = [source].[DescriptionText]
                  , [target].[UpdatedDateTime] = @CurrentDate
                  , [target].[UpdatedDateID] = CONVERT(VARCHAR(8), CAST(@CurrentDate AS DATE), 112)
            WHEN NOT MATCHED THEN --Null record values do not merge and serve no function in rewarding so they are excluded
                INSERT( [ContactID]
                      , [dacadoo_ID]
                      , [EventID]
                      , [Dollar Value (USD)]
                      , [RewardDate]
                      , [PointsAwarded]
                      , [DescriptionText]
                      , [InsertedDateTime]
                      , [UpdatedDateTime]
                      , [UpdatedDateID] )
                VALUES(
                          [source].[ContactID]
                        , [source].[dacadoo_ID]
                        , [source].[EventID]
                        , [source].[Dollar Value (USD)]
                        , [source].[RewardDate]
                        , [source].[PointsAwarded]
                        , [source].[DescriptionText]
                        , @CurrentDate
                        , @CurrentDate
                        , CONVERT(VARCHAR(8), @CurrentDate, 112)
                      ) ;

            IF @LastLoadDate IS NULL
                INSERT INTO [dbo].[CTRL_TableLoadDate]
                VALUES( 'dbo.STG_ActivityChallenge', @LoadDate ) ;
            ELSE
                UPDATE [dbo].[CTRL_TableLoadDate]
                SET [LoadDate] = @CurrentDate
                WHERE [TableName] = 'dbo.STG_ActivityChallenge' ;
        END ;
    END TRY
    BEGIN CATCH

        --CAPTURE AND RAISE ERRORS
        DECLARE @ErrorNumber INT ;
        DECLARE @ErrorSeverity INT ;
        DECLARE @ErrorState INT ;
        DECLARE @ErrorMessage NVARCHAR(4000) ;

        SET @ErrorNumber = ERROR_NUMBER() ;
        SET @ErrorSeverity = ERROR_SEVERITY() ;
        SET @ErrorState = ERROR_STATE() ;
        SET @ErrorMessage = CONVERT(NVARCHAR(4000), @ProcedureName + ':: ' + ERROR_MESSAGE()) ;

        INSERT INTO [dbo].[CTRL_ErrorLog]
        VALUES( @CurrentDate, @ProcedureName, @ErrorNumber, @ErrorSeverity, @ErrorState, @ErrorMessage ) ;

        RAISERROR(@ProcedureName, @ErrorSeverity, @ErrorState) ;
    END CATCH ;