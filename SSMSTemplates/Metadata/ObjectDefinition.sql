SELECT CONCAT('IF SCHEMA_ID(''', [name], ''') IS NULL EXEC(''CREATE SCHEMA ', [name], ''')
GO
')  AS [SQL]
FROM [sys].[schemas] ;
GO
SELECT
    [s].[name] AS [SchemaName]
  , [o].[name] AS [ObjectName]
  , QUOTENAME([s].[name]) + '.' + QUOTENAME([o].[name]) AS [FQN]
  , [o].[type]
  , [o].[type_desc]
  , LEN([m].[definition]) AS [DefLen]
  , [m].[definition]
  , CONCAT(
        'IF OBJECT_ID(''' , QUOTENAME([s].[name]) + '.' + QUOTENAME([o].[name]), ''') IS NOT NULL DROP '
      , CASE WHEN [o].[type] LIKE '%F%' THEN 'FUNCTION' WHEN [o].[type] = 'V' THEN 'VIEW' WHEN [o].[type] = 'P' THEN 'PROCEDURE' WHEN [o].[type] LIKE '%t%' THEN
                                                                                                                                 'TRIGGER' END, ' '
      , QUOTENAME([s].[name]) + '.' + QUOTENAME([o].[name]), '
GO
', [m].[definition], '
GO
') AS [SQL]
FROM [sys].[objects] AS [o]
INNER JOIN [sys].[schemas] AS [s] ON [o].[schema_id] = [s].[schema_id]
INNER JOIN [sys].[all_sql_modules] AS [m] ON [m].[object_id] = [o].[object_id]
WHERE 1 = 1 ;
GO
-- Definition Scripts

DECLARE @Val NVARCHAR(MAX) = N'[SchemaName], [ObjectName], [FQN], [type], [type_desc], [create_date], [modify_date], [definition]' ;

SELECT CONCAT('SELECT
', @Val, '
FROM(VALUES') AS [SQL]
UNION ALL
SELECT
    CONCAT(
        CAST('(' AS NVARCHAR(MAX)), '''', REPLACE([s].[name], '''', ''''''), ''', ''', REPLACE([o].[name], '''', ''''''), ''', '''
      , REPLACE(QUOTENAME([s].[name]) + '.' + QUOTENAME([o].[name]), '''', ''''''), ''', ''', TRIM([o].[type])COLLATE SQL_Latin1_General_CP1_CI_AS, ''', '''
      , [o].[type_desc] COLLATE SQL_Latin1_General_CP1_CI_AS, ''', ''', CONVERT(VARCHAR(30), [o].[create_date], 121), ''', '''
      , CONVERT(VARCHAR(30), [o].[modify_date], 121), ''', ''', REPLACE([m].[definition], '''', ''''''), '''),') AS [SQL]
FROM [sys].[objects] AS [o]
INNER JOIN [sys].[schemas] AS [s] ON [o].[schema_id] = [s].[schema_id]
INNER JOIN [sys].[all_sql_modules] AS [m] ON [m].[object_id] = [o].[object_id]
UNION ALL
SELECT CONCAT(')[d] (', @Val, ')') AS [SQL] ;
GO