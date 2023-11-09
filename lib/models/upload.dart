class UploadFiles {
  final int id;
  final String form_type;
  final String form_id;
  final String status;

  UploadFiles({
    required this.id,
    required this.form_type,
    required this.form_id,
    required this.status,
  });


  factory UploadFiles.fromJson(Map<String, dynamic> responseData) {
    return UploadFiles(
      id: responseData['Id'],
      form_type: responseData['Form_type'],
      form_id: responseData['Form_id'],
      status: responseData['Status'],
    );
  }
}