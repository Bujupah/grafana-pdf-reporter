import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:image/image.dart';

class Photo {
  
  Photo(this.image, this.label, {this.url = '', this.width, this.height});
  int width;
  int height;
  Image image;
  String url;
  String label;
  
  PdfImage getImg(pw.Document pdf) => image != null ? PdfImage(
    pdf.document,
    image: image.data.buffer.asUint8List(),
    width: width ?? image.width,
    height: height ?? image.height,
  ) : null;
}