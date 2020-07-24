import 'dart:async';
import 'package:aqueduct/aqueduct.dart';

class Migration1 extends Migration {
  @override
  Future upgrade() async {
    database.createTable(SchemaTable("_ReportDocumentModel", [
      SchemaColumn("createdAt", ManagedPropertyType.datetime,
          isPrimaryKey: false,
          autoincrement: false,
          defaultValue: "NOW()",
          isIndexed: false,
          isNullable: false,
          isUnique: false),
      SchemaColumn("updatedAt", ManagedPropertyType.datetime,
          isPrimaryKey: false,
          autoincrement: false,
          defaultValue: "NOW()",
          isIndexed: false,
          isNullable: false,
          isUnique: false),
      SchemaColumn("id", ManagedPropertyType.bigInteger,
          isPrimaryKey: true,
          autoincrement: true,
          isIndexed: false,
          isNullable: false,
          isUnique: false),
      SchemaColumn("startedAt", ManagedPropertyType.datetime,
          isPrimaryKey: false,
          autoincrement: false,
          defaultValue: "NOW()",
          isIndexed: false,
          isNullable: false,
          isUnique: false),
      SchemaColumn("lastRunAt", ManagedPropertyType.datetime,
          isPrimaryKey: false,
          autoincrement: false,
          defaultValue: "NOW()",
          isIndexed: false,
          isNullable: false,
          isUnique: false),
      SchemaColumn("nextRunAt", ManagedPropertyType.datetime,
          isPrimaryKey: false,
          autoincrement: false,
          defaultValue: "NOW()",
          isIndexed: false,
          isNullable: false,
          isUnique: false),
      SchemaColumn("taskId", ManagedPropertyType.integer,
          isPrimaryKey: false,
          autoincrement: false,
          isIndexed: false,
          isNullable: false,
          isUnique: false),
      SchemaColumn("taskName", ManagedPropertyType.string,
          isPrimaryKey: false,
          autoincrement: false,
          isIndexed: false,
          isNullable: false,
          isUnique: false),
      SchemaColumn("taskDescription", ManagedPropertyType.string,
          isPrimaryKey: false,
          autoincrement: false,
          isIndexed: false,
          isNullable: false,
          isUnique: false),
      SchemaColumn("schedule", ManagedPropertyType.string,
          isPrimaryKey: false,
          autoincrement: false,
          isIndexed: false,
          isNullable: false,
          isUnique: false),
      SchemaColumn("jobIsRunning", ManagedPropertyType.boolean,
          isPrimaryKey: false,
          autoincrement: false,
          isIndexed: false,
          isNullable: false,
          isUnique: false),
      SchemaColumn("isEnabled", ManagedPropertyType.boolean,
          isPrimaryKey: false,
          autoincrement: false,
          isIndexed: false,
          isNullable: false,
          isUnique: false)
    ]));
  }

  @override
  Future downgrade() async {}

  @override
  Future seed() async {}
}
