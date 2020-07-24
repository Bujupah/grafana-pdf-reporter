/// reporter
///
/// A Aqueduct web server.
library reporter;

export 'dart:async';
export 'dart:io';

export 'package:aqueduct/aqueduct.dart';

export 'channel.dart';

export 'controllers/report_document.dart';
export 'models/report_document.dart';
export 'repositories/report_document.dart';
export 'services/report_document.dart';

const reportsFolder = 'reports';

//! Grafana info
const grafanaHost = 'localhost';
const grafanaPort = 3000;
const grafanaApiToken = 'eyJrI.......';

const grafanaDashboardApi = 'http://$grafanaHost:$grafanaPort/api/dashboards/uid';
const grafanaPanelApi = 'http://$grafanaHost:$grafanaPort/render/d-solo';

//! Generated Document
const keepFilesAfterGeneration = false;
const keepExistanceAfterGenerationWithSeconds = 30;

//! Mailer
const enableMailer = true;

//! Mailer type = GMAIL | HOTMAIL | YAHOO | QQ | MAILGUN
const mailerType = 'gmail';

//! Mailer info
const username = 'example@gmail.com';
const password = 'password';

//! Mail info
const mailerName = 'Khalil';
const mailerSubject = 'Grafana Reporting - Document';
const mailerText = 'Please check the attachment(s) below';


