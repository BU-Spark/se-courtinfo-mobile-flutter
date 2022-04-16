import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class viewDocumentScreen extends StatefulWidget {
  @override
  _viewDocumentScreenState createState() => _viewDocumentScreenState();
}

class _viewDocumentScreenState extends State<viewDocumentScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Document View"),
          centerTitle: true,
        ),
        body: Container(
          child: PDFView(
            filePath: "assets/SampleTaxReturn.pdf",
          ),
        ));
  }
}
