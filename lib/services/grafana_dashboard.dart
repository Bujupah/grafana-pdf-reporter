import 'package:dio/dio.dart';
import 'package:reporter/grafana/dashboard.dart';
import 'package:reporter/reporter.dart';

class GrafanaService {
  GrafanaDashboard grafana;
  final List<String> fileNames = [];
  
  Future dashboardInfo(String from, String to, String theme, String uid, String token) async {
    if(token.isEmpty && grafanaApiToken.isEmpty)
      throw Exception('Missing token');

    try {
      final response = await Dio().get("$grafanaDashboardApi/$uid",
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer ${token ?? grafanaApiToken}'
          }
        )
      );
      grafana = GrafanaDashboard.fromResponseV7(response.data, theme, from, to);      
    } on DioError catch(e) {
        throw Exception(e.message);
    }
  }

  Future<void> downloadPanels(String token) async {
    int count = 0;

    while(count != grafana.panelsId.length){
      final element = grafana.panelsId[count];
      final String fileName = '$element-${grafana.uid}-${DateTime.now().millisecondsSinceEpoch}.png';
      await downloadPanel(grafana.panelsId[count], fileName, token);
      fileNames.add(fileName);
      count++;
    }

  }

  Future<String> downloadPanel(int id, String fileName, String token) async {
    final String panelUrl = '$grafanaPanelApi/${grafana.uid}?from=${grafana.from}&to=${grafana.to}&panelId=$id&theme=${grafana.theme}&height=500&width=1000';

    final Directory _appDocDirFolder = Directory('${Directory.current.path}/${reportsFolder}/${grafana.uid}');
    
    if(!_appDocDirFolder.existsSync())
      await _appDocDirFolder.create(recursive: true);

    final filePath = '${_appDocDirFolder.path}/$fileName';
    try {
      return await Dio().download(panelUrl, filePath,
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer ${token ?? grafanaApiToken}',
            'Content-Disposition': 'attachment;filename="$fileName"',
            'Content-Type': 'image/png',
            'Accept': 'image/png'
          }
        )
      ).then((v){
        print('                  - Panel ${id} finished rendering and has been downloaded on ($filePath)');
        return fileName;
      });
    } on DioError catch(e) {
      print('Error on Panel ${id} rendering.');
      throw Exception(e.message);
    }
  } 
}