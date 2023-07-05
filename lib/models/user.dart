class User {
  int userId;
  String first_name;
  String last_name;
  String email;
  String type;
  String token;
  // String renewalToken;

  User({
    required this.userId,
    required this.first_name,
    required this.last_name,
    required this.email,
    required this.type,
    required this.token,
    // required this.renewalToken
  });

  // now create converter

  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
      userId: responseData['id'],
      first_name: responseData['FirstName'],
      last_name: responseData['LastName'],
      email: responseData['Email'],
      type: responseData['type'],
      token: responseData['token'],
      //  renewalToken : responseData['token'],
    );
  }
}
