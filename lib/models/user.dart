class User {
  int userId;
  String name;
  String email;
  String type;
  String token;
  // String renewalToken;

  User(
      {required this.userId,
      required this.name,
      required this.email,
      required this.type,
      required this.token,
      // required this.renewalToken
      });

  // now create converter

  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
      userId: responseData['id'],
      name: responseData['Username'],
      email: responseData['Email'],
       type : responseData['type'],
       token: responseData['token'],
      //  renewalToken : responseData['token'],
    );
  }
}
