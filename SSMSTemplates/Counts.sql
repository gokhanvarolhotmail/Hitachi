
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
GO
SELECT 'ContactExtensionBase' as [TableName], (SELECT COUNT(1) FROM [dbo].[ContactExtensionBase]),'[dbo].[ContactExtensionBase]' as [Query]
UNION ALL
SELECT 'ContactBase' as [TableName], (SELECT COUNT(1) FROM [dbo].[ContactBase]),'[dbo].[ContactBase]' as [Query]
UNION ALL
SELECT 'For_memberprofileExtensionBase' as [TableName], (SELECT COUNT(1) FROM [dbo].[For_memberprofileExtensionBase] AS [a] WHERE NOT EXISTS ( SELECT 1 FROM [dbo].[For_memberprofileBase] AS [b] WHERE [a].[For_memberprofileId] = [b].[For_memberprofileId] AND [b].[StatusCode] IN (2, 3))),'[dbo].[For_memberprofileExtensionBase] AS [a] WHERE NOT EXISTS ( SELECT 1 FROM [dbo].[For_memberprofileBase] AS [b] WHERE [a].[For_memberprofileId] = [b].[For_memberprofileId] AND [b].[StatusCode] IN (2, 3))' as [Query]
UNION ALL
SELECT 'For_memberprofileBase' as [TableName], (SELECT COUNT(1) FROM [dbo].[For_memberprofileBase]),'[dbo].[For_memberprofileBase]' as [Query]
UNION ALL
SELECT 'CustomerAddress' as [TableName], (SELECT COUNT(1) FROM [dbo].[CustomerAddress]),'[dbo].[CustomerAddress]' as [Query]
UNION ALL
SELECT 'For_householdExtensionBase' as [TableName], (SELECT COUNT(1) FROM [dbo].[For_householdExtensionBase]),'[dbo].[For_householdExtensionBase]' as [Query]
UNION ALL
SELECT 'For_branchExtensionBase' as [TableName], (SELECT COUNT(1) FROM [dbo].[For_branchExtensionBase]),'[dbo].[For_branchExtensionBase]' as [Query]
UNION ALL
SELECT 'StringMap' as [TableName], (SELECT COUNT(1) FROM [dbo].[StringMap]),'[dbo].[StringMap]' as [Query]
UNION ALL
SELECT 'Entity' as [TableName], (SELECT COUNT(1) FROM [MetadataSchema].[Entity]),'[MetadataSchema].[Entity]' as [Query]
UNION ALL
SELECT 'For_holding' as [TableName], (SELECT COUNT(1) FROM (SELECT for_generalapplicantid, min(For_issuedate) as For_issuedate FROM [dbo].[For_holding] group by for_generalapplicantid)[k]),'SELECT for_generalapplicantid, min(For_issuedate) as For_issuedate FROM [dbo].[For_holding] group by for_generalapplicantid' as [Query]
