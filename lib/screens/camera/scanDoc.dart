import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cunning_document_scanner/cunning_document_scanner.dart';

class ScanDoc extends StatefulWidget {
  const ScanDoc({super.key});

  @override
  _ScanDoc createState() => _ScanDoc();
}

class _ScanDoc extends State<ScanDoc> {
  List<String> _pictures = [];

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }
  
  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // Initialize the camera view
    List<String> pictures;
    try {
      pictures = await CunningDocumentScanner.getPictures() ?? [];
      if (!mounted) return;
      setState(() {
        _pictures = pictures;
      });
    } catch (exception) {
      // Handle exception here
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            ElevatedButton(
                onPressed: onPressed, child: const Text("Add Pictures")),
            for (var picture in _pictures) Image.file(File(picture))
          ],
        )),
      ),
    );
  }

  void onPressed() async {
    List<String> pictures;
    try {
      pictures = await CunningDocumentScanner.getPictures() ?? [];
      if (!mounted) return;
      setState(() {
        _pictures = pictures;
      });
    } catch (exception) {
      // Handle exception here
    }
  }

}

