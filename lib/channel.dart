import 'package:reporter/reporter.dart';

class ReporterChannel extends ApplicationChannel {

  ManagedContext context;

  @override
  Future prepare() async {
    logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));

    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final server = ServerConfig(options.configurationFilePath);

    final persistentStore = PostgreSQLPersistentStore(
      server.database.username, 
      server.database.password, 
      server.database.host, 
      server.database.port, 
      server.database.databaseName
    );

    context = ManagedContext(dataModel, persistentStore);
    
  }

  @override
  void willStartReceivingRequests() {
    super.willStartReceivingRequests();
    logger.shout('Will start receiving requests');
  }

  @override
  Controller get entryPoint => Router()
  
    ..route('/api/generate/report/:dashboard')
      .link(() => ReportDocumentController(context))

    ..route("/api/reporter/*")
      .link(() => FileController(reportsFolder));
}

class ServerConfig extends Configuration {
  ServerConfig(String path): super.fromFile(File(path));
  DatabaseConfiguration database;
}