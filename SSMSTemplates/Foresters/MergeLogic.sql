CREATE PROCEDURE [dbo].[spOverwriteActivityChallenge]
AS
    BEGIN TRY
        SET NOCOUNT ON ;

        DECLARE
            @CurrentDate   DATETIME     = CONVERT(DATETIME, GETDATE())AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time'
          , @LastLoadDate  DATETIME
          , @InsertedDate  DATETIME     = CONVERT(DATETIME, GETDATE())AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time'
          , @ProcedureName VARCHAR(100) = 'dbo.spOverwriteActivityChallenge' ;

        SET @LastLoadDate = ( SELECT MAX([LoadDate])FROM [dbo].[CTRL_TableLoadDate] WHERE [TableName] = 'dbo.STG_ActivityChallenge' ) ;

        MERGE [dbo].[STG_ActivityChallenge] AS [t]
        USING( SELECT
                   [ContactID]
                 , [dacadoo_ID]
                 , [EventID]
                 , [Dollar Value (USD)]
                 , [RewardDate]
                 , [PointsAwarded]
                 , REPLACE(REPLACE([DescriptionText], CHAR(10), CHAR(32)), CHAR(13), CHAR(32)) AS [DescriptionText]
               FROM [dbo].[STG_ActivityChallenge_LOAD] ) AS [s]
        ON [t].[dacadoo_ID] = [s].[dacadoo_ID]
       AND [t].[EventID] = [s].[EventID]
       AND [t].[ContactID] = [s].[ContactID]
       AND [t].[DescriptionText] = [s].[DescriptionText]
       AND [t].[RewardDate] = [s].[RewardDate]
       AND [t].[PointsAwarded] <> [s].[PointsAwarded]
        WHEN MATCHED THEN UPDATE SET
                              [t].[PointsAwarded] = [t].[PointsAwarded] + [s].[PointsAwarded]
                            , [t].[Dollar Value (USD)] = [t].[Dollar Value (USD)] + [s].[Dollar Value (USD)]
                            , [t].[UpdatedDateTime] = @CurrentDate
                            , [t].[UpdatedDateID] = CONVERT(VARCHAR(8), CAST(@CurrentDate AS DATE), 112)
        WHEN NOT MATCHED THEN
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
                      [s].[ContactID]
                    , [s].[dacadoo_ID]
                    , [s].[EventID]
                    , [s].[Dollar Value (USD)]
                    , [s].[RewardDate]
                    , [s].[PointsAwarded]
                    , [s].[DescriptionText]
                    , @CurrentDate
                    , @CurrentDate
                    , CONVERT(VARCHAR(8), @CurrentDate, 112)
                  ) ;

        IF @LastLoadDate IS NULL
            INSERT INTO [dbo].[CTRL_TableLoadDate]
            VALUES( 'dbo.STG_ActivityChallenge', @CurrentDate ) ;
        ELSE
            UPDATE [dbo].[CTRL_TableLoadDate]
            SET [LoadDate] = @CurrentDate
            WHERE [TableName] = 'dbo.STG_ActivityChallenge' ;
    END TRY
    BEGIN CATCH
        INSERT INTO [dbo].[CTRL_ErrorLog]
        VALUES( @CurrentDate, @ProcedureName, ERROR_NUMBER(), ERROR_SEVERITY(), ERROR_STATE(), CONCAT(@ProcedureName, ':: ', ERROR_MESSAGE())) ;
        ;

        THROW ;
    END CATCH ;
GO
