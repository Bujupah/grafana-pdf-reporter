import 'package:reporter/reporter.dart';

class ReportDocumentRepository {
  
  ReportDocumentRepository(this.context);
  final ManagedContext context;

  Future<List<ReportDocumentModel>> selectAll() async {
    final list = <ReportDocumentModel>[];

    return Future.value(list);  
  }

  Future<ReportDocumentModel> selectOne(int id) async {
    final doc = ReportDocumentModel();
    
    return Future.value(doc);
  }

}