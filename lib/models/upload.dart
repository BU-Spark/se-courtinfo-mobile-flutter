class UploadFile {
  final int id;
  // final String form_type;
  // final String form_id;
  final String path;

  UploadFile({
    required this.id,
    // required this.form_type,
    // required this.form_id,
    required this.path,
  });


  factory UploadFile.fromJson(Map<String, dynamic> responseData) {
    return UploadFile(
      id: responseData['Id'],
      // form_type: responseData['Form_type'],
      // form_id: responseData['Form_id'],
      path: responseData['path'],
    );
  }
}