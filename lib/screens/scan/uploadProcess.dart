import 'dart:developer';
import 'dart:math' as math;
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';

import 'package:courtinfo_spark/screens/scan/uploadResult.dart';
import 'package:flutter/material.dart';

import '../../providers/upload_provider.dart';

class UploadProcessPage extends StatefulWidget {
  final List<String> pictures;
  final int form_type;
  final String name;

  UploadProcessPage({
    required this.pictures,
    required this.form_type,
    required this.name,
  });

  @override
  _UploadProcessPageState createState() => _UploadProcessPageState();
}

class _UploadProcessPageState extends State<UploadProcessPage> {
  @override
  Widget build(BuildContext context) {
    DateTime currentTime = DateTime.now();
    String id = (math.Random().nextInt(9000) + 1000).toString();
    String formattedTime = DateFormat('HH:mm:ss').format(currentTime);
    // List<dynamic> docList = [id, widget.name, formattedTime, "Processing"]; //[doc_id, doc name, submission date, submission status]

    // UploadProvider().storeUploadList(docList);
    UploadProvider()
        .uploadFiles(widget.pictures, widget.form_type)
        .then((success) {
      // Navigate to result page based on the success status
      bool isSuccess = success['status'];
      print('upload status: $isSuccess');
      // UploadProvider().updateUploadList(id, isSuccess);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => UploadResultPage(isSuccess)),
      );
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 180, 20, 180),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(
                    strokeWidth: 6, // Increase stroke width for a bigger icon
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xff1f2c5c)), // Set icon color to dark blue
                  ),
                ),
                SizedBox(height: 20),
                const Text(
                  'Processing...',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff1f2c5c),
                  ),
                ),
                SizedBox(height: 20),
                 ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff1f2c5c),
                    ),
                    onPressed: () {
                     context.goNamed('home');
                    },
                    child: Text('Home'),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
