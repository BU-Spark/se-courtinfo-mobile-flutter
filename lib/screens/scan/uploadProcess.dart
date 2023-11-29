import 'dart:developer';

import 'package:courtinfo_spark/screens/scan/uploadResult.dart';
import 'package:flutter/material.dart';

import '../../providers/upload_provider.dart';

class UploadProcessPage extends StatefulWidget {
  final List<String> pictures;

  UploadProcessPage({
    required this.pictures,
  });

  @override
  _UploadProcessPageState createState() => _UploadProcessPageState();
}

class _UploadProcessPageState extends State<UploadProcessPage> {
  @override
  Widget build(BuildContext context) {
    UploadProvider().uploadFiles(widget.pictures).then((success) {
      // Navigate to result page based on the success status
      bool isSuccess = success['status'];
      log('upload status: $isSuccess');
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
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(
                    strokeWidth: 6, // Increase stroke width for a bigger icon
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xff1f2c5c)), // Set icon color to dark blue
                  ),
                ),
                 SizedBox(height: 20),
                Text(
                  'Processing...',
                  style: TextStyle(
                    fontSize: 26, 
                     fontWeight: FontWeight.w500,
                    color: Color(0xff1f2c5c), 
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
