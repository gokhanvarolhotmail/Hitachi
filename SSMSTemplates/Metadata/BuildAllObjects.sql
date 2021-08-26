SELECT
    [s].[name] AS [SchemaName]
  , [o].[name] AS [ObjectName]
  , [o].[type]
  , [o].[type_desc]
  , [o].[create_date]
  , [o].[modify_date]
  , CONCAT(
        'IF OBJECT_ID(''' , QUOTENAME([s].[name]), '.', QUOTENAME([o].[name]), ''') IS NOT NULL DROP '
      , CASE WHEN [o].[type] = 'V' THEN 'VIEW' WHEN [o].[type] = 'P' THEN 'PROCEDURE' WHEN [o].[type] = 'TR' THEN 'TRIGGER' WHEN [o].[type] LIKE '%f%' THEN
                                                                                                                            'FUNCTION' END, '
GO
') AS [DropSQL]
FROM [sys].[objects] AS [o]
INNER JOIN [sys].[schemas] AS [s] ON [o].[schema_id] = [s].[schema_id]
WHERE( [o].[type] IN ('V', 'TR', 'P') OR [o].[type] LIKE '%F%' )
ORDER BY [o].[type]
       , [s].[name]
       , [o].[name] ;
GO
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
