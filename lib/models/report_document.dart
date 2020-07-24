import 'package:reporter/reporter.dart';

class ReportDocumentModel extends ManagedObject<_ReportDocumentModel> implements _ReportDocumentModel {}

class _ReportDocumentModel{
  
  @Column(defaultValue: 'NOW()')
  DateTime createdAt;
  @Column(defaultValue: 'NOW()')
  DateTime updatedAt;

  @primaryKey
  int id;
  
  
  @Column(defaultValue: 'NOW()')
  DateTime startedAt;

  @Column(defaultValue: 'NOW()')
  DateTime lastRunAt;
  @Column(defaultValue: 'NOW()')
  DateTime nextRunAt;
  
  @Column()
  int taskId;
  @Column(nullable: true)
  String taskName;
  @Column(nullable: true)
  String taskDescription;
  
  @Column(nullable: true)
  String schedule;
  
  @Column(defaultValue: 'false')
  bool jobIsRunning;
  @Column(defaultValue: 'false')
  bool isEnabled;

}