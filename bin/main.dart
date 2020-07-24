import 'package:reporter/reporter.dart';

// Todo; use logger instead of print;)


Future main() async {
  final app = Application<ReporterChannel>()
      ..options.configurationFilePath = "config.yaml"
      ..options.port = 8888;
  
  final count = Platform.numberOfProcessors ~/ 2;
  await app.start(numberOfInstances: count > 0 ? count : 1);


  final Directory _appDocDirFolder = Directory('${Directory.current.path}/${reportsFolder}');
  if(!_appDocDirFolder.existsSync())
    await _appDocDirFolder.create(recursive: true);

  print("Application started on port: ${app.options.port}.");
  print("Use Ctrl-C (SIGINT) to stop running the application.");
}