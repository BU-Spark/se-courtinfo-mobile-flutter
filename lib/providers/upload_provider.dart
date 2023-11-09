// import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../utility/app_url.dart';
import '../models/upload.dart';

class UploadProvider extends ChangeNotifier {
  // final Dio _dio = Dio(); // Initialize the Dio instance for making HTTP requests

  List<UploadFiles> _uploadedFiles = [];
  List<UploadFiles> get uploadedFiles => _uploadedFiles;

  Future<void> uploadFiles(List<UploadFiles> files) async {
    try {
      Uri uploadUri = Uri.parse(AppUrl.upload);

      final requestBody = {
        'files': files,
        'form_type': 1,
        'form_id': 1,
      };

      final response = await http.post(
        uploadUri,
        body: requestBody, // Convert the Map to a JSON string
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        print('Upload succeeded');
      } else {
        print('Upload failed with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (error) {
      // handle error
    }
  }
}
