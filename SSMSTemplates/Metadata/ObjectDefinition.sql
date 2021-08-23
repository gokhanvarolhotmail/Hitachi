SELECT
    [s].[name] AS [SchemaName]
  , [o].[name] AS [ObjectName]
  , [o].[type]
  , [o].[type_desc]
  , LEN([m].[definition]) AS [DefLen]
  , [m].[definition]
FROM [sys].[objects] AS [o]
INNER JOIN [sys].[schemas] AS [s] ON [o].[schema_id] = [s].[schema_id]
INNER JOIN [sys].[all_sql_modules] AS [m] ON [m].[object_id] = [o].[object_id]
WHERE 1 = 1 ;
