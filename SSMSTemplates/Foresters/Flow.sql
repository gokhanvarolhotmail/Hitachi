RETURN
-- PL_SQL_ASQL_DacadooID
TRUNCATE TABLE [dbo].[STG_For_memberprofileExtensionBase_LOAD]
EXEC [dbo].[spOverwriteDacadooID] /* Not Needed */

-- PL_SFTP_ADLG2_ACTIVITYCHALLENGE
	-- PL_ADLG2_ASQLDB_ACTIVITYCHALLENGE_REWARDS
	TRUNCATE TABLE [dbo].[STG_ActivityChallenge_LOAD]
	EXEC [dbo].[spOverwriteActivityChallenge]
	EXEC [dbo].[SP_Fact_RewardsPoints_LOAD]


-- PL_DACADOO_REWARDPOINTS_MASTER
EXEC [dbo].[SP_Fact_RewardPointsExport]
	-- PL_ASQL_API_DACADOO_REWARDPOINTS
	EXEC [dbo].[lookup_Fact_RewardPoints_EXPORT]
