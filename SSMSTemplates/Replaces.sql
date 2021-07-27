SELECT
TOP(9999999)	[Dev], [Prod]
FROM (VALUES
('Membership360DataFactory', 'Membership360DataFactory-Prod'),
('https://membership360storage.dfs.core.windows.net/', 'https://membership360storageprod.dfs.core.windows.net/'),
('https://HitachiKV.vault.azure.net/', 'https://HitachiKV-Prod.vault.azure.net/'),
('membership360sql.database.windows.net', 'membership360sql-prod.database.windows.net'),
('Membership360Rewards', 'Membership360RewardsProd'),
('https://prod-02.canadacentral.logic.azure.com:443/workflows/7136b6d6311940129e3ebefbe131ed8a/triggers/manual/paths/invoke?api-version=2016-10-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=GYhYps7Vd3kG3li1Qc5nHrZwzfeYEBVK1i_DuppiD4E', 'https://prod-14.canadacentral.logic.azure.com:443/workflows/ed1ffb0f532b4db686d100b9a169cb76/triggers/manual/paths/invoke?api-version=2016-10-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=muZdaTz2Ug6qVaapmGvOajwMKDUfMxZ-tXpsn78Zg6M'),
('https://prod-00.canadacentral.logic.azure.com/workflows/62c85e63c1d44c979001c69a2f498ed0/triggers/request/paths/invoke?api-version=2016-10-01&sp=%2Ftriggers%2Frequest%2Frun&sv=1.0&sig=2UA0xJd7A0NfzNvjsjRmy9aLoe9nhNI-KWam85490Wk', 'https://prod-17.canadacentral.logic.azure.com:443/workflows/0e4bb8e8ac1a4724938a23488066b3d8/triggers/manual/paths/invoke?api-version=2016-10-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=oeFph1om0iSZV8Kuy4qGtxxyrKioqe8jane9hCGaChQ'),
('https://membership360-azfunc-dacadooapi.azurewebsites.net', 'https://membership360-azfunc-dacadooapi-prod.azurewebsites.net'))
vdata ([Dev], [Prod])
ORDER BY LEN([Dev]) desc


SELECT
	[Dev], [Prod]
FROM (VALUES
('Membership360DataFactory', 'Membership360DataFactory-Prod'),
('azuredatafactoryfailures@foresters.com', 'adminmembership360@foresters.onmicrosoft.com'),
('https://membership360-azfunc-dacadooapi.azurewebsites.net', 'https://membership360-azfunc-dacadooapi-prod.azurewebsites.net'))
vdata ([Dev], [Prod])
