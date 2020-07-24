import 'package:reporter/reporter.dart';

class ReportDocumentController extends ResourceController{
  ReportDocumentController(this.context){
    reportDocumentService = ReportDocumentService(context); 
  }
  final ManagedContext context;
  ReportDocumentService reportDocumentService;
  
  @Operation.get('dashboard')
  Future<Response> select(
    @Bind.query('from') String from,
    @Bind.query('to') String to,
    @Bind.query('token') String token,
    @Bind.query('theme') String theme,
    @Bind.path('dashboard') String dashboard,
  ) async {
    return await reportDocumentService.select(from, to, theme, dashboard, token);
  }

  @Operation.post()
  Future<Response> create() async {
    return Response.ok({});
  }
}