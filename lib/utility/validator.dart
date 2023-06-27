class Validator {
  static bool validateEmail(String email) {
    // Use a regular expression to validate the email format
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[a-zA-Z\d-]+(\.[a-zA-Z\d-]+)*\.[a-zA-Z\d]{2,}$');
    return emailRegex.hasMatch(email);
  }
}