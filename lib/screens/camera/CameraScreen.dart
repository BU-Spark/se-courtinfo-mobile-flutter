import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DocumentObject {
  final String name;
  final String description;
  final int minPageCount;
  final bool variablePageCount;

  DocumentObject({
    required this.name,
    required this.description,
    required this.minPageCount,
    required this.variablePageCount,
  });
}

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  _CameraScreen createState() => _CameraScreen();
}

class _CameraScreen extends State<CameraScreen> {
  List<DocumentObject> documents = [
    DocumentObject(
      name: "Bond Tracking Form",
      description: "A bond tracking form for Fairfax county",
      minPageCount: 3,
      variablePageCount: false,
    ),
    DocumentObject(
      name: "Criminal Complain Form",
      description: "A form for criminal complaint",
      minPageCount: 3,
      variablePageCount: false,
    ),
  ]; // Initialize this list with objects from API

  DocumentObject? selectedDocument;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(34, 150, 34, 87),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xffffffff),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 72),
              width: 234,
              height: 272,
              child: const Image(
                  width: 234,
                  height: 272,
                  image: AssetImage("lib/assets/scanImage.png")),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 1, 38),
              constraints: const BoxConstraints(
                maxWidth: 345,
              ),
              child: const Text(
                'Which documents do you want to upload?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  height: 1.2125,
                  color: Color(0xff1f2c5c),
                ),
              ),
            ),
            Container(
              child: DropdownButton<DocumentObject>(
                value: selectedDocument,
                onChanged: (DocumentObject? newValue) {
                  setState(() {
                    selectedDocument = newValue;
                  });
                },
                items: documents.map((DocumentObject document) {
                  return DropdownMenuItem<DocumentObject>(
                    value: document,
                    child: Text(document.name),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: FloatingActionButton.extended(
                  onPressed: () => {
                    if (selectedDocument != null) {
                    // pass the selectedDocument.minPageCount to the scanning page.
                    context.goNamed('scanDocScreen', queryParameters: {'minPageCount': selectedDocument!.minPageCount.toString()}),
                  }
                  },
                  heroTag: 'camera_continue',
                  label: const Text('Continue'),
                  backgroundColor: const Color(0xff1f2c5c)),
            ),
          ],
        ),
      ),
    );
  }
}
