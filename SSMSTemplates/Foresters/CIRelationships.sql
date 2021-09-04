SELECT
	[Column1], [Column2], [Column3], [Column4]
FROM (VALUES
('YourCause', 'FinalQuery_GrantsConnect_CI_MemberLed', 'Many', ''),
('CRM2011', 'Filtered_CustomerProfile', 'One', 'CIMemberLedActivityFeed'),
('YourCause', 'CommunityInitiativeMemberLed', 'Many', ''),
('CRM2011', 'Filtered_CustomerProfile', 'One', 'EventRegistrationActivity'),
('YourCauseCSRConnect', 'EventRegistration', 'Many', ''),
('CRM2011', 'Filtered_CustomerProfile', 'One', 'ForestersGoActivityFeed'),
('CRM2011', 'ForestersGo', 'Many', ''),
('CRM2011', 'Filtered_CustomerProfile', 'One', 'GrantApplications'),
('YourCause', 'GrantApplications', 'Many', ''),
('CRM2011', 'Filtered_CustomerProfile', 'One', 'MakeAnImpact'),
('YourCause', 'FinalQuery_GrantsConnect_MakeAnImpact', 'Many', ''),
('CRM2011', 'Filtered_CustomerProfile', 'One', 'MakeanImpactActivityFeed'),
('YourCause', 'MakeAnIMPACT', 'Many', ''),
('CRM2011', 'Filtered_CustomerProfile', 'One', 'RewardPointsTable'),
('Rewards', 'FinalQuery_RewardPoints', 'Many', ''),
('CRM2011', 'Filtered_CustomerProfile', 'One', 'RewardsActivityFeed'),
('Rewards', 'PointRewards', 'Many', ''),
('CRM2011', 'Filtered_CustomerProfile', 'One', ''))
vdata ([Column1], [Column2], [Column3], [Column4])


SELECT
	[Column1], [Column2], [Column3], [Column4], [Column5]
FROM (VALUES
('CIMemberLed', 'Many', 'CRM2011', 'Filtered_CustomerProfile', 'One'),
('CIMemberLedActivityFeed', 'Many', 'CRM2011', 'Filtered_CustomerProfile', 'One'),
('EventRegistrationActivity', 'Many', 'CRM2011', 'Filtered_CustomerProfile', 'One'),
('ForestersGoActivityFeed', 'Many', 'CRM2011', 'Filtered_CustomerProfile', 'One'),
('GrantApplications', 'Many', 'CRM2011', 'Filtered_CustomerProfile', 'One'),
('MakeAnImpact', 'Many', 'CRM2011', 'Filtered_CustomerProfile', 'One'),
('MakeanImpactActivityFeed', 'Many', 'CRM2011', 'Filtered_CustomerProfile', 'One'),
('RewardPointsTable', 'Many', 'CRM2011', 'Filtered_CustomerProfile', 'One'),
('RewardsActivityFeed', 'Many', 'CRM2011', 'Filtered_CustomerProfile', 'One'))
vdata ([Column1], [Column2], [Column3], [Column4], [Column5])
