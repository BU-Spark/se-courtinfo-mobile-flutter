class FormObject {
  final String name;
  final String description;
  final int minPageCount;
  final bool variablePageCount;
  final int form_type;

  FormObject({
    required this.name,
    required this.description,
    required this.minPageCount,
    required this.variablePageCount,
    required this.form_type,
  });
}
