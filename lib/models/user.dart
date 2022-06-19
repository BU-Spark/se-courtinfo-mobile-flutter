class Token {
  final String accessToken;
  final String tokenType;

  const Token({required this.tokenType, required this.accessToken});

  factory Token.fromJson(Map<String, dynamic> json) {
    if (json['access_token'] != null && json['token_type'] != null) {
      return Token(
          accessToken: json['access_token'], tokenType: json['token_type']);
    } else {
      throw Exception("Unable to find properties: access_token or token-type");
    }
  }
}

class User {
  final String username;
  final Token? token;

  const User({required this.username, this.token});

  factory User.build(String user, Map<String, dynamic> tokenJson) {
    return User(username: user, token: Token.fromJson(tokenJson));
  }
}
