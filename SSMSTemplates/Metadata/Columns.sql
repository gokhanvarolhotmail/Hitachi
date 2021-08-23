--IF OBJECT_ID('tempdb..[#Columns]') IS NOT NULL DROP TABLE [#Columns] ;

IF OBJECT_ID('tempdb..[#Columns]') IS NULL
SELECT
    QUOTENAME([s].[name]) + '.' + QUOTENAME([t].[name]) AS [FQL]
  , [s].[name] AS [SchemaName]
  , [t].[name] AS [TableName]
  , [c].[name] AS [ColumnName]
  , [y].[name] AS [DataType]
  , CAST(CASE WHEN [y].[name] = 'timestamp' THEN 'rowversion'
             WHEN [y].[name] IN ('char', 'varchar') THEN
                 CONCAT(
                     [y].[name], '(', CASE WHEN [c].[max_length] = -1 THEN 'MAX' ELSE CAST([c].[max_length] AS VARCHAR)END, ')'
                   , CASE WHEN [c].[collation_name] <> [d].[collation_name] THEN CONCAT(' COLLATE ', [c].[collation_name])ELSE '' END)
             WHEN [y].[name] IN ('nchar', 'nvarchar') THEN
                 CONCAT(
                     [y].[name], '(', CASE WHEN [c].[max_length] = -1 THEN 'MAX' ELSE CAST([c].[max_length] / 2 AS VARCHAR)END, ')'
                   , CASE WHEN [c].[collation_name] <> [d].[collation_name] THEN CONCAT(' COLLATE ', [c].[collation_name])ELSE '' END)
             WHEN [y].[name] IN ('binary', 'varbinary') THEN
                 CONCAT([y].[name], '(', CASE WHEN [c].[max_length] = -1 THEN 'MAX' ELSE CAST([c].[max_length] AS VARCHAR)END, ')')
             WHEN [y].[name] IN ('bigint', 'int', 'smallint', 'tinyint') THEN [y].[name]
             WHEN [y].[name] IN ('datetime2', 'time', 'datetimeoffset') THEN CONCAT([y].[name], '(', [c].[scale], ')')
             WHEN [y].[name] IN ('numeric', 'decimal') THEN CONCAT([y].[name], '(', [c].[precision], ', ', [c].[scale], ')')
             ELSE [y].[name]
         END AS VARCHAR(256)) AS [ColumnDef]
  , [c].[is_nullable]
INTO [#Columns]
FROM [sys].[tables] AS [t]
INNER JOIN [sys].[schemas] AS [s] ON [s].[schema_id] = [t].[schema_id]
INNER JOIN [sys].[columns] AS [c] ON [c].[object_id] = [t].[object_id]
INNER JOIN [sys].[types] AS [y] ON [y].[user_type_id] = [c].[user_type_id]
LEFT JOIN [sys].[databases] AS [d] ON [d].[name] = DB_NAME() ;

SELECT *
FROM [#Columns] ;
GO