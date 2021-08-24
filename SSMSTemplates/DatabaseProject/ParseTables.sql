DROP TABLE IF EXISTS [##Files] ;
DROP TABLE IF EXISTS [##Contents] ;
DROP TABLE IF EXISTS [##Tables] ;

SELECT
    [b].[Directory]
  , [b].[FileName]
  , [b].[IsDirectory]
  , [b].[SizeGB]
  , [b].[SizeMB]
  , [b].[Size]
  , [b].[CreateDate]
  , [b].[LastWritten]
  , [b].[LastAccessed]
  , [b].[Attributes]
INTO [##Files]
FROM [Util].[FS].[GetDirectoryInfoRecursive]('C:\Temp\RCS_SqlDw\', '*') AS [b]
WHERE [b].[IsDirectory] = 0 ;

SELECT
    *
  , [Util].[FS].[ReadAllTextFromFile]([Directory] + '\' + [FileName]) AS [Contents]
INTO [##Contents]
FROM [##Files]
WHERE [FileName] LIKE '%.sql' ;

SELECT DISTINCT
       [k].[Directory]
     , [k].[FileName]
     , QUOTENAME(PARSENAME(TRIM([b].[C1]), 1)) + '.' + QUOTENAME(PARSENAME(TRIM([b].[C2]), 1)) AS [FQN]
     , PARSENAME(TRIM([b].[C1]), 1) AS [SchemaName]
     , PARSENAME(TRIM([b].[C2]), 1) AS [TableName]
     , [k].[Field]
INTO [##Tables]
FROM( SELECT
          [k].[Directory]
        , [k].[FileName]
        , REPLACE(REPLACE([k].[Field], 'CREATE TABLE', ''), ' (', '') AS [TableName]
        , [k].[Field]
      FROM( SELECT
                [c].[Directory]
              , [c].[FileName]
              , ( SELECT [OutVal] FROM [Util].[dbo].TrimBothEndsInline([Field]) ) AS [Field]
            FROM [##Contents] AS [c]
            CROSS APPLY [Util].[dbo].ParseDelimited([c].[Contents], '
')              AS [b]
            WHERE [b].[Field] LIKE '%create%table%'
              AND [b].[Field] NOT LIKE '-- Create%'
              AND [c].[Directory] NOT LIKE '%\stored p%'
              AND [c].[Directory] NOT LIKE '%\r[0-9]%' ) AS [k] ) AS [k]
CROSS APPLY [Util].[dbo].[ParseDelimitedColumns32]([k].[TableName], '.') AS [b] ;
GO

SELECT [p].[Field]
FROM [Util].[dbo].ParseDelimited(
         '[dbo].[PROPERTY_DIM]
[detailedpl].[PROPERTY_DIM]
[hospitality_DW].[PROPERTY_DIM]
[industrial_3nf_stage].[PROPERTY_DIM]
[industrial_DW2].[PROPERTY_DIM]
[industrial_DW].[PROPERTY_DIM]
[INFORMATION_SCHEMA].[PROPERTY_DIM]
[RCS_DW].[PROPERTY_DIM]
[Recon].[PROPERTY_DIM]
[stage].[PROPERTY_DIM]
[stage_hospitality_3nf].[PROPERTY_DIM]
[stage_industrial_3nf].[PROPERTY_DIM]
[stage_linkbatch_3nf].[PROPERTY_DIM]
[stage_rcs_3nf].[PROPERTY_DIM]
[stage_test_le].[PROPERTY_DIM]
[stage_workday_3nf].[PROPERTY_DIM]
[stg].[PROPERTY_DIM]
[sysdiag].[PROPERTY_DIM]
[sys].[PROPERTY_DIM]
[workday_DW].[PROPERTY_DIM]
[xSM].[PROPERTY_DIM]' , '
')  AS [p]
WHERE EXISTS ( SELECT 1 FROM [##Tables] AS [t] WHERE [t].[FQN] = [p].[Field] ) ;
GO
