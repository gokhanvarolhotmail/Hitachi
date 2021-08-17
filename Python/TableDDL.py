dbs = spark.catalog.listDatabases()
for db in dbs:
  f = open("your_file_name_{}.ddl".format(db.name), "w")
  tables = spark.catalog.listTables(db.name)
  for t in tables:
    DDL = spark.sql("SHOW CREATE TABLE {}.{}".format(db.name, t.name))
    f.write(DDL.first()[0])
    f.write("\n")
f.close()


dbs = spark.catalog.listDatabases()
for db in dbs:
	tables = spark.catalog.listTables(db.name)
	for t in tables:
		DDL = spark.sql("SHOW CREATE TABLE {}.{}".format(db.name, t.name))
		print(DDL.first()[0])
		print("GO")
f.close()
