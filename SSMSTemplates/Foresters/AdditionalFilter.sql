select Count(*)
FROM [dbo].[For_memberprofileExtensionBase] [a]
WHERE NOT EXISTS(SELECT 1 FROM [dbo].[For_memberprofileBase] [b]
			WHERE [a].For_memberprofileId = [b].For_memberprofileId
			AND [b].[StatusCode] IN (2,3))
