DROP TABLE IF EXISTS ##Prod
SELECT
	[Column1], [Column2], [Column3], [Column4]
INTO ##Prod
FROM (VALUES
('First Name', 'Filtered_CustomerProfile', 1, 'CRM2011'),
('Middle Name', 'Filtered_CustomerProfile', 2, 'CRM2011'),
('Last Name', 'Filtered_CustomerProfile', 3, 'CRM2011'),
('Full Name', 'Filtered_CustomerProfile', 4, 'CRM2011'),
('Birth Date', 'Filtered_CustomerProfile', 5, 'CRM2011'),
('Email Address 1', 'Filtered_CustomerProfile', 6, 'CRM2011'),
('Email Address 2', 'Filtered_CustomerProfile', 7, 'CRM2011'),
('Telephone', 'Filtered_CustomerProfile', 8, 'CRM2011'),
('Language', 'Filtered_CustomerProfile', 9, 'CRM2011'),
('GUID', 'Filtered_CustomerProfile', 10, 'CRM2011'),
('Mobile Phone', 'Filtered_CustomerProfile', 11, 'CRM2011'),
('Address', 'Filtered_CustomerProfile', 12, 'CRM2011'),
('City', 'Filtered_CustomerProfile', 13, 'CRM2011'),
('Portal Registration Date', 'Filtered_CustomerProfile', 14, 'CRM2011'),
('Member Start Date', 'Filtered_CustomerProfile', 15, 'CRM2011'),
('Foresters Go Registered User', 'Filtered_CustomerProfile', 16, 'CRM2011'),
('Foresters Go Registered Status', 'Filtered_CustomerProfile', 17, 'CRM2011'),
('Foresters Community Member Status', 'Filtered_CustomerProfile', 18, 'CRM2011'),
('Member Status', 'Filtered_CustomerProfile', 19, 'CRM2011'),
('Member Type', 'Filtered_CustomerProfile', 20, 'CRM2011'),
('Tenure', 'Filtered_CustomerProfile', 21, 'CRM2011'),
('Tenure Years', 'Filtered_CustomerProfile', 22, 'CRM2011'),
('Postal Code', 'Filtered_CustomerProfile', 23, 'CRM2011'),
('State/Province', 'Filtered_CustomerProfile', 24, 'CRM2011'),
('Country', 'Filtered_CustomerProfile', 25, 'CRM2011'),
('Branch Name', 'Filtered_CustomerProfile', 26, 'CRM2011'),
('Region Name', 'Filtered_CustomerProfile', 27, 'CRM2011'),
('Household ID', 'Filtered_CustomerProfile', 28, 'CRM2011'),
('Household Name', 'Filtered_CustomerProfile', 29, 'CRM2011'),
('Foresters Go Employee Member', 'Filtered_CustomerProfile', 30, 'CRM2011'),
('For_memberprofileId', 'Merge', 31, 'CRM2011'),
('Foresters Go ID', 'Filtered_CustomerProfile', 32, 'CRM2011'),
('Foresters Go Membership Region', 'Filtered_CustomerProfile', 33, 'CRM2011'),
('Foresters Go Membership Branch', 'Filtered_CustomerProfile', 34, 'CRM2011'),
('Foresters Go Member Profile ID', 'Filtered_CustomerProfile', 35, 'CRM2011'))
vdata ([Column1], [Column2], [Column3], [Column4])



DROP TABLE IF EXISTS ##Dev
SELECT
	[Column1], [Column2], [Column3], [Column4]
INTO ##Dev
FROM (VALUES
('First Name', 'Filtered_CustomerProfile', 1, 'CRM2011'),
('Middle Name', 'Filtered_CustomerProfile', 2, 'CRM2011'),
('Last Name', 'Filtered_CustomerProfile', 3, 'CRM2011'),
('Full Name', 'Filtered_CustomerProfile', 4, 'CRM2011'),
('Birth Date', 'Filtered_CustomerProfile', 5, 'CRM2011'),
('Email Address 1', 'Filtered_CustomerProfile', 6, 'CRM2011'),
('Email Address 2', 'Filtered_CustomerProfile', 7, 'CRM2011'),
('Telephone', 'Filtered_CustomerProfile', 8, 'CRM2011'),
('Language', 'Filtered_CustomerProfile', 9, 'CRM2011'),
('GUID', 'Filtered_CustomerProfile', 10, 'CRM2011'),
('Mobile Phone', 'Filtered_CustomerProfile', 11, 'CRM2011'),
('Address', 'Filtered_CustomerProfile', 12, 'CRM2011'),
('City', 'Filtered_CustomerProfile', 13, 'CRM2011'),
('Portal Registration Date', 'Filtered_CustomerProfile', 14, 'CRM2011'),
('Member Start Date', 'Filtered_CustomerProfile', 15, 'CRM2011'),
('Foresters Go Registered User', 'Filtered_CustomerProfile', 16, 'CRM2011'),
('Foresters Go Registered Status', 'Filtered_CustomerProfile', 17, 'CRM2011'),
('Foresters Community Member Status', 'Filtered_CustomerProfile', 18, 'CRM2011'),
('Member Status', 'Filtered_CustomerProfile', 19, 'CRM2011'),
('Member Type', 'Filtered_CustomerProfile', 20, 'CRM2011'),
('Tenure', 'Filtered_CustomerProfile', 21, 'CRM2011'),
('Tenure Years', 'Filtered_CustomerProfile', 22, 'CRM2011'),
('Postal Code', 'Filtered_CustomerProfile', 23, 'CRM2011'),
('State/Province', 'Filtered_CustomerProfile', 24, 'CRM2011'),
('Country', 'Filtered_CustomerProfile', 25, 'CRM2011'),
('Branch Name', 'Filtered_CustomerProfile', 26, 'CRM2011'),
('Region Name', 'Filtered_CustomerProfile', 27, 'CRM2011'),
('Household ID', 'Filtered_CustomerProfile', 28, 'CRM2011'),
('Household Name', 'Filtered_CustomerProfile', 29, 'CRM2011'),
('Foresters Go Employee Member', 'Filtered_CustomerProfile', 30, 'CRM2011'),
('For_memberprofileId', 'Merge', 31, 'CRM2011'),
('Foresters GO ID', 'Filtered_CustomerProfile', 32, 'CRM2011'),
('Foresters Go Membership Region', 'Filtered_CustomerProfile', 33, 'CRM2011'),
('Foresters Go Membership Branch', 'Filtered_CustomerProfile', 34, 'CRM2011'),
('Foresters Go Member Profile ID', 'Filtered_CustomerProfile', 35, 'CRM2011'))
vdata ([Column1], [Column2], [Column3], [Column4])


SELECT * FROM [##Dev]
SELECT * FROM [##Prod]


SELECT *
FROM [##Prod] AS [p]
WHERE NOT EXISTS ( SELECT 1 FROM [##Dev] AS [d] WHERE [d].[Column1] = [p].[Column1] AND [d].[Column2] = [p].[Column2] )
ORDER BY TRY_CAST([p].[Column3] AS INT) ;



SELECT *
FROM [##Dev] AS [p]
WHERE NOT EXISTS ( SELECT 1 FROM [##Prod] AS [d] WHERE [d].[Column1] = [p].[Column1] AND [d].[Column2] = [p].[Column2] )
ORDER BY TRY_CAST([p].[Column3] AS INT) ;


SELECT *
FROM [##Dev] AS [p]
WHERE NOT EXISTS ( SELECT 1 FROM [##Prod] AS [d] WHERE [d].[Column1] = [p].[Column1] AND [d].[Column2] = [p].[Column2] )
AND EXISTS ( SELECT 1 FROM [##Prod] AS [d] WHERE REPLACE([d].[Column1], ' ','') = [p].[Column1] AND [d].[Column2]= [p].[Column2] )
ORDER BY TRY_CAST([p].[Column3] AS INT) ;

SELECT *
FROM [##Prod] AS [a]
INNER JOIN [##Dev] AS [b] ON [a].[Column1] = [b].[Column1]
WHERE [a].[Column3] <> [b].[Column3]
ORDER BY [a].[Column3] ;


SELECT *
FROM [##Dev] AS [p]
WHERE EXISTS ( SELECT 1 FROM [##Prod] AS [d] WHERE [d].[Column1] = [p].[Column1] AND [d].[Column2] = [p].[Column2] )
ORDER BY TRY_CAST([p].[Column3] AS INT) ;


SELECT * FROM ##Dev d FULL OUTER JOIN ##Prod p