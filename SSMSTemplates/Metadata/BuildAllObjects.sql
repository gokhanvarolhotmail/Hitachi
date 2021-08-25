DECLARE
    @CntStart  INT = 0
  , @CntEnd    INT = 1
  , @Iteration INT = 0
  , @SQL       NVARCHAR(MAX) ;

WHILE @CntEnd > @CntStart
    BEGIN
        SET @Iteration = @Iteration + 1 ;

        SELECT @CntStart = COUNT(1)
        FROM [sys].[objects] ;

        SELECT
            @SQL =
            STRING_AGG(
                CONCAT(
                    CAST(NULL AS NVARCHAR(MAX)), 'IF OBJECT_ID(''', [d].[FQN], ''') IS NULL
BEGIN TRY
EXEC(''', REPLACE([d].[definition], '''', ''''''), ''')
END TRY
BEGIN CATCH
	PRINT CONCAT(''Type: ', [d].[type_desc], ', Object: ', [d].[FQN]
                  , '
Error.. Message: '',ERROR_MESSAGE(), ''
Error.. Line: '', ERROR_LINE(), '', ErrorNumber: '',ERROR_NUMBER(), '', Severity: '', ERROR_SEVERITY(), '', State: '',ERROR_STATE(),''

'')
END CATCH
'), '
')
        FROM( SELECT * FROM [dbo].[Definition] ) AS [d] ;

        IF @SQL <> ''
            EXEC( @SQL ) ;

        SELECT @CntEnd = COUNT(1)
        FROM [sys].[objects] ;

        PRINT CONCAT('----------- Current Iteration:', @Iteration, ', CntStart: ', @CntStart, ', CntEnd: ', @CntEnd) ;
    END ;
GO
