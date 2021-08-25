
SELECT CONCAT('USE [RCS_SqlDw_NoView]
GO
DROP VIEW IF EXISTS ', QUOTENAME([s].[name]), '.', QUOTENAME([o].[name]), '
GO
SELECT
*
INTO [RCS_SqlDw_NoView].', QUOTENAME([s].[name]), '.', QUOTENAME([o].[name]), '
FROM [RCS_SqlDw].', QUOTENAME([s].[name]), '.', QUOTENAME([o].[name]), '
WHERE 1 = 0
GO
')  AS [SQL]
FROM [RCS_SqlDw_NoView].[sys].[objects] AS [o]
INNER JOIN [RCS_SqlDw_NoView].[sys].[schemas] AS [s] ON [s].[schema_id] = [o].[schema_id] AND [o].[type] = 'V' ;
GO
