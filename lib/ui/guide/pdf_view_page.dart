import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:yqy_flutter/widgets/pdf/MyPDFViewer.dart';
///
///   查看PDF的页面
///
class PdfViewPage extends StatefulWidget {
  @override
  _PDFViewPageState createState() => _PDFViewPageState();
}

class _PDFViewPageState extends State<PdfViewPage> {


  String path;
  PDFDocument document;
  bool _isLoading = true;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        title: Text("文献指南"),
      ),

     body: Container(

       child: _isLoading?Center(child: CircularProgressIndicator(),):MyPDFViewer(
         document: document,
       ),

     )

    );
  }



  initData() async {
    //http://conorlastowka.com/book/CitationNeededBook-Sample.pdf
  //http://www.africau.edu/images/default/sample.pdf
    document = await PDFDocument.fromURL(
        "http://conorlastowka.com/book/CitationNeededBook-Sample.pdf");
    setState(() => _isLoading = false);

  }


}

Future<File> createFileOfPdfUrl() async {
  final url = "http://africau.edu/images/default/sample.pdf";
  final filename = url.substring(url.lastIndexOf("/") + 1);
  var request = await HttpClient().getUrl(Uri.parse(url));
  var response = await request.close();
  var bytes = await consolidateHttpClientResponseBytes(response);
  String dir = (await getApplicationDocumentsDirectory()).path;
  File file = new File('$dir/$filename');
  await file.writeAsBytes(bytes);
  return file;
}
