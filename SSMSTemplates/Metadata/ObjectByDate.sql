SELECT GETDATE()
SELECT
    QUOTENAME([s].[name]) + '.' + QUOTENAME([o].[name]) AS [FQN]
  , [s].[name] AS [SchemaName]
  , [o].[name] AS [ObjectName]
  , [o].[type]
  , [o].[type_desc]
  , [o].[create_date]
  , [o].[modify_date]
FROM [sys].[objects] AS [o]
INNER JOIN [sys].[schemas] AS [s] ON [o].[schema_id] = [o].[schema_id]
WHERE [o].[modify_date] >= '2021-08-24 14:37:11.607' 