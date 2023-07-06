class User {
  int userId;
  String first_name;
  String last_name;
  String email;
  String tokenType;
  String accessToken;

  User({
    required this.userId,
    required this.first_name,
    required this.last_name,
    required this.email,
    required this.tokenType,
    required this.accessToken,
  });

  // now create converter

  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
      userId: responseData['id'],
      first_name: responseData['FirstName'],
      last_name: responseData['LastName'],
      email: responseData['Email'],
      tokenType: responseData['token_type'],
      accessToken: responseData['access_token'],
    );
  }
}
