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

SELECT CONCAT('DROP TABLE IF EXISTS [dbo].[Definition]
GO
SELECT
', @Val, '
INTO [dbo].[Definition]
FROM(VALUES') AS [SQL]
UNION ALL
SELECT
    CONCAT(
        CAST('(' AS NVARCHAR(MAX)), '''', REPLACE([s].[name], '''', ''''''), ''', ''', REPLACE([o].[name], '''', ''''''), ''', '''
      , REPLACE(QUOTENAME([s].[name]) + '.' + QUOTENAME([o].[name]), '''', ''''''), ''', ''', TRIM([o].[type])COLLATE SQL_Latin1_General_CP1_CI_AS, ''', '''
      , [o].[type_desc] COLLATE SQL_Latin1_General_CP1_CI_AS, ''', ''', CONVERT(VARCHAR(30), [o].[create_date], 121), ''', '''
      , CONVERT(VARCHAR(30), [o].[modify_date], 121), ''', '''
      , ( SELECT SUBSTRING([definition_Replaced], NULLIF([b].[NWL], 0), DATALENGTH([definition_Replaced]) - [b].[NWL] - [b].[NWR] + 2) AS [OutVal]
          FROM( SELECT
                    PATINDEX('%[^' + CHAR(32) + CHAR(9) + CHAR(13) + CHAR(10) + ']%', [definition_Replaced]) AS [NWL]
                  , PATINDEX('%[^' + CHAR(32) + CHAR(9) + CHAR(13) + CHAR(10) + ']%', REVERSE([definition_Replaced])) AS [NWR] ) AS [b] ), '''),') AS [SQL]
FROM [sys].[objects] AS [o]
INNER JOIN [sys].[schemas] AS [s] ON [o].[schema_id] = [s].[schema_id]
INNER JOIN( SELECT *, REPLACE([m].[definition], '''', '''''') AS [definition_Replaced] FROM [sys].[all_sql_modules] AS [m] ) AS [m] ON [m].[object_id] = [o].[object_id]
UNION ALL
SELECT CONCAT(')[d] (', @Val, ')
GO
SELECT
	',@Val,'
FROM [dbo].[Definition]') AS [SQL] ;
GO
