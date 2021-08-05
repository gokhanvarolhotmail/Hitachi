/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [FactHYBSCD_1]
      ,[EventID]
      ,[GUID]
      ,[dacadoo_ID]
      ,[RewardDateTime]
      ,[RewardDateID]
      ,[RewardYear]
      ,[DescriptionText]
      ,[Points]
      ,[Source]
      ,[InsertedDateTime]
      ,[InsertedDateID]
      ,[EventRewardSequence]
      ,[FLAG_Exported]
  FROM [dbo].[Fact_RewardPoints]
  WHERE dacadoo_id = '6052f80e4cab0612e60442fa'


  SELECT * FROM STG_DacadooID
  WHERE dacadoo_id = '6052f80e4cab0612e60442fa'

  SELECT * FROM STG_GrantsConnect_CIMemberLed
  WHERE dacadoo_id = '6052f80e4cab0612e60442fa'


  SELECT 'select * from ' + t.name + ' WHERE for_memberprofile_id = ''2F6647D3-90D1-EA11-8E3B-005056824D17'''FROM sys.tables t INNER JOIN sys.columns c ON t.object_id = c.object_id AND c.name = 'for_memberprofile_id'


 select * from Fact_RewardPoints_20210624 WHERE dacadoo_id = '6052f80e4cab0612e60442fa'
select * from STG_ActivityChallenge_20210715 WHERE dacadoo_id = '6052f80e4cab0612e60442fa'
select * from STG_ActivityChallenge_LOAD_20210715 WHERE dacadoo_id = '6052f80e4cab0612e60442fa'
select * from STG_ActivityChallenge WHERE dacadoo_id = '6052f80e4cab0612e60442fa'
select * from STG_ActivityChallenge_LOAD WHERE dacadoo_id = '6052f80e4cab0612e60442fa'
select * from Fact_RewardPoints WHERE dacadoo_id = '6052f80e4cab0612e60442fa'
select * from Fact_RewardPoints_EXPORT WHERE dacadoo_id = '6052f80e4cab0612e60442fa'
select * from STG_DacadooID WHERE dacadoo_id = '6052f80e4cab0612e60442fa'



select * from STG_ActivityChallenge WHERE contactid = '2F6647D3-90D1-EA11-8E3B-005056824D17'
select * from STG_ActivityChallenge_LOAD WHERE contactid = '2F6647D3-90D1-EA11-8E3B-005056824D17'


select * from STG_For_memberprofileExtensionBase_LOAD WHERE for_memberprofile_id = '2F6647D3-90D1-EA11-8E3B-005056824D17'
