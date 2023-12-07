import 'dart:io';
import 'package:courtinfo_spark/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DocumentObject {
  final String name;
  final String description;
  final int minPageCount;
  final bool variablePageCount;
  final int form_type;

  DocumentObject({
    required this.name,
    required this.description,
    required this.minPageCount,
    required this.variablePageCount,
    required this.form_type,
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
        form_type: 3),
    DocumentObject(
      name: "Criminal Complaint Form",
      description: "A form for criminal complaint",
      minPageCount: 3,
      variablePageCount: false,
      form_type: 2,
    ),
    DocumentObject(
      name: "Defendant Demographic Information",
      description: "A form for defendant demographic information",
      minPageCount: 2,
      variablePageCount: false,
      form_type: 1,
    ),
  ]; // Initialize this list with objects from API, will replace with after getting the real API

  DocumentObject? selectedDocument;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(0, 10, 34, 100),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xffffffff),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             GestureDetector(
              onTap: () {
                context.goNamed('home');
              },
              child: Container(
                padding: const EdgeInsets.fromLTRB(22, 30, 0, 0),
                child: Icon(Icons.arrow_back),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(width*0.19, height*0.1, 0, 72),
              width: 234,
              height: 272,
              child: const Image(
                  width: 234,
                  height: 272,
                  image: AssetImage("lib/assets/scanImage.png")),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(40, 0, 1, 38),
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
               margin: const EdgeInsets.fromLTRB(42, 0, 0, 0),
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
              margin: const EdgeInsets.fromLTRB(140, 0, 0, 0),
              child: FloatingActionButton.extended(
                  onPressed: () => {
                        if (selectedDocument != null)
                          {
                            // pass the selectedDocument.minPageCount to the scanning page.
                            context.goNamed('scanDocScreen', queryParameters: {
                              'name' : selectedDocument?.name,
                              'minPageCount':
                                  selectedDocument!.minPageCount.toString(),
                              'form_type':
                                  selectedDocument!.form_type.toString()
                            }),
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
