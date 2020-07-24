import 'package:reporter/reporter.dart';
import 'package:reporter/services/document_mailer.dart';
import 'package:reporter/services/grafana_dashboard.dart';
import 'package:reporter/views/template.dart';

class ReportDocumentService{

  ReportDocumentService(this.context){
    reportDocumentRepository = ReportDocumentRepository(context);
  }
  final ManagedContext context;
  ReportDocumentRepository reportDocumentRepository;

  Future<Response> select(String from, String to, String theme, String dashboard, String token) async{
    final grafanaService = GrafanaService();
    
    try{
      print('Grafana Reporting - Getting dashboard information...');
      await grafanaService.dashboardInfo(from, to, theme, dashboard, token);
      print('                  - Folder: ${grafanaService.grafana.folder}');
      print('                  - Dashboard: ${grafanaService.grafana.title}');
      print('                  - Dashboard UID: ${grafanaService.grafana.uid}');
      print('                  - Panels: ${grafanaService.grafana.panelsId}');
      print('                  - From: ${grafanaService.grafana.from}');
      print('                  - To: ${grafanaService.grafana.to}');
      print('                  - Theme: ${grafanaService.grafana.theme}');
      print('');
      print('Grafana Reporting - Rendering panels to images from Grafana');
      await grafanaService.downloadPanels(token);
      print('                  - Finished panels rendering total (${grafanaService.fileNames.length})...');
      print('');
      final docName = '$dashboard-${DateTime.now().millisecondsSinceEpoch}';
      final tmp = Template1(docName, grafanaService.grafana);
      await tmp.prepareImages(grafanaService.fileNames);
      
      if(enableMailer){
        final DocumentMailer mailer = DocumentMailer();
        mailer.makeMailer();
        mailer.sendAttachement(mailerName, ['khalil.mejdi97@gmail.com'], tmp.pdf);
      }else 
        print('Grafana Reporting - Mailer is disabled');

      if(!keepFilesAfterGeneration){
        print('Grafana Reporting - Generated document will be deleted after $keepExistanceAfterGenerationWithSeconds seconds.');
        print('');
        Future.delayed(const Duration(seconds: keepExistanceAfterGenerationWithSeconds), (){
          print('');
          print('Grafana Reporting - Deleting document ${tmp.pdf.path}');
          tmp.pdf.deleteSync();
        });
      }

      return Response.ok(tmp.pdf.openRead())
        ..encodeBody = false
        ..contentType = ContentType('application', 'pdf');
    
    }catch(e){
      print(e.message);
      return Response.notFound(body: e.message);
    }
  }  
}