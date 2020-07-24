import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:reporter/reporter.dart';

class DocumentMailer{

  
  SmtpServer smtpServer;

  void makeMailer(){
    switch (mailerType.toLowerCase()) {
      case 'gmail': smtpServer = gmail(username, password);
      break;
      
      case 'hotmail': smtpServer = hotmail(username, password);
      break;
      
      case 'yahoo': smtpServer = yahoo(username, password);
      break;
      
      case 'qq': smtpServer = qq(username, password);
      break;

      case 'mailgun': smtpServer = mailgun(username, password);
      break;
      
      default: print('Grafana Reporting - Mailer type is not selected');
    }

    print('');
  }

  // Create our message.
  void sendAttachement(String name, List<String> recipients, File file, {
      List<String> ccRecipients, 
      List<Address> bccRecipients,
    }) async {
      if(smtpServer == null) 
        return;
    final message = Message()
    ..from = Address(username, name)
    ..recipients.addAll(recipients)
    ..ccRecipients.addAll(ccRecipients ?? [])
    ..bccRecipients.addAll(bccRecipients ?? [])
    ..subject = mailerSubject ?? 'Grafana Reporting'
    ..text = mailerText ?? ''
    ..attachments = [FileAttachment(file)];

    try {
      
      final sendReport = await send(message, smtpServer);
      final List<String> lines = sendReport.toString().split('\n');
      print('Grafana Reporting - Mailer');
      lines.forEach((element) {
        print('                  - $element');
      });

    } on MailerException catch (e) {
      print('Grafana Reporting - Message not sent.');
      print(e.message);
      for (var p in e.problems) {
        print('Grafana Reporting - Problem: ${p.code}: ${p.msg}');
      }
    }
  }  
}