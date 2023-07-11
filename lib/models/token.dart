class Token {
  String tokenType;
  String accessToken;

  Token({
    required this.tokenType,
    required this.accessToken,
  });


  factory Token.fromJson(Map<String, dynamic> responseData) {
    return Token(
      tokenType: responseData['token_type'],
      accessToken: responseData['access_token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token_type': tokenType,
      'access_token': accessToken,
    };
  }
}
