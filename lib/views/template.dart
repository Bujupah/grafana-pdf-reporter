import 'package:image/image.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:reporter/grafana/dashboard.dart';
import 'package:reporter/reporter.dart';
import 'package:reporter/views/photo.dart';

class Template1{

  Template1(this.name, this.grafana);
  final String name;
  final GrafanaDashboard grafana;
  final doc = pw.Document();

  File pdf;
  
  Future prepareImages(List<String> imagesPath) async {
    final List<Photo> graphsData = [];
    imagesPath.forEach((element) async {
      final file = File('${Directory.current.path}/reports/${grafana.uid}/$element');
      final list = file.readAsBytesSync();
      final image = decodeImage(list);
      final Photo p = Photo(
        image, element, 
        url: '/api/reporter/${grafana.uid}/$element',
      );
      graphsData.add(p);
    });

    final List<pw.Widget> images = [];
    graphsData.forEach((element) {
      images.add(
      pw.Container(
        padding: const pw.EdgeInsets.all(16),
        alignment: pw.Alignment.center,
        child: pw.UrlLink(
          child: pw.Image(
            element.getImg(doc),
            alignment: pw.Alignment.center
          ),
          destination: element.url,
        ),
      ));
    });
    await createPdf(images);
  }
  
  Future createPdf(List<pw.Widget> images) async {
    print('Grafana Reporting - Document is being processed');
    doc.addPage(
      pw.MultiPage(
        footer: (pw.Context context) =>  pw.Footer(
          trailing: pw.Text('Page ${context.pageNumber} / ${context.pagesCount}',
            style: pw.Theme.of(context).defaultTextStyle.copyWith(color: PdfColors.grey)),
          leading: pw.Text(grafana.title),
        ),
        header: (pw.Context context) => context.pageNumber == 1 ? pw.Header(
            padding: const pw.EdgeInsets.all(4),
            margin: const pw.EdgeInsets.all(4),
            level: 3,
            text: 'Test',
            child: pw.Container(
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Grafana Reporting'),
                  pw.Text('${grafana.folder} - ${grafana.title}')
                ]
              )
            ),
          )
        : pw.Container(),
        build: (pw.Context context) => images
      )
    );
    await savePdf(grafana.uid);
  }

  Future savePdf(String folder) async{
    print('Grafana Reporting - Document is saved locally in (${Directory.current.path}/reports/$folder/$name.pdf)');
    pdf = File('${Directory.current.path}/reports/$folder/$name.pdf');
    pdf.writeAsBytesSync(doc.save());
  }
}