SELECT
    [s].[name] AS [SchemaName]
  , [o].[name] AS [ObjectName]
  , QUOTENAME([s].[name]) + '.' + QUOTENAME([o].[name]) AS [FQN]
  , [o].[create_date]
  , [o].[modify_date]
  , CONCAT(
        'IF OBJECT_ID(''' , QUOTENAME([s].[name]) + '.' + QUOTENAME([o].[name]), ''', ''U'') IS NULL PRINT '''
        , QUOTENAME([s].[name]) + '.' + QUOTENAME([o].[name]), '''') AS [TableCheck]
FROM [sys].[schemas] AS [s]
INNER JOIN [sys].[objects] AS [o] ON [o].[schema_id] = [s].[schema_id]
WHERE [o].[type] = 'U'
ORDER BY 1
       , 3 ;