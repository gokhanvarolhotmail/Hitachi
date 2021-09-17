SELECT
'type',
    [k].[FactHYBSCD_1]
  , [k].[EventID]
  , [k].[GUID]
  , [k].[dacadoo_ID]
  , [k].[RewardDateTime]
  , [k].[RewardDateID]
  , [k].[RewardYear]
  , [k].[DescriptionText]
  , [k].[Points]
  , [k].[Source]
  , [k].[InsertedDateTime]
  , [k].[InsertedDateID]
  , [k].[EventRewardSequence]
  , [k].[FLAG_Exported]
  FROM [dbo].[Fact_RewardPoints] k
      WHERE [dacadoo_ID] = '6052f80e4cab0612e60442fa'
	  UNION all
  SELECT
  'xxx',
    [k].[FactHYBSCD_1]
  , [k].[EventID]
  , [k].[GUID]
  , [k].[dacadoo_ID]
  , [k].[RewardDateTime]
  , [k].[RewardDateID]
  , [k].[RewardYear]
  , [k].[DescriptionText]
  , [k].[Points]
  , [k].[Source]
  , [k].[InsertedDateTime]
  , [k].[InsertedDateID]
  , [k].[EventRewardSequence]
  , [k].[FLAG_Exported]
FROM( SELECT
          [FactHYBSCD_1]
        , [EventID]
        , [GUID]
        , [dacadoo_ID]
        , [RewardDateTime]
        , [RewardDateID]
        , [RewardYear]
        , [DescriptionText]
        , SUM([Points]) OVER ( PARTITION BY [GUID] ) AS [Points]
        , [Source]
        , [InsertedDateTime]
        , [InsertedDateID]
        , [EventRewardSequence]
        , [FLAG_Exported]
        , ROW_NUMBER() OVER ( PARTITION BY [GUID] ORDER BY [EventRewardSequence] DESC ) AS [Row]
      FROM [dbo].[Fact_RewardPoints]
      WHERE [dacadoo_ID] = '6052f80e4cab0612e60442fa' ) AS [k]
WHERE [k].[Row] = 1 ;

  SELECT * FROM STG_DacadooID
  WHERE dacadoo_id = '6052f80e4cab0612e60442fa'

  SELECT * FROM STG_GrantsConnect_CIMemberLed
  WHERE dacadoo_id = '6052f80e4cab0612e60442fa'


  SELECT 'select * from ' + t.name + ' WHERE for_memberprofile_id = ''2F6647D3-90D1-EA11-8E3B-005056824D17'''FROM sys.tables t INNER JOIN sys.columns c ON t.object_id = c.object_id AND c.name = 'for_memberprofile_id'


select * from STG_ActivityChallenge WHERE dacadoo_id = '6052f80e4cab0612e60442fa'
select * from STG_ActivityChallenge_LOAD WHERE dacadoo_id = '6052f80e4cab0612e60442fa'
select * from Fact_RewardPoints WHERE dacadoo_id = '6052f80e4cab0612e60442fa'
select * from Fact_RewardPoints_EXPORT WHERE dacadoo_id = '6052f80e4cab0612e60442fa'
select * from STG_DacadooID WHERE dacadoo_id = '6052f80e4cab0612e60442fa'



select * from STG_ActivityChallenge WHERE contactid = '2F6647D3-90D1-EA11-8E3B-005056824D17'
select * from STG_ActivityChallenge_LOAD WHERE contactid = '2F6647D3-90D1-EA11-8E3B-005056824D17'


select * from STG_For_memberprofileExtensionBase_LOAD WHERE for_memberprofile_id = '2F6647D3-90D1-EA11-8E3B-005056824D17'
