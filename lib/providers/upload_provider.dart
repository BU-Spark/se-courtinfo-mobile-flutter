// import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../utility/app_url.dart';
import '../models/upload.dart';
import 'dart:developer';

class UploadProvider extends ChangeNotifier {
  var result;
  var status;

  List<UploadFile> _uploadedFiles = [];
  List<UploadFile> get uploadedFiles => _uploadedFiles;
  Uri uploadUri = Uri.parse(AppUrl.upload);
  List<List<dynamic>> _docList = [
    ['1', "ddi", "2023 Dec-02 15:32", "Success"],
    ['2', "ddi", "2023 Dec-02 15:54", "Failed"]
  ];
  List<List<dynamic>> get getDocFiles => _docList;

  void storeUploadList(List<dynamic> uploadDoc) {
    //uploadDoc: [doc_id, doc name, submission date, submission status]
    _docList.add(uploadDoc);
    print('store doc List $getDocFiles');
    // fetchUploadListDocuments();
    notifyListeners();
  }

  void updateUploadList(String id, bool status) {
    // Find the index of the document with the given ID
    int index = getDocFiles.indexWhere((doc) => doc[0] == id);

    if (index != -1) {
      // Update the status of the document at the found index
      getDocFiles[index][3] = status ? 'Success' : 'Failed';
      print('Updated Doc List: $getDocFiles');
      // fetchUploadListDocuments();
      notifyListeners();
    } else {
      log('Document with ID $id not found.');
    }
  }

  Future<List<List<dynamic>>> fetchUploadListDocuments() async {

    // Simulating an asynchronous data fetch, e.g., fetching from an API
    await Future.delayed(Duration(seconds: 1));
    print('fetched document list: $_docList');
    return _docList;
  }

  Future<Map<String, dynamic>> uploadFiles(
      List<String> filePaths, int formType) async {
    Uri updateUri = uploadUri.replace(queryParameters: {'form_type': formType});
    try {
      var request = http.MultipartRequest(
        'POST',
        updateUri,
      );

      request.fields['form_type'] = '$formType';
      print('Form type recognized in uploadFiles API: ${request.fields['form_type']}');

      for (var path in filePaths) {
        var file = await http.MultipartFile.fromPath('files', path);
        request.files.add(file);
      }

      var response = await request.send();
      if (response.statusCode == 200) {

        print('uploadProvider: Upload succeeded $response');
        status = "Success";

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
