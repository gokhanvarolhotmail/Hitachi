dbs = spark.catalog.listDatabases()
CombinedDDL = ""
for db in dbs:
    tables = spark.catalog.listTables(db.name)
    for t in tables:
        DDL = spark.sql("SHOW CREATE TABLE {}.{}".format(db.name, t.name))
        CombinedDDL = CombinedDDL + "\n\n--------------------------\n\n" + DDL.first()[0]
dbutils.fs.put("/FileStore/gvarol/ALL_DDL.txt", CombinedDDL)


https://adb-6202383808415066.6.azuredatabricks.net/files/gvarol/ALL_DDL.txt


dbs = spark.catalog.listDatabases()
for db in dbs:
	tables = spark.catalog.listTables(db.name)
	for t in tables:
		DDL = spark.sql("SHOW CREATE TABLE {}.{}".format(db.name, t.name))
		print(DDL.first()[0])
		print("\n\n----------------------------------------------------------------\n\n")

