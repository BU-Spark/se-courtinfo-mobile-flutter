// import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../utility/app_url.dart';
import '../models/upload.dart';
import 'dart:developer';

class UploadProvider extends ChangeNotifier {
  var result;
  List<UploadFile> _uploadedFiles = [];
  List<UploadFile> get uploadedFiles => _uploadedFiles;
  Uri uploadUri = Uri.parse(AppUrl.upload);

  Future<Map<String, dynamic>> uploadFiles(List<String> filePaths) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        uploadUri,
      );

      for (var path in filePaths) {
        var file = await http.MultipartFile.fromPath('files', path);
        request.files.add(file);
      }

      var response = await request.send();
      if (response.statusCode == 200) {
        log('uploadProvider: Upload succeeded');
        return {'status': true}; 
      } else {

        log('Upload failed with status code: ${response.statusCode}');
         return {'status': false}; 
      }
    } catch (e) {
      // Exception handling
      return {'status': false};
    }
  }
}
